"""
FastAPI Backend for M-Pesa Integration
Complete REST API endpoints for Flutter app
"""

from fastapi import FastAPI, HTTPException, BackgroundTasks, Request
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel, Field
from typing import Optional, List
from datetime import datetime
import uvicorn
from mpesa_api import MpesaAPI
import os
from dotenv import load_dotenv

# Database imports (using SQLAlchemy)
from sqlalchemy import create_engine, Column, String, Float, DateTime, Integer, JSON
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker, Session
from fastapi import Depends

load_dotenv()

# Initialize FastAPI app
app = FastAPI(title="TumorHeal M-Pesa API", version="1.0.0")

# CORS configuration
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # In production, specify your Flutter app domain
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Database setup
DATABASE_URL = os.getenv("DATABASE_URL", "sqlite:///./mpesa_transactions.db")
engine = create_engine(DATABASE_URL)
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
Base = declarative_base()


# Database Models
class MpesaTransactionDB(Base):
    __tablename__ = "mpesa_transactions"

    id = Column(Integer, primary_key=True, index=True)
    transaction_type = Column(String, index=True)
    mpesa_receipt_number = Column(String, unique=True, nullable=True, index=True)
    phone_number = Column(String, index=True)
    amount = Column(Float)
    account_reference = Column(String, nullable=True)
    transaction_desc = Column(String, nullable=True)
    merchant_request_id = Column(String, unique=True, index=True)
    checkout_request_id = Column(String, unique=True, index=True, nullable=True)
    result_code = Column(String, nullable=True)
    result_desc = Column(String, nullable=True)
    status = Column(String, default="pending")  # pending, success, failed
    transaction_date = Column(DateTime, nullable=True)
    created_at = Column(DateTime, default=datetime.utcnow)
    metadata = Column(JSON, nullable=True)


# Create tables
Base.metadata.create_all(bind=engine)


# Dependency to get DB session
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()


# Initialize M-Pesa API
mpesa = MpesaAPI()


# Pydantic Models for Request/Response
class StkPushRequest(BaseModel):
    phone_number: str = Field(..., description="Customer phone number (254XXXXXXXXX)")
    amount: float = Field(..., gt=0, description="Amount to charge")
    account_reference: str = Field(..., description="Account reference/invoice number")
    transaction_desc: str = Field(..., description="Transaction description")


class StkPushResponse(BaseModel):
    merchantRequestId: str
    checkoutRequestId: str
    responseCode: str
    responseDescription: str
    customerMessage: str


class TransactionStatusResponse(BaseModel):
    merchantRequestId: str
    checkoutRequestId: str
    responseCode: str
    responseDescription: str
    resultCode: str
    resultDesc: str
    mpesaReceiptNumber: Optional[str] = None
    amount: Optional[float] = None
    phoneNumber: Optional[str] = None
    transactionDate: Optional[str] = None


class B2CRequest(BaseModel):
    phone_number: str
    amount: float
    remarks: str
    occasion: str = ""


class ReversalRequest(BaseModel):
    transaction_id: str
    amount: float
    remarks: str


class MpesaCallbackData(BaseModel):
    """M-Pesa callback data structure"""
    Body: dict


# API Endpoints

@app.get("/")
def root():
    return {
        "message": "TumorHeal M-Pesa API",
        "version": "1.0.0",
        "endpoints": {
            "stk_push": "/api/v1/payments/mpesa/stk-push",
            "status": "/api/v1/payments/mpesa/stk-push/status/{checkout_request_id}",
            "transactions": "/api/v1/payments/mpesa/transactions",
            "callback": "/api/v1/payments/mpesa/callback",
        },
    }


@app.post("/api/v1/payments/mpesa/stk-push", response_model=StkPushResponse)
async def initiate_stk_push(
    request: StkPushRequest,
    background_tasks: BackgroundTasks,
    db: Session = Depends(get_db),
):
    """
    Initiate M-Pesa STK Push (Lipa Na M-Pesa Online)
    This prompts the customer to enter their M-Pesa PIN
    """
    try:
        # Initiate STK Push
        response = mpesa.stk_push(
            phone_number=request.phone_number,
            amount=request.amount,
            account_reference=request.account_reference,
            transaction_desc=request.transaction_desc,
        )

        # Save transaction to database
        db_transaction = MpesaTransactionDB(
            transaction_type="STK_PUSH",
            phone_number=request.phone_number,
            amount=request.amount,
            account_reference=request.account_reference,
            transaction_desc=request.transaction_desc,
            merchant_request_id=response.get("MerchantRequestID"),
            checkout_request_id=response.get("CheckoutRequestID"),
            status="pending",
        )
        db.add(db_transaction)
        db.commit()

        return StkPushResponse(
            merchantRequestId=response.get("MerchantRequestID"),
            checkoutRequestId=response.get("CheckoutRequestID"),
            responseCode=response.get("ResponseCode"),
            responseDescription=response.get("ResponseDescription"),
            customerMessage=response.get("CustomerMessage"),
        )

    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


@app.get(
    "/api/v1/payments/mpesa/stk-push/status/{checkout_request_id}",
    response_model=TransactionStatusResponse,
)
async def query_stk_push_status(
    checkout_request_id: str,
    db: Session = Depends(get_db),
):
    """
    Query the status of an STK Push transaction
    """
    try:
        # Query M-Pesa API
        response = mpesa.query_stk_push_status(checkout_request_id)

        # Update database
        db_transaction = (
            db.query(MpesaTransactionDB)
            .filter(MpesaTransactionDB.checkout_request_id == checkout_request_id)
            .first()
        )

        if db_transaction:
            db_transaction.result_code = response.get("ResultCode")
            db_transaction.result_desc = response.get("ResultDesc")

            # If successful, extract callback metadata
            if response.get("ResultCode") == "0":
                db_transaction.status = "success"
                callback_metadata = response.get("CallbackMetadata", {}).get("Item", [])
                for item in callback_metadata:
                    if item.get("Name") == "MpesaReceiptNumber":
                        db_transaction.mpesa_receipt_number = item.get("Value")
                    elif item.get("Name") == "TransactionDate":
                        # Convert M-Pesa timestamp to datetime
                        timestamp = str(item.get("Value"))
                        db_transaction.transaction_date = datetime.strptime(
                            timestamp, "%Y%m%d%H%M%S"
                        )
            else:
                db_transaction.status = "failed"

            db.commit()

        return TransactionStatusResponse(
            merchantRequestId=response.get("MerchantRequestID"),
            checkoutRequestId=response.get("CheckoutRequestID"),
            responseCode=response.get("ResponseCode"),
            responseDescription=response.get("ResponseDescription"),
            resultCode=response.get("ResultCode"),
            resultDesc=response.get("ResultDesc"),
            mpesaReceiptNumber=db_transaction.mpesa_receipt_number if db_transaction else None,
            amount=db_transaction.amount if db_transaction else None,
            phoneNumber=db_transaction.phone_number if db_transaction else None,
            transactionDate=db_transaction.transaction_date.isoformat()
            if db_transaction and db_transaction.transaction_date
            else None,
        )

    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


@app.post("/api/v1/payments/mpesa/callback")
async def mpesa_callback(callback: dict, db: Session = Depends(get_db)):
    """
    M-Pesa callback endpoint
    This receives payment confirmations from M-Pesa
    """
    try:
        # Extract data from callback
        stk_callback = callback.get("Body", {}).get("stkCallback", {})
        merchant_request_id = stk_callback.get("MerchantRequestID")
        checkout_request_id = stk_callback.get("CheckoutRequestID")
        result_code = stk_callback.get("ResultCode")
        result_desc = stk_callback.get("ResultDesc")

        # Update database
        db_transaction = (
            db.query(MpesaTransactionDB)
            .filter(MpesaTransactionDB.checkout_request_id == checkout_request_id)
            .first()
        )

        if db_transaction:
            db_transaction.result_code = str(result_code)
            db_transaction.result_desc = result_desc

            if result_code == 0:
                # Success
                db_transaction.status = "success"
                callback_metadata = stk_callback.get("CallbackMetadata", {}).get("Item", [])

                for item in callback_metadata:
                    if item.get("Name") == "MpesaReceiptNumber":
                        db_transaction.mpesa_receipt_number = item.get("Value")
                    elif item.get("Name") == "TransactionDate":
                        timestamp = str(item.get("Value"))
                        db_transaction.transaction_date = datetime.strptime(
                            timestamp, "%Y%m%d%H%M%S"
                        )
            else:
                # Failed
                db_transaction.status = "failed"

            db.commit()

        return {"ResultCode": 0, "ResultDesc": "Success"}

    except Exception as e:
        print(f"Callback error: {str(e)}")
        return {"ResultCode": 1, "ResultDesc": str(e)}


@app.get("/api/v1/payments/mpesa/transactions")
async def get_transactions(
    limit: int = 50,
    offset: int = 0,
    status: Optional[str] = None,
    db: Session = Depends(get_db),
):
    """
    Get M-Pesa transaction history
    """
    try:
        query = db.query(MpesaTransactionDB)

        if status:
            query = query.filter(MpesaTransactionDB.status == status)

        transactions = query.order_by(
            MpesaTransactionDB.created_at.desc()
        ).offset(offset).limit(limit).all()

        return {
            "transactions": [
                {
                    "id": str(txn.id),
                    "transaction_type": txn.transaction_type,
                    "mpesa_receipt_number": txn.mpesa_receipt_number,
                    "phone_number": txn.phone_number,
                    "amount": txn.amount,
                    "account_reference": txn.account_reference,
                    "transaction_desc": txn.transaction_desc,
                    "status": txn.status,
                    "transaction_date": txn.transaction_date.isoformat()
                    if txn.transaction_date
                    else None,
                    "created_at": txn.created_at.isoformat(),
                }
                for txn in transactions
            ],
            "total": db.query(MpesaTransactionDB).count(),
            "limit": limit,
            "offset": offset,
        }

    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


@app.post("/api/v1/payments/mpesa/register-urls")
async def register_urls():
    """
    Register C2B validation and confirmation URLs
    """
    try:
        validation_url = os.getenv("MPESA_VALIDATION_URL")
        confirmation_url = os.getenv("MPESA_CONFIRMATION_URL")

        response = mpesa.register_c2b_urls(
            validation_url=validation_url,
            confirmation_url=confirmation_url,
        )

        return response

    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


@app.get("/api/v1/payments/mpesa/balance")
async def check_balance():
    """
    Check M-Pesa account balance
    """
    try:
        response = mpesa.account_balance()
        return response

    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


@app.post("/api/v1/payments/mpesa/b2c")
async def b2c_payment(request: B2CRequest):
    """
    Send money to customer (B2C)
    """
    try:
        response = mpesa.b2c_payment(
            phone_number=request.phone_number,
            amount=request.amount,
            remarks=request.remarks,
            occasion=request.occasion,
        )

        return response

    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


@app.post("/api/v1/payments/mpesa/reverse")
async def reverse_transaction(request: ReversalRequest):
    """
    Reverse a transaction (refund)
    """
    try:
        response = mpesa.reverse_transaction(
            transaction_id=request.transaction_id,
            amount=request.amount,
            remarks=request.remarks,
        )

        return response

    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


if __name__ == "__main__":
    # Run the server
    uvicorn.run(
        "main:app",
        host="0.0.0.0",
        port=8000,
        reload=True,  # Auto-reload on code changes (development only)
    )

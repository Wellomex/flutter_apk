"""
M-Pesa Daraja API Integration for Python/FastAPI Backend
Supports: STK Push, C2B, B2C, Transaction Status, Balance Query, Reversal
"""

import base64
import requests
from datetime import datetime
from typing import Optional, Dict, Any
import os
from dotenv import load_dotenv

load_dotenv()


class MpesaAPI:
    """M-Pesa Daraja API Client"""

    def __init__(
        self,
        consumer_key: Optional[str] = None,
        consumer_secret: Optional[str] = None,
        business_short_code: Optional[str] = None,
        passkey: Optional[str] = None,
        environment: str = "sandbox",
        callback_url: Optional[str] = None,
    ):
        # Load from environment variables if not provided
        self.consumer_key = consumer_key or os.getenv("MPESA_CONSUMER_KEY")
        self.consumer_secret = consumer_secret or os.getenv("MPESA_CONSUMER_SECRET")
        self.business_short_code = business_short_code or os.getenv(
            "MPESA_BUSINESS_SHORT_CODE"
        )
        self.passkey = passkey or os.getenv("MPESA_PASSKEY")
        self.callback_url = callback_url or os.getenv("MPESA_CALLBACK_URL")
        self.environment = environment

        # Set base URL based on environment
        if environment == "sandbox":
            self.base_url = "https://sandbox.safaricom.co.ke"
        else:
            self.base_url = "https://api.safaricom.co.ke"

        self._access_token = None
        self._token_expiry = None

    def get_access_token(self) -> str:
        """Generate OAuth access token"""
        # Check if token is still valid
        if self._access_token and self._token_expiry:
            if datetime.now() < self._token_expiry:
                return self._access_token

        # Generate new token
        url = f"{self.base_url}/oauth/v1/generate?grant_type=client_credentials"
        
        # Create basic auth header
        auth_string = f"{self.consumer_key}:{self.consumer_secret}"
        auth_bytes = auth_string.encode("ascii")
        auth_base64 = base64.b64encode(auth_bytes).decode("ascii")

        headers = {"Authorization": f"Basic {auth_base64}"}

        try:
            response = requests.get(url, headers=headers)
            response.raise_for_status()
            
            data = response.json()
            self._access_token = data["access_token"]
            
            # Token expires in ~3599 seconds, store for 55 minutes
            from datetime import timedelta
            self._token_expiry = datetime.now() + timedelta(minutes=55)
            
            return self._access_token
        except requests.exceptions.RequestException as e:
            raise Exception(f"Failed to get access token: {str(e)}")

    def _generate_password(self) -> tuple[str, str]:
        """Generate password and timestamp for STK Push"""
        timestamp = datetime.now().strftime("%Y%m%d%H%M%S")
        data_to_encode = f"{self.business_short_code}{self.passkey}{timestamp}"
        password = base64.b64encode(data_to_encode.encode()).decode("utf-8")
        return password, timestamp

    def stk_push(
        self,
        phone_number: str,
        amount: float,
        account_reference: str,
        transaction_desc: str,
        callback_url: Optional[str] = None,
    ) -> Dict[str, Any]:
        """
        Initiate STK Push (Lipa Na M-Pesa Online)
        
        Args:
            phone_number: Customer phone number (254XXXXXXXXX format)
            amount: Amount to charge
            account_reference: Account reference (invoice number, etc.)
            transaction_desc: Transaction description
            callback_url: Optional callback URL (overrides default)
        
        Returns:
            Response from M-Pesa API
        """
        access_token = self.get_access_token()
        password, timestamp = self._generate_password()
        callback = callback_url or self.callback_url

        url = f"{self.base_url}/mpesa/stkpush/v1/processrequest"
        
        headers = {
            "Authorization": f"Bearer {access_token}",
            "Content-Type": "application/json",
        }

        payload = {
            "BusinessShortCode": self.business_short_code,
            "Password": password,
            "Timestamp": timestamp,
            "TransactionType": "CustomerPayBillOnline",
            "Amount": int(amount),  # M-Pesa expects integer
            "PartyA": phone_number,  # Customer phone number
            "PartyB": self.business_short_code,
            "PhoneNumber": phone_number,
            "CallBackURL": callback,
            "AccountReference": account_reference,
            "TransactionDesc": transaction_desc,
        }

        try:
            response = requests.post(url, json=payload, headers=headers)
            response.raise_for_status()
            return response.json()
        except requests.exceptions.RequestException as e:
            raise Exception(f"STK Push failed: {str(e)}")

    def query_stk_push_status(self, checkout_request_id: str) -> Dict[str, Any]:
        """
        Query the status of an STK Push transaction
        
        Args:
            checkout_request_id: CheckoutRequestID from STK Push response
        
        Returns:
            Transaction status
        """
        access_token = self.get_access_token()
        password, timestamp = self._generate_password()

        url = f"{self.base_url}/mpesa/stkpushquery/v1/query"
        
        headers = {
            "Authorization": f"Bearer {access_token}",
            "Content-Type": "application/json",
        }

        payload = {
            "BusinessShortCode": self.business_short_code,
            "Password": password,
            "Timestamp": timestamp,
            "CheckoutRequestID": checkout_request_id,
        }

        try:
            response = requests.post(url, json=payload, headers=headers)
            response.raise_for_status()
            return response.json()
        except requests.exceptions.RequestException as e:
            raise Exception(f"Query failed: {str(e)}")

    def register_c2b_urls(
        self, validation_url: str, confirmation_url: str, response_type: str = "Completed"
    ) -> Dict[str, Any]:
        """
        Register C2B URLs for callbacks
        
        Args:
            validation_url: URL for validation
            confirmation_url: URL for confirmation
            response_type: "Completed" or "Cancelled"
        
        Returns:
            Registration response
        """
        access_token = self.get_access_token()

        url = f"{self.base_url}/mpesa/c2b/v1/registerurl"
        
        headers = {
            "Authorization": f"Bearer {access_token}",
            "Content-Type": "application/json",
        }

        payload = {
            "ShortCode": self.business_short_code,
            "ResponseType": response_type,
            "ConfirmationURL": confirmation_url,
            "ValidationURL": validation_url,
        }

        try:
            response = requests.post(url, json=payload, headers=headers)
            response.raise_for_status()
            return response.json()
        except requests.exceptions.RequestException as e:
            raise Exception(f"URL registration failed: {str(e)}")

    def account_balance(self, remarks: str = "Balance Query") -> Dict[str, Any]:
        """
        Query account balance
        
        Args:
            remarks: Remarks for the balance query
        
        Returns:
            Account balance information
        """
        access_token = self.get_access_token()

        url = f"{self.base_url}/mpesa/accountbalance/v1/query"
        
        headers = {
            "Authorization": f"Bearer {access_token}",
            "Content-Type": "application/json",
        }

        # For balance query, you need initiator credentials
        # These should be configured in your M-Pesa portal
        initiator_name = os.getenv("MPESA_INITIATOR_NAME", "testapi")
        security_credential = os.getenv("MPESA_SECURITY_CREDENTIAL")
        result_url = os.getenv("MPESA_RESULT_URL")
        queue_timeout_url = os.getenv("MPESA_QUEUE_TIMEOUT_URL")

        payload = {
            "Initiator": initiator_name,
            "SecurityCredential": security_credential,
            "CommandID": "AccountBalance",
            "PartyA": self.business_short_code,
            "IdentifierType": "4",  # 4 for organization shortcode
            "Remarks": remarks,
            "QueueTimeOutURL": queue_timeout_url,
            "ResultURL": result_url,
        }

        try:
            response = requests.post(url, json=payload, headers=headers)
            response.raise_for_status()
            return response.json()
        except requests.exceptions.RequestException as e:
            raise Exception(f"Balance query failed: {str(e)}")

    def b2c_payment(
        self,
        phone_number: str,
        amount: float,
        remarks: str,
        occasion: str = "",
        command_id: str = "BusinessPayment",
    ) -> Dict[str, Any]:
        """
        B2C Payment - Send money to customer
        
        Args:
            phone_number: Customer phone number (254XXXXXXXXX)
            amount: Amount to send
            remarks: Payment remarks
            occasion: Optional occasion
            command_id: "BusinessPayment", "SalaryPayment", or "PromotionPayment"
        
        Returns:
            B2C payment response
        """
        access_token = self.get_access_token()

        url = f"{self.base_url}/mpesa/b2c/v1/paymentrequest"
        
        headers = {
            "Authorization": f"Bearer {access_token}",
            "Content-Type": "application/json",
        }

        initiator_name = os.getenv("MPESA_INITIATOR_NAME", "testapi")
        security_credential = os.getenv("MPESA_SECURITY_CREDENTIAL")
        result_url = os.getenv("MPESA_RESULT_URL")
        queue_timeout_url = os.getenv("MPESA_QUEUE_TIMEOUT_URL")

        payload = {
            "InitiatorName": initiator_name,
            "SecurityCredential": security_credential,
            "CommandID": command_id,
            "Amount": int(amount),
            "PartyA": self.business_short_code,
            "PartyB": phone_number,
            "Remarks": remarks,
            "QueueTimeOutURL": queue_timeout_url,
            "ResultURL": result_url,
            "Occasion": occasion,
        }

        try:
            response = requests.post(url, json=payload, headers=headers)
            response.raise_for_status()
            return response.json()
        except requests.exceptions.RequestException as e:
            raise Exception(f"B2C payment failed: {str(e)}")

    def reverse_transaction(
        self,
        transaction_id: str,
        amount: float,
        remarks: str,
        occasion: str = "",
    ) -> Dict[str, Any]:
        """
        Reverse a transaction
        
        Args:
            transaction_id: Original M-Pesa transaction ID
            amount: Amount to reverse
            remarks: Reversal remarks
            occasion: Optional occasion
        
        Returns:
            Reversal response
        """
        access_token = self.get_access_token()

        url = f"{self.base_url}/mpesa/reversal/v1/request"
        
        headers = {
            "Authorization": f"Bearer {access_token}",
            "Content-Type": "application/json",
        }

        initiator_name = os.getenv("MPESA_INITIATOR_NAME", "testapi")
        security_credential = os.getenv("MPESA_SECURITY_CREDENTIAL")
        result_url = os.getenv("MPESA_RESULT_URL")
        queue_timeout_url = os.getenv("MPESA_QUEUE_TIMEOUT_URL")

        payload = {
            "Initiator": initiator_name,
            "SecurityCredential": security_credential,
            "CommandID": "TransactionReversal",
            "TransactionID": transaction_id,
            "Amount": int(amount),
            "ReceiverParty": self.business_short_code,
            "RecieverIdentifierType": "11",  # 11 for organization shortcode
            "ResultURL": result_url,
            "QueueTimeOutURL": queue_timeout_url,
            "Remarks": remarks,
            "Occasion": occasion,
        }

        try:
            response = requests.post(url, json=payload, headers=headers)
            response.raise_for_status()
            return response.json()
        except requests.exceptions.RequestException as e:
            raise Exception(f"Transaction reversal failed: {str(e)}")

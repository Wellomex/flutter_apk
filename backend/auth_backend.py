"""
Authentication Backend for TumorHeal Flutter App
FastAPI + SQLAlchemy + JWT Authentication
"""

from fastapi import FastAPI, HTTPException, Depends, status
from fastapi.middleware.cors import CORSMiddleware
from fastapi.security import HTTPBearer, HTTPAuthorizationCredentials
from pydantic import BaseModel, EmailStr, Field
from typing import Optional, List
from datetime import datetime, timedelta
import jwt
import bcrypt
import secrets
import os
from dotenv import load_dotenv

# Database imports
from sqlalchemy import create_engine, Column, String, Boolean, DateTime, Integer, JSON, Table, ForeignKey
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker, Session, relationship
from fastapi import Depends

load_dotenv()

# JWT Configuration
SECRET_KEY = os.getenv("JWT_SECRET_KEY", "your-secret-key-change-in-production")
ALGORITHM = "HS256"
ACCESS_TOKEN_EXPIRE_MINUTES = 60 * 24  # 24 hours

# Database setup
DATABASE_URL = os.getenv("AUTH_DATABASE_URL", "sqlite:///./tumorheal_auth.db")
engine = create_engine(DATABASE_URL)
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
Base = declarative_base()

# Initialize FastAPI app
app = FastAPI(title="TumorHeal Authentication API", version="1.0.0")

# CORS configuration
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # In production, specify your Flutter app domain
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

security = HTTPBearer()


# ============ DATABASE MODELS ============

# User Roles association table
user_roles = Table(
    'user_roles',
    Base.metadata,
    Column('user_id', String, ForeignKey('users.id')),
    Column('role', String)
)


class UserDB(Base):
    __tablename__ = "users"

    id = Column(String, primary_key=True, index=True)
    email = Column(String, unique=True, index=True, nullable=False)
    password_hash = Column(String, nullable=False)
    name = Column(String, nullable=False)
    profile_picture = Column(String, nullable=True)
    is_email_verified = Column(Boolean, default=False)
    created_at = Column(DateTime, default=datetime.utcnow)
    last_login_at = Column(DateTime, nullable=True)
    metadata = Column(JSON, nullable=True)


class UserRoleDB(Base):
    __tablename__ = "user_roles_table"
    
    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(String, ForeignKey('users.id'), nullable=False)
    role = Column(String, nullable=False)


class UserSettingsDB(Base):
    __tablename__ = "user_settings"

    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(String, ForeignKey('users.id'), unique=True, nullable=False)
    language = Column(String, default="en")
    timezone = Column(String, default="UTC")
    notification_email = Column(Boolean, default=True)
    notification_push = Column(Boolean, default=True)
    notification_sms = Column(Boolean, default=False)
    privacy_profile_public = Column(Boolean, default=False)
    privacy_show_activity = Column(Boolean, default=True)
    privacy_show_location = Column(Boolean, default=True)
    privacy_show_email = Column(Boolean, default=False)
    privacy_show_phone = Column(Boolean, default=False)
    two_factor_enabled = Column(Boolean, default=False)
    preferences = Column(JSON, nullable=True)


class PasswordResetTokenDB(Base):
    __tablename__ = "password_reset_tokens"

    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(String, ForeignKey('users.id'), nullable=False)
    token = Column(String, unique=True, index=True, nullable=False)
    expires_at = Column(DateTime, nullable=False)
    used = Column(Boolean, default=False)
    created_at = Column(DateTime, default=datetime.utcnow)


class OTPTokenDB(Base):
    __tablename__ = "otp_tokens"

    id = Column(Integer, primary_key=True, index=True)
    email = Column(String, index=True, nullable=False)
    otp_code = Column(String, nullable=False)
    action = Column(String, nullable=False)
    expires_at = Column(DateTime, nullable=False)
    verified = Column(Boolean, default=False)
    created_at = Column(DateTime, default=datetime.utcnow)


# Create all tables
Base.metadata.create_all(bind=engine)


# ============ PYDANTIC MODELS ============

class RegisterRequest(BaseModel):
    email: EmailStr
    password: str = Field(..., min_length=8)
    name: str = Field(..., min_length=1)


class LoginRequest(BaseModel):
    email: EmailStr
    password: str


class PasswordResetRequest(BaseModel):
    email: EmailStr


class PasswordResetConfirm(BaseModel):
    token: str
    new_password: str = Field(..., min_length=8)


class OTPRequest(BaseModel):
    email: EmailStr
    action: str  # 'login', 'verify_email', 'transaction'


class OTPVerify(BaseModel):
    email: EmailStr
    otp_code: str
    action: str


class UserResponse(BaseModel):
    id: str
    email: str
    name: str
    is_email_verified: bool
    roles: List[str]
    created_at: datetime
    last_login_at: Optional[datetime]
    settings: dict
    subscription: Optional[dict] = None
    profile_picture: Optional[str] = None
    metadata: Optional[dict] = None


class AuthResponse(BaseModel):
    access_token: str
    user: UserResponse


# ============ HELPER FUNCTIONS ============

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()


def hash_password(password: str) -> str:
    """Hash a password using bcrypt"""
    salt = bcrypt.gensalt()
    return bcrypt.hashpw(password.encode('utf-8'), salt).decode('utf-8')


def verify_password(plain_password: str, hashed_password: str) -> bool:
    """Verify a password against its hash"""
    return bcrypt.checkpw(plain_password.encode('utf-8'), hashed_password.encode('utf-8'))


def create_access_token(data: dict, expires_delta: Optional[timedelta] = None):
    """Create JWT access token"""
    to_encode = data.copy()
    if expires_delta:
        expire = datetime.utcnow() + expires_delta
    else:
        expire = datetime.utcnow() + timedelta(minutes=ACCESS_TOKEN_EXPIRE_MINUTES)
    to_encode.update({"exp": expire})
    encoded_jwt = jwt.encode(to_encode, SECRET_KEY, algorithm=ALGORITHM)
    return encoded_jwt


def decode_token(token: str) -> dict:
    """Decode and verify JWT token"""
    try:
        payload = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
        return payload
    except jwt.ExpiredSignatureError:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Token has expired"
        )
    except jwt.InvalidTokenError:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Invalid token"
        )


def get_current_user(
    credentials: HTTPAuthorizationCredentials = Depends(security),
    db: Session = Depends(get_db)
):
    """Get current authenticated user"""
    token = credentials.credentials
    payload = decode_token(token)
    user_id = payload.get("user_id")
    
    user = db.query(UserDB).filter(UserDB.id == user_id).first()
    if not user:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="User not found"
        )
    return user


def get_user_roles(user_id: str, db: Session) -> List[str]:
    """Get user roles"""
    roles = db.query(UserRoleDB).filter(UserRoleDB.user_id == user_id).all()
    return [role.role for role in roles]


def get_user_settings(user_id: str, db: Session) -> dict:
    """Get user settings"""
    settings = db.query(UserSettingsDB).filter(UserSettingsDB.user_id == user_id).first()
    if not settings:
        # Create default settings
        settings = UserSettingsDB(user_id=user_id)
        db.add(settings)
        db.commit()
        db.refresh(settings)
    
    return {
        "language": settings.language,
        "timezone": settings.timezone,
        "notifications": {
            "email": settings.notification_email,
            "push": settings.notification_push,
            "sms": settings.notification_sms,
        },
        "privacy": {
            "isProfilePublic": settings.privacy_profile_public,
            "showActivity": settings.privacy_show_activity,
            "showLocation": settings.privacy_show_location,
            "showEmail": settings.privacy_show_email,
            "showPhone": settings.privacy_show_phone,
        },
        "twoFactorEnabled": settings.two_factor_enabled,
        "preferences": settings.preferences,
    }


def user_to_response(user: UserDB, db: Session) -> UserResponse:
    """Convert UserDB to UserResponse"""
    roles = get_user_roles(user.id, db)
    settings = get_user_settings(user.id, db)
    
    return UserResponse(
        id=user.id,
        email=user.email,
        name=user.name,
        is_email_verified=user.is_email_verified,
        roles=roles,
        created_at=user.created_at,
        last_login_at=user.last_login_at,
        settings=settings,
        profile_picture=user.profile_picture,
        metadata=user.metadata,
    )


# ============ API ENDPOINTS ============

@app.get("/")
def root():
    return {
        "message": "TumorHeal Authentication API",
        "version": "1.0.0",
        "endpoints": {
            "register": "/api/v1/auth/register",
            "login": "/api/v1/auth/login",
            "me": "/api/v1/auth/me",
            "reset_password": "/api/v1/auth/reset-password",
        },
    }


@app.post("/api/v1/auth/register", response_model=AuthResponse, status_code=201)
async def register(request: RegisterRequest, db: Session = Depends(get_db)):
    """Register a new user"""
    
    # Check if user already exists
    existing_user = db.query(UserDB).filter(UserDB.email == request.email).first()
    if existing_user:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Email already registered"
        )
    
    # Create new user
    user_id = f"user_{secrets.token_urlsafe(16)}"
    hashed_password = hash_password(request.password)
    
    new_user = UserDB(
        id=user_id,
        email=request.email,
        password_hash=hashed_password,
        name=request.name,
    )
    
    db.add(new_user)
    db.commit()
    db.refresh(new_user)
    
    # Assign default role
    user_role = UserRoleDB(user_id=user_id, role="user")
    db.add(user_role)
    db.commit()
    
    # Create JWT token
    access_token = create_access_token(
        data={"user_id": user_id, "email": request.email}
    )
    
    # Return response
    user_response = user_to_response(new_user, db)
    
    return AuthResponse(
        access_token=access_token,
        user=user_response
    )


@app.post("/api/v1/auth/login", response_model=AuthResponse)
async def login(request: LoginRequest, db: Session = Depends(get_db)):
    """Login user"""
    
    # Find user
    user = db.query(UserDB).filter(UserDB.email == request.email).first()
    if not user:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Invalid email or password"
        )
    
    # Verify password
    if not verify_password(request.password, user.password_hash):
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Invalid email or password"
        )
    
    # Update last login
    user.last_login_at = datetime.utcnow()
    db.commit()
    
    # Create JWT token
    access_token = create_access_token(
        data={"user_id": user.id, "email": user.email}
    )
    
    # Return response
    user_response = user_to_response(user, db)
    
    return AuthResponse(
        access_token=access_token,
        user=user_response
    )


@app.get("/api/v1/auth/me", response_model=UserResponse)
async def get_current_user_info(
    current_user: UserDB = Depends(get_current_user),
    db: Session = Depends(get_db)
):
    """Get current user information"""
    return user_to_response(current_user, db)


@app.post("/api/v1/auth/reset-password")
async def reset_password(request: PasswordResetRequest, db: Session = Depends(get_db)):
    """Request password reset"""
    
    # Find user
    user = db.query(UserDB).filter(UserDB.email == request.email).first()
    if not user:
        # Don't reveal if email exists or not
        return {"message": "If your email is registered, you will receive a password reset link"}
    
    # Generate reset token
    reset_token = secrets.token_urlsafe(32)
    expires_at = datetime.utcnow() + timedelta(hours=1)  # Token valid for 1 hour
    
    # Save token to database
    token_db = PasswordResetTokenDB(
        user_id=user.id,
        token=reset_token,
        expires_at=expires_at
    )
    db.add(token_db)
    db.commit()
    
    # TODO: Send email with reset link
    # send_password_reset_email(user.email, reset_token)
    
    print(f"Password reset token for {user.email}: {reset_token}")
    
    return {"message": "If your email is registered, you will receive a password reset link"}


@app.post("/api/v1/auth/reset-password/confirm")
async def confirm_reset_password(
    request: PasswordResetConfirm,
    db: Session = Depends(get_db)
):
    """Confirm password reset with token"""
    
    # Find token
    token_db = db.query(PasswordResetTokenDB).filter(
        PasswordResetTokenDB.token == request.token,
        PasswordResetTokenDB.used == False
    ).first()
    
    if not token_db:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Invalid or expired reset token"
        )
    
    # Check if token expired
    if datetime.utcnow() > token_db.expires_at:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Reset token has expired"
        )
    
    # Update user password
    user = db.query(UserDB).filter(UserDB.id == token_db.user_id).first()
    user.password_hash = hash_password(request.new_password)
    
    # Mark token as used
    token_db.used = True
    
    db.commit()
    
    return {"message": "Password reset successful"}


@app.post("/api/v1/auth/otp/request")
async def request_otp(request: OTPRequest, db: Session = Depends(get_db)):
    """Request OTP code"""
    
    # Generate 6-digit OTP
    otp_code = ''.join([str(secrets.randbelow(10)) for _ in range(6)])
    expires_at = datetime.utcnow() + timedelta(minutes=10)  # OTP valid for 10 minutes
    
    # Save OTP to database
    otp_db = OTPTokenDB(
        email=request.email,
        otp_code=otp_code,
        action=request.action,
        expires_at=expires_at
    )
    db.add(otp_db)
    db.commit()
    
    # TODO: Send OTP via email/SMS
    # send_otp_email(request.email, otp_code)
    
    print(f"OTP for {request.email}: {otp_code}")
    
    return {"message": "OTP sent successfully"}


@app.post("/api/v1/auth/otp/verify")
async def verify_otp(request: OTPVerify, db: Session = Depends(get_db)):
    """Verify OTP code"""
    
    # Find OTP
    otp_db = db.query(OTPTokenDB).filter(
        OTPTokenDB.email == request.email,
        OTPTokenDB.otp_code == request.otp_code,
        OTPTokenDB.action == request.action,
        OTPTokenDB.verified == False
    ).first()
    
    if not otp_db:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Invalid OTP code"
        )
    
    # Check if OTP expired
    if datetime.utcnow() > otp_db.expires_at:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="OTP has expired"
        )
    
    # Mark OTP as verified
    otp_db.verified = True
    db.commit()
    
    return {"message": "OTP verified successfully", "verified": True}


@app.post("/api/v1/auth/refresh")
async def refresh_token(
    current_user: UserDB = Depends(get_current_user),
    db: Session = Depends(get_db)
):
    """Refresh access token"""
    
    # Create new token
    access_token = create_access_token(
        data={"user_id": current_user.id, "email": current_user.email}
    )
    
    return {"access_token": access_token}


if __name__ == "__main__":
    import uvicorn
    uvicorn.run(
        "auth_backend:app",
        host="0.0.0.0",
        port=8000,
        reload=True,
    )

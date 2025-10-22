# M-Pesa Integration Guide for TumorHeal Flutter App

Complete M-Pesa Daraja API integration with Python FastAPI backend and Flutter frontend.

## 📁 File Structure

### Backend (Python)
```
backend/
├── main.py                  # FastAPI server with M-Pesa endpoints
├── mpesa_api.py            # M-Pesa Daraja API client
├── requirements.txt        # Python dependencies
├── .env.example           # Environment variables template
└── .env                   # Your actual credentials (create this)
```

### Frontend (Flutter)
```
lib/
├── models/
│   └── mpesa_models.dart          # M-Pesa data models (freezed)
├── services/
│   └── mpesa_service.dart         # M-Pesa service layer
├── providers/
│   └── mpesa_provider.dart        # State management for M-Pesa
└── screens/
    └── payments/
        └── mpesa_payment_screen.dart  # UI for M-Pesa payments
```

## 🚀 Setup Instructions

### 1. Get M-Pesa Credentials

#### Sandbox (Testing)
1. Go to [Safaricom Daraja Portal](https://developer.safaricom.co.ke/)
2. Create an account
3. Create a new app
4. Get your credentials:
   - **Consumer Key**
   - **Consumer Secret**
   - **Business Short Code**: Use `174379` for sandbox
   - **Passkey**: Provided in test credentials

#### Production
1. Register your business with Safaricom
2. Apply for M-Pesa API access
3. Get production credentials
4. Register your callback URLs

### 2. Backend Setup

#### Install Python Dependencies

```bash
cd backend

# Create virtual environment
python -m venv venv

# Activate virtual environment
# Windows:
venv\Scripts\activate
# Linux/Mac:
source venv/bin/activate

# Install dependencies
pip install -r requirements.txt
```

#### Configure Environment Variables

```bash
# Copy example env file
copy .env.example .env  # Windows
cp .env.example .env    # Linux/Mac
```

Edit `.env` file with your credentials:

```env
# M-Pesa Credentials
MPESA_CONSUMER_KEY=your_actual_consumer_key
MPESA_CONSUMER_SECRET=your_actual_consumer_secret
MPESA_BUSINESS_SHORT_CODE=174379
MPESA_PASSKEY=your_actual_passkey

# Environment
MPESA_ENVIRONMENT=sandbox  # or 'production'

# Callback URLs (use ngrok for local testing)
MPESA_CALLBACK_URL=https://your-domain.com/api/v1/payments/mpesa/callback
MPESA_VALIDATION_URL=https://your-domain.com/api/v1/payments/mpesa/validation
MPESA_CONFIRMATION_URL=https://your-domain.com/api/v1/payments/mpesa/confirmation
MPESA_RESULT_URL=https://your-domain.com/api/v1/payments/mpesa/result
MPESA_QUEUE_TIMEOUT_URL=https://your-domain.com/api/v1/payments/mpesa/timeout

# For B2C, Balance, Reversal
MPESA_INITIATOR_NAME=testapi
MPESA_SECURITY_CREDENTIAL=your_security_credential

# Database
DATABASE_URL=sqlite:///./mpesa_transactions.db
```

#### Run the Backend Server

```bash
# Make sure you're in the backend directory with venv activated
python main.py

# Or use uvicorn directly
uvicorn main:app --reload --host 0.0.0.0 --port 8000
```

Server will start at: `http://localhost:8000`

API Documentation: `http://localhost:8000/docs`

### 3. Frontend Setup

#### Update API Base URL

In `lib/config/keys.dart`:

```dart
class Keys {
  // For Android Emulator
  static const API_BASE = 'http://10.0.2.2:8000';
  
  // For real device (use your computer's local IP)
  // static const API_BASE = 'http://192.168.1.100:8000';
  
  // For production
  // static const API_BASE = 'https://api.tumorheal.com';
}
```

#### Add M-Pesa Provider to App

In `lib/main.dart`:

```dart
import 'providers/mpesa_provider.dart';

void main() async {
  // ... existing code
  runApp(const TumorHealApp());
}

class TumorHealApp extends StatelessWidget {
  const TumorHealApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => MpesaProvider()), // Add this
      ],
      child: MaterialApp(
        // ... existing code
      ),
    );
  }
}
```

#### Generate Freezed Models

```bash
# In Flutter project root
flutter pub get
dart run build_runner build --delete-conflicting-outputs
```

#### Use M-Pesa Payment Screen

```dart
import 'package:flutter/material.dart';
import 'screens/payments/mpesa_payment_screen.dart';

// Navigate to M-Pesa payment
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => MpesaPaymentScreen(
      amount: 100.0,  // Amount in KES
      accountReference: 'INV-12345',
      description: 'Payment for medical consultation',
    ),
  ),
);
```

## 🔧 Local Testing with Ngrok

M-Pesa requires public callback URLs. Use ngrok for local testing:

```bash
# Install ngrok: https://ngrok.com/download

# Start your backend server (port 8000)
python main.py

# In another terminal, start ngrok
ngrok http 8000

# Ngrok will provide a public URL like:
# https://abc123.ngrok.io

# Update your .env file:
MPESA_CALLBACK_URL=https://abc123.ngrok.io/api/v1/payments/mpesa/callback
# Update other URLs similarly
```

**Important**: Restart your backend server after changing callback URLs.

## 📱 Testing the Integration

### Test Flow:

1. **Start Backend**:
   ```bash
   cd backend
   python main.py
   ```

2. **Run Flutter App**:
   ```bash
   flutter run
   ```

3. **Initiate Payment**:
   - Navigate to M-Pesa payment screen
   - Enter phone number: `254712345678` (sandbox test number)
   - Amount: Any amount (e.g., 100 KES)
   - Click "Pay Now"

4. **Check Phone**:
   - In sandbox, you won't receive actual prompts
   - Use the test credentials from Daraja

5. **Monitor Backend**:
   - Watch terminal logs
   - Check `http://localhost:8000/docs` for API docs
   - Query transaction status

### API Endpoints:

```bash
# Initiate STK Push
POST http://localhost:8000/api/v1/payments/mpesa/stk-push
{
  "phone_number": "254712345678",
  "amount": 100,
  "account_reference": "TEST123",
  "transaction_desc": "Payment for services"
}

# Query Status
GET http://localhost:8000/api/v1/payments/mpesa/stk-push/status/{checkout_request_id}

# Get Transactions
GET http://localhost:8000/api/v1/payments/mpesa/transactions?limit=50&offset=0

# Check Balance
GET http://localhost:8000/api/v1/payments/mpesa/balance

# Send Money (B2C)
POST http://localhost:8000/api/v1/payments/mpesa/b2c
{
  "phone_number": "254712345678",
  "amount": 50,
  "remarks": "Withdrawal",
  "occasion": ""
}

# Reverse Transaction
POST http://localhost:8000/api/v1/payments/mpesa/reverse
{
  "transaction_id": "OEI2AK4Q16",
  "amount": 100,
  "remarks": "Refund"
}
```

## 🗄️ Database

The backend uses SQLite by default. Transactions are stored in `mpesa_transactions.db`.

### Switch to PostgreSQL (Production):

1. Install PostgreSQL dependencies:
   ```bash
   pip install psycopg2-binary
   ```

2. Update `.env`:
   ```env
   DATABASE_URL=postgresql://user:password@localhost/tumorheal_db
   ```

3. Create database:
   ```sql
   CREATE DATABASE tumorheal_db;
   ```

4. Restart backend (tables auto-create)

## 🔒 Security Best Practices

### Production Checklist:

✅ **Use HTTPS** for all callback URLs
✅ **Validate** phone numbers before initiating payments
✅ **Verify** callback signatures from M-Pesa
✅ **Store** credentials in environment variables, NOT in code
✅ **Use** production credentials, not sandbox
✅ **Implement** rate limiting on payment endpoints
✅ **Add** authentication/authorization to API endpoints
✅ **Log** all transactions for audit trail
✅ **Handle** idempotency (prevent duplicate charges)
✅ **Set up** monitoring and alerts

### Example: Add JWT Authentication

```python
# In main.py
from fastapi import Depends, HTTPException, status
from fastapi.security import HTTPBearer, HTTPAuthorizationCredentials

security = HTTPBearer()

async def verify_token(credentials: HTTPAuthorizationCredentials = Depends(security)):
    token = credentials.credentials
    # Verify JWT token here
    # Raise HTTPException if invalid
    return user_id

@app.post("/api/v1/payments/mpesa/stk-push")
async def initiate_stk_push(
    request: StkPushRequest,
    user_id: str = Depends(verify_token),  # Add this
    db: Session = Depends(get_db),
):
    # Only authenticated users can initiate payments
    ...
```

## 🐛 Troubleshooting

### Common Issues:

**1. "Failed to get access token"**
- Check consumer key and secret
- Ensure you're using correct environment (sandbox/production)
- Verify internet connection

**2. "Invalid access token"**
- Token expires after 1 hour
- The library auto-refreshes, check credentials

**3. "Callback URL not accessible"**
- Use ngrok for local testing
- Ensure HTTPS (required by M-Pesa)
- Check firewall settings

**4. "STK Push not received on phone"**
- In sandbox, use test numbers
- Check phone number format (254XXXXXXXXX)
- Verify business short code

**5. "Payment timeout"**
- User may have cancelled
- Check `pollPaymentStatus` duration
- Query status manually via API

### Debug Mode:

Add logging to backend:

```python
import logging
logging.basicConfig(level=logging.DEBUG)
```

Check Flutter logs:

```bash
flutter logs
```

## 📊 Monitoring Transactions

### View in Database:

```bash
# SQLite
sqlite3 backend/mpesa_transactions.db
SELECT * FROM mpesa_transactions ORDER BY created_at DESC LIMIT 10;

# PostgreSQL
psql -d tumorheal_db
SELECT * FROM mpesa_transactions ORDER BY created_at DESC LIMIT 10;
```

### API Query:

```bash
curl http://localhost:8000/api/v1/payments/mpesa/transactions?limit=10
```

## 🚢 Deployment

### Backend Deployment (Example: Heroku)

```bash
# Create Procfile
echo "web: uvicorn main:app --host 0.0.0.0 --port \$PORT" > Procfile

# Create runtime.txt
echo "python-3.11" > runtime.txt

# Deploy
heroku create tumorheal-api
heroku config:set MPESA_CONSUMER_KEY=xxx
heroku config:set MPESA_CONSUMER_SECRET=xxx
# Set other environment variables
git push heroku main
```

### Update Flutter App:

```dart
// lib/config/keys.dart
static const API_BASE = 'https://tumorheal-api.herokuapp.com';
```

## 📚 Additional Resources

- [Safaricom Daraja API Docs](https://developer.safaricom.co.ke/docs)
- [M-Pesa API Reference](https://developer.safaricom.co.ke/APIs)
- [FastAPI Documentation](https://fastapi.tiangolo.com/)
- [Flutter Provider Package](https://pub.dev/packages/provider)

## 🤝 Support

For M-Pesa API issues:
- Email: apisupport@safaricom.co.ke
- Portal: https://developer.safaricom.co.ke/support

## ✅ Integration Complete!

You now have:
- ✅ Python FastAPI backend with M-Pesa integration
- ✅ Flutter frontend with M-Pesa payment screens
- ✅ Database for transaction tracking
- ✅ STK Push (Lipa Na M-Pesa Online)
- ✅ Transaction status querying
- ✅ Transaction history
- ✅ B2C payments (send money to customers)
- ✅ Transaction reversal (refunds)
- ✅ Account balance checking

Happy coding! 🎉

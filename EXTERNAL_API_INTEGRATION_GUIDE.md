# 🌐 External Backend API Integration Guide

This guide explains how to configure your Flutter app to use an external backend API instead of the local backend in the project.

---

## 📋 Quick Setup

### Step 1: Update API URL

Open `lib/config/env_config.dart` and update:

```dart
// Set this to your external backend URL
static const String externalApiBaseUrl = 'http://127.0.0.1:8000/';

// Enable external backend
static const bool useExternalBackend = true;
```

### Step 2: Run Your App

```bash
flutter run
```

That's it! Your app now uses the external backend.

---

## 🎯 Configuration Options

### Option 1: Production/Hosted Backend

If your backend is hosted on a cloud service:

```dart
// Examples:
static const String externalApiBaseUrl = 'https://api.tumorheal.com';
static const String externalApiBaseUrl = 'https://tumorheal-api.onrender.com';
static const String externalApiBaseUrl = 'https://tumorheal.railway.app';
```

### Option 2: Another Computer on Local Network

If your backend is running on another computer on the same WiFi:

```dart
// Find your backend computer's IP address:
// - Windows: ipconfig (look for IPv4 Address)
// - Mac/Linux: ifconfig or ip addr

static const String externalApiBaseUrl = 'http://127.0.0.1:8000/';
static const bool useExternalBackend = true;
```

### Option 3: Tunneling Service (ngrok, localtunnel)

If you want to expose your local backend to the internet temporarily:

**Using ngrok:**
```bash
# On your backend computer
ngrok http 8000
```

Copy the ngrok URL and update:
```dart
static const String externalApiBaseUrl = 'https://abc123.ngrok.io';
```

**Using localtunnel:**
```bash
npx localtunnel --port 8000
```

### Option 4: Switch Between Local and External

```dart
// Use external backend in production
static const bool useExternalBackend = true;

// Use local backend in development
static const bool useExternalBackend = false;
```

---

## 🔧 Backend Requirements

Your external backend MUST implement these endpoints:

### Authentication Endpoints

```
POST   /api/v1/auth/register
POST   /api/v1/auth/login
POST   /api/v1/auth/logout
POST   /api/v1/auth/refresh
POST   /api/v1/auth/password-reset
POST   /api/v1/auth/password-reset/confirm
POST   /api/v1/auth/verify-otp
```

### User Endpoints

```
GET    /api/v1/user/profile
GET    /api/v1/user/settings
PUT    /api/v1/user/update
```

### M-Pesa Payment Endpoints

```
POST   /api/v1/payments/mpesa/stk-push
GET    /api/v1/payments/mpesa/stk-push/status/{checkoutRequestId}
POST   /api/v1/payments/mpesa/callback
POST   /api/v1/payments/mpesa/b2c
POST   /api/v1/payments/mpesa/reversal
GET    /api/v1/payments/mpesa/balance
```

### Payment Endpoints

```
POST   /api/v1/payments
POST   /api/v1/payments/{paymentId}/verify
POST   /api/v1/payments/risk-analysis
POST   /api/v1/payment-methods
```

### Health Check

```
GET    /health
GET    /api/v1/version
```

---

## 📝 Request/Response Format

### Registration Example

**Request:**
```json
POST /api/v1/auth/register
Content-Type: application/json

{
  "email": "user@example.com",
  "password": "securepassword123",
  "full_name": "John Doe"
}
```

**Response (Success):**
```json
HTTP 201 Created
{
  "access_token": "eyJhbGci...",
  "token_type": "bearer",
  "user": {
    "id": "user123",
    "email": "user@example.com",
    "full_name": "John Doe",
    "created_at": "2025-10-22T10:30:00Z"
  }
}
```

### Login Example

**Request:**
```json
POST /api/v1/auth/login
Content-Type: application/json

{
  "email": "user@example.com",
  "password": "securepassword123"
}
```

**Response (Success):**
```json
HTTP 200 OK
{
  "access_token": "eyJhbGci...",
  "token_type": "bearer",
  "expires_in": 86400,
  "user": {
    "id": "user123",
    "email": "user@example.com",
    "full_name": "John Doe"
  }
}
```

### M-Pesa STK Push Example

**Request:**
```json
POST /api/v1/payments/mpesa/stk-push
Authorization: Bearer {access_token}
Content-Type: application/json

{
  "phone_number": "254712345678",
  "amount": 100.00,
  "account_reference": "TumorHeal",
  "transaction_desc": "Payment for consultation"
}
```

**Response (Success):**
```json
HTTP 200 OK
{
  "merchant_request_id": "29115-34620561-1",
  "checkout_request_id": "ws_CO_191220191020363925",
  "response_code": "0",
  "response_description": "Success. Request accepted for processing",
  "customer_message": "Success. Request accepted for processing"
}
```

---

## 🔐 Authentication Flow

The app uses Bearer token authentication:

1. **Register/Login** → Receive `access_token`
2. **Store token** → Saved in secure storage
3. **Include in requests** → `Authorization: Bearer {token}`
4. **Token expires** → Refresh or re-login

The `ApiService` automatically adds the token to requests if available.

---

## 🐛 Troubleshooting

### Issue 1: Connection Timeout

**Problem:** `DioException: Connection timeout`

**Solutions:**
- ✅ Check that your backend is running
- ✅ Verify the URL is correct (http vs https)
- ✅ Check firewall settings on backend server
- ✅ If using local IP, ensure both devices are on same network
- ✅ Increase timeout in `env_config.dart`:
  ```dart
  static const Duration connectTimeout = Duration(seconds: 60);
  ```

### Issue 2: CORS Errors (Web)

**Problem:** Cross-Origin Request Blocked

**Solution:** Enable CORS on your backend

**Python/FastAPI:**
```python
from fastapi.middleware.cors import CORSMiddleware

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # In production, specify your domain
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)
```

**Node.js/Express:**
```javascript
const cors = require('cors');
app.use(cors());
```

### Issue 3: SSL/HTTPS Errors

**Problem:** `HandshakeException` or certificate errors

**Solution (Development only):**
```dart
// In api_service.dart (NOT for production!)
(_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = 
  (client) {
    client.badCertificateCallback = 
      (X509Certificate cert, String host, int port) => true;
    return client;
  };
```

### Issue 4: 401 Unauthorized

**Problem:** API returns 401 even with token

**Solutions:**
- ✅ Check token is being sent: Enable `enableDebugLogs = true` in `env_config.dart`
- ✅ Verify token format: Should be `Bearer {token}`
- ✅ Check token expiration
- ✅ Ensure backend validates token correctly

### Issue 5: Different Backend Structure

**Problem:** Your backend uses different endpoint paths

**Solution:** Update endpoints in `env_config.dart`:
```dart
// If your backend uses /auth/signup instead of /api/v1/auth/register
static String get authRegisterUrl => '$apiBaseUrl/auth/signup';
```

---

## 🚀 Deployment Checklist

Before deploying your external backend:

- [ ] **HTTPS enabled** - Use SSL certificate (Let's Encrypt)
- [ ] **CORS configured** - Allow your app domain
- [ ] **Environment variables** - Database, API keys stored securely
- [ ] **Database migrations** - Run on production database
- [ ] **Rate limiting** - Prevent API abuse
- [ ] **Error logging** - Monitor production errors (Sentry, LogRocket)
- [ ] **Health checks** - `/health` endpoint for monitoring
- [ ] **Backup strategy** - Regular database backups
- [ ] **API documentation** - Swagger/OpenAPI docs
- [ ] **Authentication** - JWT tokens with proper expiration

---

## 📚 Popular Hosting Options

### Free Tier Options

1. **Render** (https://render.com)
   - Free PostgreSQL database
   - Auto-deploy from GitHub
   - HTTPS included
   
2. **Railway** (https://railway.app)
   - $5 free credit/month
   - Easy setup
   - Good for Python/Node.js

3. **Fly.io** (https://fly.io)
   - Free tier available
   - Global CDN
   - Good performance

4. **Heroku** (https://heroku.com)
   - Free tier (with sleep mode)
   - PostgreSQL add-on
   - Easy deployment

### Paid Options

1. **AWS** (EC2, Lambda, RDS)
2. **Google Cloud** (Cloud Run, App Engine)
3. **DigitalOcean** (Droplets, App Platform)
4. **Azure** (App Service)

---

## 🔄 Migration from Local to External

### Step-by-step:

1. **Deploy your backend** to hosting service
2. **Get the URL** (e.g., `https://tumorheal-api.onrender.com`)
3. **Update `env_config.dart`**:
   ```dart
   static const String externalApiBaseUrl = 'https://tumorheal-api.onrender.com';
   static const bool useExternalBackend = true;
   ```
4. **Test authentication** - Register/login should work
5. **Test M-Pesa** - Ensure callbacks reach your server
6. **Update M-Pesa callback URLs** in Safaricom portal:
   ```
   https://tumorheal-api.onrender.com/api/v1/payments/mpesa/callback
   ```

---

## 💡 Best Practices

1. **Use environment variables** for sensitive data
2. **Version your API** (`/api/v1/`, `/api/v2/`)
3. **Implement rate limiting** to prevent abuse
4. **Log all requests** for debugging
5. **Use HTTPS** in production (always!)
6. **Validate all inputs** on backend
7. **Return consistent error format**:
   ```json
   {
     "error": {
       "code": "INVALID_EMAIL",
       "message": "Email format is invalid",
       "details": {}
     }
   }
   ```

---

## 📞 Need Help?

If you encounter issues:

1. Check backend logs for errors
2. Enable debug logs in app: `enableDebugLogs = true`
3. Test API endpoints with Postman/Insomnia
4. Verify network connectivity
5. Check firewall/security group settings

---

## ✅ Summary

Your app is now configured to use external backend APIs:

- ✅ Configuration file: `lib/config/env_config.dart`
- ✅ API service updated to use environment config
- ✅ Easy switching between local and external
- ✅ Comprehensive timeout and retry handling
- ✅ Debug logging for troubleshooting

**Update the `externalApiBaseUrl` and you're ready to go!** 🚀

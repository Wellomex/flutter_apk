# Flutter Authentication Configuration Guide

Complete guide to configure authentication between your Flutter app, Python backend, and database.

## 📁 What You Already Have

### ✅ Flutter Frontend:
- `lib/providers/auth_provider.dart` - Authentication state management
- `lib/services/api_service.dart` - HTTP client (Dio)
- `lib/services/secure_storage.dart` - Token storage
- `lib/models/user_models.dart` - User data models
- `lib/screens/auth/` - Login, Register, Password Reset screens

### ✅ Backend Created:
- `backend/auth_backend.py` - Complete authentication API with FastAPI

---

## 🚀 Step-by-Step Setup

### **Step 1: Install Backend Dependencies**

```bash
cd backend

# Create virtual environment
python -m venv venv

# Activate (Windows)
venv\Scripts\activate

# Install dependencies
pip install -r requirements.txt
```

### **Step 2: Configure Environment Variables**

Create `backend/.env` file:

```env
# JWT Secret Key (IMPORTANT: Change this!)
JWT_SECRET_KEY=your-super-secret-key-min-32-characters-long-random-string

# Database URL
AUTH_DATABASE_URL=sqlite:///./tumorheal_auth.db

# For PostgreSQL (Production):
# AUTH_DATABASE_URL=postgresql://username:password@localhost/tumorheal_auth

# For MySQL (Production):
# AUTH_DATABASE_URL=mysql://username:password@localhost/tumorheal_auth
```

**Generate a secure JWT secret:**
```python
python -c "import secrets; print(secrets.token_urlsafe(32))"
```

### **Step 3: Start the Authentication Backend**

```bash
cd backend

# Activate venv
venv\Scripts\activate

# Run the server
python auth_backend.py

# Or use uvicorn directly
uvicorn auth_backend:app --reload --host 0.0.0.0 --port 8000
```

Server will start at: **http://localhost:8000**

API Docs: **http://localhost:8000/docs**

### **Step 4: Configure Flutter App**

#### A. Update API Base URL

**File:** `lib/config/keys.dart`

```dart
class Keys {
  // For Android Emulator
  static const API_BASE = 'http://10.0.2.2:8000';
  
  // For real Android device (use your computer's IP)
  // Find IP: Run 'ipconfig' (Windows) or 'ifconfig' (Mac/Linux)
  // static const API_BASE = 'http://192.168.1.100:8000';
  
  // For iOS Simulator
  // static const API_BASE = 'http://localhost:8000';
  
  // For Production
  // static const API_BASE = 'https://api.tumorheal.com';
  
  // Stripe keys...
  static const STRIPE_PUBLISHABLE_KEY = 'pk_test_REPLACE_ME';
  static const APPLE_MERCHANT_ID = 'merchant.com.tumorheal.REPLACE_ME';
  static const GOOGLE_PAY_MERCHANT_ID = 'REPLACE_ME';
}
```

#### B. Add Authorization Header to API Service

**File:** `lib/services/api_service.dart`

Add this method to the `ApiService` class:

```dart
import 'package:dio/dio.dart';
import '../config/keys.dart';
import '../models/payment_models.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(baseUrl: Keys.API_BASE));

  ApiService() {
    _dio.options.connectTimeout = const Duration(milliseconds: 15000);
    _dio.options.receiveTimeout = const Duration(milliseconds: 15000);
    
    // Add interceptor to include auth token
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        // Get token from secure storage
        final storage = SecureStorageService();
        final token = await storage.getToken();
        
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        
        return handler.next(options);
      },
      onError: (error, handler) async {
        // Handle token expiry
        if (error.response?.statusCode == 401) {
          // Token expired, redirect to login
          // You can implement auto-refresh here
        }
        return handler.next(error);
      },
    ));
  }

  // ... rest of your methods
}
```

---

## 🧪 Testing the Authentication

### **1. Test Registration**

#### Using Flutter App:
1. Run your Flutter app: `flutter run`
2. Go to Register screen
3. Enter: email@example.com, password, name
4. Click Register

#### Using API Directly (Postman/curl):
```bash
curl -X POST http://localhost:8000/api/v1/auth/register \
  -H "Content-Type: application/json" \
  -d '{
    "email": "test@example.com",
    "password": "password123",
    "name": "Test User"
  }'
```

**Expected Response:**
```json
{
  "access_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "user": {
    "id": "user_abc123",
    "email": "test@example.com",
    "name": "Test User",
    "is_email_verified": false,
    "roles": ["user"],
    "created_at": "2025-10-22T10:30:00",
    "last_login_at": null,
    "settings": {
      "language": "en",
      "timezone": "UTC",
      "notifications": {
        "email": true,
        "push": true,
        "sms": false
      },
      "privacy": {
        "isProfilePublic": false,
        "showActivity": true,
        "showLocation": true,
        "showEmail": false,
        "showPhone": false
      },
      "twoFactorEnabled": false
    }
  }
}
```

### **2. Test Login**

```bash
curl -X POST http://localhost:8000/api/v1/auth/login \
  -H "Content-Type: application/json" \
  -d '{
    "email": "test@example.com",
    "password": "password123"
  }'
```

### **3. Test Protected Endpoint**

```bash
curl -X GET http://localhost:8000/api/v1/auth/me \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN_HERE"
```

---

## 🗄️ Database Setup

### **SQLite (Default - For Development)**

The database is created automatically when you run the backend. File: `tumorheal_auth.db`

**Tables created:**
- `users` - User accounts
- `user_roles_table` - User roles
- `user_settings` - User preferences
- `password_reset_tokens` - Password reset tokens
- `otp_tokens` - OTP codes

**View database:**
```bash
sqlite3 backend/tumorheal_auth.db
.tables
SELECT * FROM users;
.quit
```

### **PostgreSQL (Production)**

1. **Install PostgreSQL**
2. **Create database:**
   ```sql
   CREATE DATABASE tumorheal_auth;
   CREATE USER tumorheal_user WITH PASSWORD 'your_password';
   GRANT ALL PRIVILEGES ON DATABASE tumorheal_auth TO tumorheal_user;
   ```

3. **Update `.env`:**
   ```env
   AUTH_DATABASE_URL=postgresql://tumorheal_user:your_password@localhost/tumorheal_auth
   ```

4. **Install psycopg2:**
   ```bash
   pip install psycopg2-binary
   ```

5. **Restart backend** - Tables auto-create

---

## 🔒 Security Features Included

✅ **Password Hashing** - Uses bcrypt (industry standard)
✅ **JWT Tokens** - Secure authentication tokens
✅ **Token Expiry** - Tokens expire after 24 hours
✅ **Secure Storage** - Tokens stored in Flutter Secure Storage
✅ **HTTPS Ready** - CORS configured
✅ **SQL Injection Protection** - SQLAlchemy ORM
✅ **Password Reset** - Secure token-based reset
✅ **OTP Support** - 2FA ready

---

## 📱 Flutter App Flow

### **Registration Flow:**
```
User fills form → AuthProvider.register() → ApiService.post()
→ Backend creates user → Returns JWT + User data
→ Token saved to SecureStorage → User logged in
```

### **Login Flow:**
```
User enters credentials → AuthProvider.login() → ApiService.post()
→ Backend verifies password → Returns JWT + User data
→ Token saved → User logged in → Navigate to Home
```

### **Auto-login on App Start:**

Add this to your `main.dart`:

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Stripe
  Stripe.publishableKey = Keys.STRIPE_PUBLISHABLE_KEY;
  Stripe.merchantIdentifier = Keys.APPLE_MERCHANT_ID;
  
  runApp(const TumorHealApp());
}

class TumorHealApp extends StatelessWidget {
  const TumorHealApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        // Add MpesaProvider if using M-Pesa
        // ChangeNotifierProvider(create: (_) => MpesaProvider()),
      ],
      child: MaterialApp(
        title: 'TumorHeal',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.indigo),
        home: const AuthChecker(), // Add this
        routes: {
          '/login': (context) => const LoginScreen(),
          '/home': (context) => const HomeScreen(),
          '/register': (context) => const RegisterScreen(),
          '/password-reset': (context) => const PasswordResetScreen(),
        },
      ),
    );
  }
}

// Create this widget
class AuthChecker extends StatelessWidget {
  const AuthChecker({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: SecureStorageService().getToken(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasData && snapshot.data != null) {
          // User has token, go to home
          return const HomeScreen();
        }

        // No token, go to login
        return const LoginScreen();
      },
    );
  }
}
```

---

## 🐛 Troubleshooting

### **"Connection refused" error:**
- Backend not running? Start it: `python auth_backend.py`
- Wrong URL? Check `Keys.API_BASE` matches your backend
- Android emulator? Use `10.0.2.2` not `localhost`
- Real device? Use your computer's IP address

### **"401 Unauthorized" error:**
- Token expired? Re-login
- Token not sent? Check ApiService interceptor
- Wrong token? Clear app data and re-login

### **"Database locked" error (SQLite):**
- Close all connections to the database
- Restart the backend server

### **Password reset not working:**
- Check backend console for reset token
- Token expires in 1 hour
- Implement email sending for production

---

## 📧 Email Integration (Optional)

For password reset and OTP emails, integrate with:

### **SendGrid:**
```python
pip install sendgrid

from sendgrid import SendGridAPIClient
from sendgrid.helpers.mail import Mail

def send_password_reset_email(email, token):
    message = Mail(
        from_email='noreply@tumorheal.com',
        to_emails=email,
        subject='Password Reset',
        html_content=f'Click here to reset: https://app.tumorheal.com/reset?token={token}'
    )
    
    sg = SendGridAPIClient(os.getenv('SENDGRID_API_KEY'))
    sg.send(message)
```

### **AWS SES, Mailgun, etc.:**
Similar integration

---

## 🚀 Production Deployment

### **Backend (Heroku Example):**

```bash
# Create Procfile
echo "web: uvicorn auth_backend:app --host 0.0.0.0 --port $PORT" > Procfile

# Deploy
heroku create tumorheal-auth-api
heroku addons:create heroku-postgresql:hobby-dev
heroku config:set JWT_SECRET_KEY=your-secret-key
git push heroku main
```

### **Update Flutter:**
```dart
static const API_BASE = 'https://tumorheal-auth-api.herokuapp.com';
```

---

## ✅ Quick Start Checklist

1. ✅ Install Python dependencies: `pip install -r requirements.txt`
2. ✅ Create `.env` file with JWT secret
3. ✅ Start backend: `python auth_backend.py`
4. ✅ Update `Keys.API_BASE` in Flutter
5. ✅ Run Flutter app: `flutter run`
6. ✅ Test registration
7. ✅ Test login
8. ✅ Verify token storage

---

## 🎉 You're Done!

Your authentication is now fully configured and working!

**What you can do:**
- ✅ Register new users
- ✅ Login existing users
- ✅ Reset passwords
- ✅ Request/verify OTP
- ✅ Auto-login on app restart
- ✅ Secure API calls with JWT
- ✅ Store tokens securely

**API Documentation:** http://localhost:8000/docs

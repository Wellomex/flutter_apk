# Supabase Configuration & Setup Guide

Complete guide to configure TumorHeal with Supabase for database, authentication, storage, and real-time features.

---

## 📋 Table of Contents

1. [Supabase Project Setup](#1-supabase-project-setup)
2. [Backend Configuration](#2-backend-configuration)
3. [Flutter Configuration](#3-flutter-configuration)
4. [Database Schema](#4-database-schema)
5. [Authentication Setup](#5-authentication-setup)
6. [Storage Configuration](#6-storage-configuration)
7. [Testing](#7-testing)
8. [Production Deployment](#8-production-deployment)

---

## 1. Supabase Project Setup

### Step 1.1: Create Supabase Account

1. Go to [https://supabase.com](https://supabase.com)
2. Click "Start your project"
3. Sign up with GitHub, Google, or Email
4. Verify your email

### Step 1.2: Create New Project

1. Click "New Project"
2. Fill in details:
   - **Organization**: Create new or select existing
   - **Name**: `tumorheal-db`
   - **Database Password**: Generate strong password (save it!)
   - **Region**: Choose closest to your users (e.g., `us-east-1`, `eu-west-1`, `ap-southeast-1`)
   - **Pricing Plan**: Free tier (for development)

3. Click "Create new project"
4. Wait ~2 minutes for provisioning

### Step 1.3: Get Project Credentials

Once project is ready:

1. Go to **Project Settings** (gear icon) → **API**

2. Copy these values:

```
Project URL: https://xxxxxxxxxxxxx.supabase.co
anon/public key: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
service_role key: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
```

3. Go to **Settings** → **Database** → **Connection String**

4. Copy PostgreSQL connection string:
```
postgresql://postgres:[YOUR-PASSWORD]@db.xxxxxxxxxxxxx.supabase.co:5432/postgres
```

**IMPORTANT:** Replace `[YOUR-PASSWORD]` with your database password!

---

## 2. Backend Configuration

### Step 2.1: Update Backend `.env`

Create/update `backend/.env`:

```env
# ============ Supabase Configuration ============

# Database Connection (PostgreSQL)
AUTH_DATABASE_URL=postgresql://postgres:[YOUR-PASSWORD]@db.xxxxxxxxxxxxx.supabase.co:5432/postgres

# Supabase API
SUPABASE_URL=https://xxxxxxxxxxxxx.supabase.co
SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
SUPABASE_SERVICE_ROLE_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...

# JWT Configuration (use Supabase's JWT secret or your own)
JWT_SECRET_KEY=your-super-secret-jwt-key-min-32-chars
ALGORITHM=HS256

# ============ M-Pesa Configuration ============

MPESA_CONSUMER_KEY=your_consumer_key
MPESA_CONSUMER_SECRET=your_consumer_secret
MPESA_BUSINESS_SHORT_CODE=174379
MPESA_PASSKEY=your_passkey
MPESA_ENVIRONMENT=sandbox

# Callback URLs
MPESA_CALLBACK_URL=https://your-domain.com/api/v1/payments/mpesa/callback
MPESA_VALIDATION_URL=https://your-domain.com/api/v1/payments/mpesa/validation
MPESA_CONFIRMATION_URL=https://your-domain.com/api/v1/payments/mpesa/confirmation
MPESA_RESULT_URL=https://your-domain.com/api/v1/payments/mpesa/result
MPESA_QUEUE_TIMEOUT_URL=https://your-domain.com/api/v1/payments/mpesa/timeout

# For B2C, Balance, Reversal
MPESA_INITIATOR_NAME=testapi
MPESA_SECURITY_CREDENTIAL=your_security_credential

# ============ Application Settings ============

# Environment
ENVIRONMENT=development  # development, staging, production

# API
API_HOST=0.0.0.0
API_PORT=8000

# Storage
STORAGE_BUCKET=user-uploads
```

### Step 2.2: Install PostgreSQL Driver

```bash
cd backend

# Activate virtual environment
venv\Scripts\activate  # Windows
# source venv/bin/activate  # Mac/Linux

# Install PostgreSQL driver
pip install psycopg2-binary

# Update requirements.txt
pip freeze > requirements.txt
```

### Step 2.3: Test Database Connection

Run your auth backend:

```bash
python auth_backend.py
```

You should see:
```
INFO:     Started server process
INFO:     Waiting for application startup.
INFO:     Application startup complete.
INFO:     Uvicorn running on http://0.0.0.0:8000
```

### Step 2.4: Verify Tables in Supabase

1. Go to Supabase Dashboard
2. Click **Table Editor**
3. You should see these tables auto-created:
   - `users`
   - `user_roles_table`
   - `user_settings`
   - `password_reset_tokens`
   - `otp_tokens`
   - `mpesa_transactions` (if M-Pesa backend is running)

---

## 3. Flutter Configuration

### Step 3.1: Add Supabase Flutter Package

Update `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  
  # Existing packages
  http: ^1.1.0
  provider: ^6.0.5
  flutter_secure_storage: ^8.0.0
  dio: ^5.3.2
  
  # Add Supabase
  supabase_flutter: ^2.0.0
  
  # ... rest of your dependencies
```

Install:
```bash
flutter pub get
```

### Step 3.2: Create Supabase Configuration File

Create `lib/config/supabase_config.dart`:

```dart
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseConfig {
  // Supabase credentials
  static const String supabaseUrl = 'https://xxxxxxxxxxxxx.supabase.co';
  static const String supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...';

  // Storage bucket names
  static const String profilePicturesBucket = 'profile-pictures';
  static const String medicalDocumentsBucket = 'medical-documents';
  static const String reportsBucket = 'reports';

  // Initialize Supabase
  static Future<void> initialize() async {
    await Supabase.initialize(
      url: supabaseUrl,
      anonKey: supabaseAnonKey,
      authOptions: const FlutterAuthClientOptions(
        authFlowType: AuthFlowType.pkce,
      ),
      realtimeClientOptions: const RealtimeClientOptions(
        logLevel: RealtimeLogLevel.info,
      ),
      storageOptions: const StorageClientOptions(
        retryAttempts: 10,
      ),
    );
  }

  // Get Supabase client
  static SupabaseClient get client => Supabase.instance.client;

  // Storage helpers
  static SupabaseStorageClient get storage => client.storage;
  
  // Auth helpers
  static GoTrueClient get auth => client.auth;
  
  // Database helpers
  static PostgrestClient get database => client.from('');
}

// Convenience getter
final supabase = Supabase.instance.client;
```

### Step 3.3: Update `main.dart`

```dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'config/keys.dart';
import 'config/supabase_config.dart';
import 'providers/auth_provider.dart';
import 'providers/mpesa_provider.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/register_screen.dart';
import 'screens/auth/password_reset_screen.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Supabase
  await SupabaseConfig.initialize();
  
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
        ChangeNotifierProvider(create: (_) => MpesaProvider()),
      ],
      child: MaterialApp(
        title: 'TumorHeal',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.indigo),
        initialRoute: '/login',
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
```

### Step 3.4: Update `keys.dart`

```dart
class Keys {
  // Stripe
  static const STRIPE_PUBLISHABLE_KEY = 'pk_test_REPLACE_ME';
  static const APPLE_MERCHANT_ID = 'merchant.com.tumorheal.REPLACE_ME';
  static const GOOGLE_PAY_MERCHANT_ID = 'REPLACE_ME';

  // Backend API
  static const API_BASE = 'http://10.0.2.2:8000'; // Android emulator
  // static const API_BASE = 'http://192.168.1.100:8000'; // Real device
  // static const API_BASE = 'https://api.tumorheal.com'; // Production

  // Supabase (imported from supabase_config.dart)
  // Use SupabaseConfig.supabaseUrl and SupabaseConfig.supabaseAnonKey
}
```

---

## 4. Database Schema

### Step 4.1: Run Backend to Auto-Create Tables

```bash
cd backend
python auth_backend.py
```

This automatically creates all tables in Supabase.

### Step 4.2: Set Up Row Level Security (RLS)

In Supabase Dashboard → **Authentication** → **Policies**:

#### Enable RLS on Tables

```sql
-- Enable RLS on all tables
ALTER TABLE users ENABLE ROW LEVEL SECURITY;
ALTER TABLE user_roles_table ENABLE ROW LEVEL SECURITY;
ALTER TABLE user_settings ENABLE ROW LEVEL SECURITY;
ALTER TABLE password_reset_tokens ENABLE ROW LEVEL SECURITY;
ALTER TABLE otp_tokens ENABLE ROW LEVEL SECURITY;
ALTER TABLE mpesa_transactions ENABLE ROW LEVEL SECURITY;
```

#### Create Security Policies

**Users table - Users can only read their own data:**

```sql
CREATE POLICY "Users can view own data"
ON users FOR SELECT
USING (auth.uid()::text = id);

CREATE POLICY "Users can update own data"
ON users FOR UPDATE
USING (auth.uid()::text = id);
```

**User Settings - Users can manage their own settings:**

```sql
CREATE POLICY "Users can view own settings"
ON user_settings FOR SELECT
USING (auth.uid()::text = user_id);

CREATE POLICY "Users can update own settings"
ON user_settings FOR UPDATE
USING (auth.uid()::text = user_id);
```

**M-Pesa Transactions - Users can view their own transactions:**

```sql
CREATE POLICY "Users can view own transactions"
ON mpesa_transactions FOR SELECT
USING (auth.uid()::text = (
  SELECT id FROM users WHERE users.email = mpesa_transactions.phone_number
));
```

### Step 4.3: Create Indexes for Performance

```sql
-- User email lookup
CREATE INDEX idx_users_email ON users(email);

-- Transaction lookups
CREATE INDEX idx_mpesa_transactions_phone ON mpesa_transactions(phone_number);
CREATE INDEX idx_mpesa_transactions_receipt ON mpesa_transactions(mpesa_receipt_number);
CREATE INDEX idx_mpesa_transactions_status ON mpesa_transactions(status);
CREATE INDEX idx_mpesa_transactions_created ON mpesa_transactions(created_at DESC);

-- Token lookups
CREATE INDEX idx_password_reset_token ON password_reset_tokens(token);
CREATE INDEX idx_otp_email_action ON otp_tokens(email, action);
```

---

## 5. Authentication Setup

### Step 5.1: Configure Email Auth in Supabase

1. Go to **Authentication** → **Providers**
2. Enable **Email** provider
3. Configure email templates:
   - **Confirm signup**: Customize email template
   - **Reset password**: Customize email template
   - **Magic Link**: Optional

### Step 5.2: Configure OAuth Providers (Optional)

Enable social login:

1. **Google**:
   - Go to Google Cloud Console
   - Create OAuth credentials
   - Add to Supabase

2. **Apple**:
   - Go to Apple Developer
   - Create Sign in with Apple key
   - Add to Supabase

3. **GitHub**, **Facebook**, etc.

### Step 5.3: Email Templates

Customize in **Authentication** → **Email Templates**:

**Confirm Signup:**
```html
<h2>Confirm your signup</h2>
<p>Follow this link to confirm your email:</p>
<p><a href="{{ .ConfirmationURL }}">Confirm your email</a></p>
```

**Reset Password:**
```html
<h2>Reset Password</h2>
<p>Follow this link to reset your password:</p>
<p><a href="{{ .ConfirmationURL }}">Reset Password</a></p>
```

---

## 6. Storage Configuration

### Step 6.1: Create Storage Buckets

In Supabase Dashboard → **Storage**:

1. Create bucket: `profile-pictures`
   - Public: Yes
   - File size limit: 2MB
   - Allowed MIME types: `image/jpeg, image/png, image/webp`

2. Create bucket: `medical-documents`
   - Public: No
   - File size limit: 10MB
   - Allowed MIME types: `application/pdf, image/jpeg, image/png`

3. Create bucket: `reports`
   - Public: No
   - File size limit: 5MB
   - Allowed MIME types: `application/pdf`

### Step 6.2: Set Storage Policies

**Profile Pictures (Public):**

```sql
CREATE POLICY "Anyone can view profile pictures"
ON storage.objects FOR SELECT
USING (bucket_id = 'profile-pictures');

CREATE POLICY "Users can upload own profile picture"
ON storage.objects FOR INSERT
WITH CHECK (
  bucket_id = 'profile-pictures' AND
  auth.uid()::text = (storage.foldername(name))[1]
);

CREATE POLICY "Users can update own profile picture"
ON storage.objects FOR UPDATE
USING (
  bucket_id = 'profile-pictures' AND
  auth.uid()::text = (storage.foldername(name))[1]
);
```

**Medical Documents (Private):**

```sql
CREATE POLICY "Users can view own documents"
ON storage.objects FOR SELECT
USING (
  bucket_id = 'medical-documents' AND
  auth.uid()::text = (storage.foldername(name))[1]
);

CREATE POLICY "Users can upload own documents"
ON storage.objects FOR INSERT
WITH CHECK (
  bucket_id = 'medical-documents' AND
  auth.uid()::text = (storage.foldername(name))[1]
);
```

### Step 6.3: Create Storage Service in Flutter

Create `lib/services/supabase_storage_service.dart`:

```dart
import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../config/supabase_config.dart';

class SupabaseStorageService {
  final _storage = SupabaseConfig.storage;

  /// Upload profile picture
  Future<String> uploadProfilePicture(String userId, File file) async {
    final fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
    final path = '$userId/$fileName';

    await _storage.from('profile-pictures').upload(
      path,
      file,
      fileOptions: const FileOptions(
        cacheControl: '3600',
        upsert: false,
      ),
    );

    // Get public URL
    final url = _storage.from('profile-pictures').getPublicUrl(path);
    return url;
  }

  /// Upload medical document
  Future<String> uploadMedicalDocument(String userId, File file, String fileName) async {
    final path = '$userId/$fileName';

    await _storage.from('medical-documents').upload(
      path,
      file,
      fileOptions: const FileOptions(
        cacheControl: '3600',
        upsert: false,
      ),
    );

    // Get signed URL (private, expires in 1 hour)
    final url = await _storage.from('medical-documents').createSignedUrl(
      path,
      3600, // 1 hour
    );

    return url;
  }

  /// Delete file
  Future<void> deleteFile(String bucket, String path) async {
    await _storage.from(bucket).remove([path]);
  }

  /// List user files
  Future<List<FileObject>> listUserFiles(String userId, String bucket) async {
    final files = await _storage.from(bucket).list(path: userId);
    return files;
  }
}
```

---

## 7. Testing

### Step 7.1: Test Backend Connection

```bash
cd backend
python auth_backend.py
```

Open browser: http://localhost:8000/docs

Test endpoints:
1. POST `/api/v1/auth/register`
2. POST `/api/v1/auth/login`
3. GET `/api/v1/auth/me`

### Step 7.2: Test Flutter App

```bash
flutter run
```

Test flows:
1. Register new account
2. Login
3. View profile
4. Upload profile picture
5. Make M-Pesa payment

### Step 7.3: Verify in Supabase Dashboard

1. **Table Editor**: Check data in tables
2. **Authentication**: See registered users
3. **Storage**: See uploaded files
4. **Database**: Run SQL queries

---

## 8. Production Deployment

### Step 8.1: Upgrade Supabase Plan

1. Go to **Settings** → **Billing**
2. Upgrade to **Pro** ($25/month)
   - 8GB database
   - 50GB bandwidth
   - Daily backups
   - 99.9% SLA

### Step 8.2: Configure Production Environment

Update `.env`:

```env
ENVIRONMENT=production
AUTH_DATABASE_URL=postgresql://postgres:[PROD-PASSWORD]@db.xxxxx.supabase.co:5432/postgres
SUPABASE_URL=https://xxxxx.supabase.co
```

### Step 8.3: Enable SSL

Supabase uses SSL by default. Ensure connection string includes `sslmode=require`:

```env
AUTH_DATABASE_URL=postgresql://postgres:[PASSWORD]@db.xxxxx.supabase.co:5432/postgres?sslmode=require
```

### Step 8.4: Set Up Backups

In Supabase Dashboard:
- **Database** → **Backups**
- Daily automated backups (Pro plan)
- Point-in-time recovery

### Step 8.5: Monitor Performance

- **Reports**: View database performance
- **Logs**: Monitor API requests
- **API**: Check usage metrics

---

## 📊 Supabase Features Summary

| Feature | Status | Description |
|---------|--------|-------------|
| PostgreSQL Database | ✅ | Relational database for all data |
| Authentication | ✅ | JWT-based auth with email/OAuth |
| Storage | ✅ | File upload (images, documents) |
| Real-time | ✅ | WebSocket subscriptions |
| Row Level Security | ✅ | User-based access control |
| Auto-generated APIs | ✅ | REST & GraphQL endpoints |
| Edge Functions | ⚠️ | Serverless functions (optional) |
| Backups | ✅ | Automated daily backups |

---

## 🎉 You're All Set!

Your TumorHeal app is now configured with Supabase for:
- ✅ PostgreSQL database
- ✅ User authentication
- ✅ File storage
- ✅ Real-time features
- ✅ Row-level security
- ✅ Automated backups

**Next Steps:**
1. Start backend: `python auth_backend.py`
2. Run Flutter app: `flutter run`
3. Register a test user
4. Verify in Supabase dashboard

**Documentation:**
- Supabase Docs: https://supabase.com/docs
- Flutter Package: https://pub.dev/packages/supabase_flutter

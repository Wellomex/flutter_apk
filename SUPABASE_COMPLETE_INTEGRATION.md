# 🚀 Complete Supabase Integration Guide for TumorHeal

This guide provides **step-by-step instructions** to fully integrate Supabase into your Flutter application with **authentication, database, and storage**.

---

## 📋 Table of Contents

1. [Prerequisites](#prerequisites)
2. [Step 1: Install Supabase Package](#step-1-install-supabase-package)
3. [Step 2: Create Supabase Project](#step-2-create-supabase-project)
4. [Step 3: Configure Flutter App](#step-3-configure-flutter-app)
5. [Step 4: Update Backend](#step-4-update-backend)
6. [Step 5: Database Setup](#step-5-database-setup)
7. [Step 6: Storage Setup](#step-6-storage-setup)
8. [Step 7: Update Your App Code](#step-7-update-your-app-code)
9. [Step 8: Testing](#step-8-testing)
10. [Troubleshooting](#troubleshooting)

---

## Prerequisites

- ✅ Flutter SDK installed
- ✅ Python 3.9+ installed
- ✅ Active internet connection
- ✅ Code editor (VS Code recommended)
- ✅ Basic knowledge of Flutter and Dart

---

## Step 1: Install Supabase Package

### 1.1 Add Package to pubspec.yaml

Open `pubspec.yaml` and add the following under `dependencies`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  
  # Existing packages...
  provider: ^6.0.5
  dio: ^5.3.3
  
  # Add Supabase
  supabase_flutter: ^2.0.0  # ← Add this line
```

### 1.2 Install Dependencies

Run in terminal:

```bash
flutter pub get
```

### 1.3 Verify Installation

Check that all compilation errors in these files are now resolved:
- `lib/config/supabase_config.dart`
- `lib/services/supabase_storage_service.dart`
- `lib/providers/supabase_auth_provider.dart`

---

## Step 2: Create Supabase Project

### 2.1 Sign Up

1. Go to [https://supabase.com](https://supabase.com)
2. Click **"Start your project"**
3. Sign up with GitHub, Google, or email

### 2.2 Create New Project

1. Click **"New Project"**
2. Fill in details:
   - **Name**: `tumorheal-db`
   - **Database Password**: Create a strong password (save it!)
   - **Region**: Choose closest to your users
   - **Plan**: Free (sufficient for development)
3. Click **"Create new project"**
4. Wait 2-3 minutes for setup to complete

### 2.3 Get Your Credentials

Once the project is ready:

1. Go to **Settings** (gear icon) → **API**
2. Copy these values:

```
Project URL: https://xxxxxxxxxxxxx.supabase.co
anon public key: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
service_role key: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9... (keep secret!)
```

3. Go to **Settings** → **Database** → **Connection string**
4. Copy the **URI** connection string (select "URI" tab):

```
postgresql://postgres:[YOUR-PASSWORD]@db.xxxxxxxxxxxxx.supabase.co:5432/postgres
```

Replace `[YOUR-PASSWORD]` with your database password.

---

## Step 3: Configure Flutter App

### 3.1 Update supabase_config.dart

Open `lib/config/supabase_config.dart` and replace the placeholders:

```dart
class SupabaseConfig {
  // Replace with your actual Supabase credentials
  static const String supabaseUrl = 'https://xxxxxxxxxxxxx.supabase.co'; // ← Your Project URL
  static const String supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...'; // ← Your anon key
  
  // Rest of the file stays the same
}
```

### 3.2 Initialize Supabase in main.dart

Open `lib/main.dart` and update it:

```dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'config/supabase_config.dart';
import 'providers/supabase_auth_provider.dart';
// ... other imports

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Supabase
  await Supabase.initialize(
    url: SupabaseConfig.supabaseUrl,
    anonKey: SupabaseConfig.supabaseAnonKey,
  );
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SupabaseAuthProvider()..initialize()),
        // ... other providers
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TumorHeal',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: Consumer<SupabaseAuthProvider>(
        builder: (context, auth, _) {
          if (auth.isLoading) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          
          if (auth.isAuthenticated) {
            return const HomeScreen(); // Your home screen
          }
          
          return const LoginScreen(); // Your login screen
        },
      ),
    );
  }
}
```

---

## Step 4: Update Backend

### 4.1 Install PostgreSQL Driver

In your backend directory, run:

```bash
cd backend
pip install psycopg2-binary
```

### 4.2 Create .env File

Create `backend/.env` (copy from `.env.example` if it exists):

```env
# JWT Settings
JWT_SECRET_KEY=your-super-secret-key-change-this-in-production
JWT_ALGORITHM=HS256
JWT_EXPIRATION_HOURS=24

# Supabase Database (replace with your connection string)
DATABASE_URL=postgresql://postgres:[YOUR-PASSWORD]@db.xxxxxxxxxxxxx.supabase.co:5432/postgres

# M-Pesa Settings (keep existing values)
MPESA_CONSUMER_KEY=your_consumer_key
MPESA_CONSUMER_SECRET=your_consumer_secret
MPESA_BUSINESS_SHORT_CODE=174379
MPESA_PASSKEY=your_passkey
MPESA_ENVIRONMENT=sandbox

# Email Settings (for password reset)
SMTP_HOST=smtp.gmail.com
SMTP_PORT=587
SMTP_USER=your_email@gmail.com
SMTP_PASSWORD=your_app_password
```

### 4.3 Update Backend Code

The backend code in `backend/auth_backend.py` and `backend/main.py` will automatically work with PostgreSQL because they use SQLAlchemy, which supports multiple databases.

**No code changes needed!** Just update the `DATABASE_URL` in `.env`.

### 4.4 Test Backend Connection

Run the backend to create tables in Supabase:

```bash
python auth_backend.py
```

You should see:
```
INFO:     Started server process
INFO:     Uvicorn running on http://127.0.0.1:8000
Database tables created successfully!
```

### 4.5 Verify Tables in Supabase

1. Go to your Supabase dashboard
2. Click **Table Editor** (left sidebar)
3. You should see these tables:
   - `users`
   - `password_reset_tokens`
   - `otp_codes`
   - `mpesa_transactions`
   - (and others created by your backend)

---

## Step 5: Database Setup

### 5.1 Enable Row Level Security (RLS)

In Supabase dashboard:

1. Go to **Authentication** → **Policies**
2. For each table, enable RLS:
   - Click the table name
   - Click **"Enable RLS"**

### 5.2 Create RLS Policies

#### For `users` table:

```sql
-- Policy: Users can read their own data
CREATE POLICY "Users can view own data"
ON users FOR SELECT
USING (auth.uid()::text = id);

-- Policy: Users can update their own data
CREATE POLICY "Users can update own data"
ON users FOR UPDATE
USING (auth.uid()::text = id);
```

#### For `mpesa_transactions` table:

```sql
-- Policy: Users can read their own transactions
CREATE POLICY "Users can view own transactions"
ON mpesa_transactions FOR SELECT
USING (auth.uid()::text = user_id);

-- Policy: Users can insert their own transactions
CREATE POLICY "Users can create own transactions"
ON mpesa_transactions FOR INSERT
WITH CHECK (auth.uid()::text = user_id);
```

### 5.3 Run Policies

1. Go to **SQL Editor** in Supabase
2. Paste the policies above
3. Click **"Run"**

---

## Step 6: Storage Setup

### 6.1 Create Storage Buckets

In Supabase dashboard:

1. Go to **Storage** (left sidebar)
2. Click **"Create bucket"**
3. Create these buckets:

| Bucket Name | Public | Description |
|-------------|--------|-------------|
| `profile-pictures` | ✅ Yes | User profile photos |
| `medical-documents` | ❌ No | Private medical files |
| `scan-images` | ❌ No | Medical scan images |
| `reports` | ❌ No | PDF reports |

### 6.2 Set Storage Policies

For each bucket, set access policies:

#### Profile Pictures (Public)

```sql
-- Anyone can view profile pictures
CREATE POLICY "Public profile pictures"
ON storage.objects FOR SELECT
USING (bucket_id = 'profile-pictures');

-- Users can upload their own profile picture
CREATE POLICY "Users can upload own profile picture"
ON storage.objects FOR INSERT
WITH CHECK (
  bucket_id = 'profile-pictures' 
  AND (storage.foldername(name))[1] = auth.uid()::text
);

-- Users can update their own profile picture
CREATE POLICY "Users can update own profile picture"
ON storage.objects FOR UPDATE
USING (
  bucket_id = 'profile-pictures' 
  AND (storage.foldername(name))[1] = auth.uid()::text
);

-- Users can delete their own profile picture
CREATE POLICY "Users can delete own profile picture"
ON storage.objects FOR DELETE
USING (
  bucket_id = 'profile-pictures' 
  AND (storage.foldername(name))[1] = auth.uid()::text
);
```

#### Medical Documents (Private)

```sql
-- Users can only view their own documents
CREATE POLICY "Users can view own documents"
ON storage.objects FOR SELECT
USING (
  bucket_id = 'medical-documents' 
  AND (storage.foldername(name))[1] = auth.uid()::text
);

-- Users can upload their own documents
CREATE POLICY "Users can upload own documents"
ON storage.objects FOR INSERT
WITH CHECK (
  bucket_id = 'medical-documents' 
  AND (storage.foldername(name))[1] = auth.uid()::text
);

-- Similar policies for UPDATE and DELETE
```

Repeat similar policies for `scan-images` and `reports` buckets.

### 6.3 Test Storage

Run this in **SQL Editor** to verify buckets:

```sql
SELECT * FROM storage.buckets;
```

---

## Step 7: Update Your App Code

### 7.1 Update Login Screen

Replace your existing login logic with Supabase:

```dart
import 'package:provider/provider.dart';
import '../providers/supabase_auth_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> _handleLogin() async {
    final auth = context.read<SupabaseAuthProvider>();
    
    final success = await auth.signIn(
      email: _emailController.text.trim(),
      password: _passwordController.text,
    );

    if (success && mounted) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      // Show error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(auth.errorMessage ?? 'Login failed')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<SupabaseAuthProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: auth.isLoading ? null : _handleLogin,
              child: auth.isLoading
                  ? const CircularProgressIndicator()
                  : const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
```

### 7.2 Update Registration Screen

```dart
Future<void> _handleSignUp() async {
  final auth = context.read<SupabaseAuthProvider>();
  
  final success = await auth.signUp(
    email: _emailController.text.trim(),
    password: _passwordController.text,
    fullName: _nameController.text.trim(),
    additionalData: {
      'role': 'patient',
      'phone': _phoneController.text.trim(),
    },
  );

  if (success && mounted) {
    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Registration successful! Please check your email.'),
      ),
    );
  } else {
    // Show error
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(auth.errorMessage ?? 'Registration failed')),
    );
  }
}
```

### 7.3 Update Profile Picture Upload

```dart
import '../services/supabase_storage_service.dart';

class ProfileScreen extends StatelessWidget {
  final _storageService = SupabaseStorageService();

  Future<void> _uploadProfilePicture() async {
    final auth = context.read<SupabaseAuthProvider>();
    final userId = auth.currentUser?.id;
    
    if (userId == null) return;

    // Pick image
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    
    if (image == null) return;

    try {
      // Upload to Supabase
      final url = await _storageService.uploadProfilePicture(
        userId,
        File(image.path),
      );

      // Update user metadata
      await auth.updateProfile(avatarUrl: url);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile picture updated!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Upload failed: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<SupabaseAuthProvider>();
    final user = auth.currentUser;

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: user?.userMetadata?['avatar_url'] != null
                  ? NetworkImage(user!.userMetadata!['avatar_url'])
                  : null,
              child: user?.userMetadata?['avatar_url'] == null
                  ? const Icon(Icons.person, size: 50)
                  : null,
            ),
            const SizedBox(height: 16),
            Text(
              user?.userMetadata?['full_name'] ?? 'No name',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Text(user?.email ?? 'No email'),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _uploadProfilePicture,
              icon: const Icon(Icons.upload),
              label: const Text('Upload Photo'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => auth.signOut(),
              child: const Text('Sign Out'),
            ),
          ],
        ),
      ),
    );
  }
}
```

### 7.4 Update API Calls with Auth Token

For all API calls to your backend, include the Supabase auth token:

```dart
import 'package:dio/dio.dart';
import '../config/supabase_config.dart';

class ApiService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'http://10.0.2.2:8000', // Your backend URL
    ),
  );

  ApiService() {
    // Add interceptor to include auth token
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final token = SupabaseConfig.getAccessToken();
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
      ),
    );
  }

  Future<Response> get(String endpoint) async {
    return await _dio.get(endpoint);
  }

  Future<Response> post(String endpoint, dynamic data) async {
    return await _dio.post(endpoint, data: data);
  }
}
```

---

## Step 8: Testing

### 8.1 Test Authentication

1. **Run the app**:
   ```bash
   flutter run
   ```

2. **Test Sign Up**:
   - Enter email, password, name
   - Click "Sign Up"
   - Check your email for verification link
   - Click the link to verify

3. **Test Sign In**:
   - Enter credentials
   - Click "Sign In"
   - Should navigate to home screen

4. **Test Sign Out**:
   - Click "Sign Out" button
   - Should return to login screen

### 8.2 Test Database

1. Go to Supabase **Table Editor**
2. Click `users` table
3. Verify your registered user appears
4. Check that `email`, `created_at`, and metadata are saved

### 8.3 Test Storage

1. Upload a profile picture
2. Go to Supabase **Storage** → `profile-pictures`
3. Verify image was uploaded under your user ID folder
4. Check that image displays in app

### 8.4 Test Backend Integration

1. **Start your backend**:
   ```bash
   cd backend
   python auth_backend.py
   ```

2. **Make API call from Flutter** (e.g., M-Pesa payment)
3. Check that request includes auth token in headers
4. Verify backend processes request successfully

### 8.5 Monitor Logs

- **Flutter**: Check console for errors
- **Backend**: Check terminal for request logs
- **Supabase**: Go to **Logs** section to monitor database queries

---

## Troubleshooting

### ❌ Error: "Invalid API key"

**Solution**: Double-check that you copied the correct `anon` key (not `service_role` key) into `supabase_config.dart`.

### ❌ Error: "Failed to connect to database"

**Solution**:
1. Verify `DATABASE_URL` in `backend/.env` is correct
2. Check that you replaced `[YOUR-PASSWORD]` with actual password
3. Ensure `psycopg2-binary` is installed: `pip install psycopg2-binary`

### ❌ Error: "Email not confirmed"

**Solution**:
1. Check your email inbox for verification link
2. In Supabase dashboard, go to **Authentication** → **Users**
3. Manually confirm the user if needed

### ❌ Error: "Row Level Security policy violation"

**Solution**:
1. Go to **SQL Editor** in Supabase
2. Verify RLS policies were created correctly
3. Re-run the policy SQL commands from Step 5

### ❌ Error: "Storage: Access denied"

**Solution**:
1. Go to **Storage** → Select bucket → **Policies**
2. Verify policies allow user to upload/download
3. Re-create policies from Step 6

### ❌ App compiles but authentication doesn't work

**Solution**:
1. Check that `Supabase.initialize()` is called in `main.dart`
2. Verify `SupabaseAuthProvider` is added to providers
3. Check console for error messages
4. Ensure internet connection is active

### ❌ Backend can't connect to Supabase

**Solution**:
1. Verify PostgreSQL connection string format:
   ```
   postgresql://postgres:[PASSWORD]@db.[PROJECT-REF].supabase.co:5432/postgres
   ```
2. Check that IP restrictions are not enabled (Supabase → Settings → Database → Connection pooling)
3. Test connection with:
   ```bash
   psql "postgresql://postgres:[PASSWORD]@db.[PROJECT-REF].supabase.co:5432/postgres"
   ```

---

## 🎉 Next Steps

### Production Checklist

Before deploying to production:

- [ ] Change `JWT_SECRET_KEY` to strong random value
- [ ] Enable SSL/HTTPS for backend
- [ ] Set up custom domain for Supabase (optional)
- [ ] Configure email templates in Supabase
- [ ] Enable database backups (Supabase → Settings → Database → Backups)
- [ ] Set up monitoring and alerts
- [ ] Review and tighten RLS policies
- [ ] Enable two-factor authentication (Supabase → Authentication → Settings)
- [ ] Update `MPESA_ENVIRONMENT` to `production`

### Additional Features to Explore

- **Real-time subscriptions**: Listen to database changes in real-time
- **Edge Functions**: Run serverless functions on Supabase
- **Database webhooks**: Trigger actions on database events
- **PostgREST API**: Auto-generated REST API for your database
- **Vector search**: For AI/ML features using pgvector

---

## 📚 Resources

- **Supabase Docs**: https://supabase.com/docs
- **Flutter Supabase Docs**: https://supabase.com/docs/guides/getting-started/quickstarts/flutter
- **Supabase YouTube**: https://www.youtube.com/c/Supabase
- **Community**: https://github.com/supabase/supabase/discussions

---

## ✅ Summary

You have now:

1. ✅ Installed `supabase_flutter` package
2. ✅ Created Supabase project and got credentials
3. ✅ Configured Flutter app with Supabase
4. ✅ Updated backend to use PostgreSQL (Supabase)
5. ✅ Set up database with RLS policies
6. ✅ Created storage buckets with access policies
7. ✅ Integrated authentication in your app
8. ✅ Tested everything works

Your app is now fully integrated with Supabase for **authentication, database, and storage**! 🎊

---

**Need Help?**

- Check the **Troubleshooting** section above
- Review `SUPABASE_SETUP_GUIDE.md` for more details
- Ask in the conversation if you encounter issues

**Good luck! 🚀**

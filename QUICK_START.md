# 🚀 Supabase Quick Start - TumorHeal

**Fast track guide to get Supabase running in 15 minutes**

---

## Step 1: Install Package (2 minutes)

```yaml
# pubspec.yaml
dependencies:
  supabase_flutter: ^2.0.0
```

```bash
flutter pub get
```

---

## Step 2: Create Supabase Account (5 minutes)

1. Go to https://supabase.com → Sign up
2. Create project: **tumorheal-db**
3. Save these from **Settings** → **API**:
   - Project URL: `https://xxxxx.supabase.co`
   - anon key: `eyJhbGci...`
4. Get connection string from **Settings** → **Database**:
   - `postgresql://postgres:[PASSWORD]@db.xxxxx.supabase.co:5432/postgres`

---

## Step 3: Configure App (3 minutes)

### Update `lib/config/supabase_config.dart`:
```dart
static const String supabaseUrl = 'YOUR_PROJECT_URL_HERE';
static const String supabaseAnonKey = 'YOUR_ANON_KEY_HERE';
```

### Update `lib/main.dart`:
```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Supabase.initialize(
    url: SupabaseConfig.supabaseUrl,
    anonKey: SupabaseConfig.supabaseAnonKey,
  );
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SupabaseAuthProvider()..initialize()),
      ],
      child: const MyApp(),
    ),
  );
}
```

---

## Step 4: Configure Backend (3 minutes)

### Install PostgreSQL driver:
```bash
pip install psycopg2-binary
```

### Update `backend/.env`:
```env
DATABASE_URL=postgresql://postgres:[YOUR-PASSWORD]@db.xxxxx.supabase.co:5432/postgres
```

### Start backend (creates tables automatically):
```bash
python auth_backend.py
```

---

## Step 5: Create Storage Buckets (2 minutes)

In Supabase dashboard → **Storage** → Create buckets:

| Bucket | Public? |
|--------|---------|
| profile-pictures | Yes |
| medical-documents | No |
| scan-images | No |
| reports | No |

---

## ✅ Test It!

```bash
flutter run
```

Try:
- Sign up with email
- Sign in
- Upload profile picture
- Sign out

---

## 📖 Files Created

You now have these ready-to-use files:

1. **`lib/config/supabase_config.dart`** - Supabase configuration
2. **`lib/providers/supabase_auth_provider.dart`** - Authentication provider
3. **`lib/services/supabase_storage_service.dart`** - File upload service
4. **`SUPABASE_COMPLETE_INTEGRATION.md`** - Full integration guide
5. **`SUPABASE_SETUP_GUIDE.md`** - Detailed setup documentation

---

## 🔑 Common Commands

### Authentication
```dart
final auth = context.read<SupabaseAuthProvider>();

// Sign up
await auth.signUp(email: email, password: password, fullName: name);

// Sign in
await auth.signIn(email: email, password: password);

// Sign out
await auth.signOut();

// Reset password
await auth.resetPassword(email);

// Update profile
await auth.updateProfile(fullName: name, phone: phone);
```

### Storage
```dart
final storage = SupabaseStorageService();

// Upload profile picture
final url = await storage.uploadProfilePicture(userId, file);

// Upload medical document
final url = await storage.uploadMedicalDocument(
  userId: userId,
  file: file,
  fileName: 'report.pdf',
);

// Delete file
await storage.deleteFile(bucket: 'profile-pictures', path: 'user123/photo.jpg');
```

---

## 🐛 Quick Fixes

**Can't compile?**
→ Run `flutter pub get` again

**Authentication fails?**
→ Check Project URL and anon key in `supabase_config.dart`

**Backend can't connect?**
→ Verify `DATABASE_URL` in `backend/.env` (password must be correct)

**Storage upload fails?**
→ Create buckets in Supabase dashboard first

**Email verification required?**
→ Check inbox or disable in Supabase → **Authentication** → **Settings** → **Email Auth** → Disable "Confirm email"

---

## 📱 Example Usage

### Login Screen
```dart
final auth = context.read<SupabaseAuthProvider>();

ElevatedButton(
  onPressed: () async {
    final success = await auth.signIn(
      email: emailController.text,
      password: passwordController.text,
    );
    
    if (success) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      showSnackBar(auth.errorMessage);
    }
  },
  child: const Text('Login'),
)
```

### Profile Picture Upload
```dart
final storage = SupabaseStorageService();
final auth = context.read<SupabaseAuthProvider>();

final picker = ImagePicker();
final image = await picker.pickImage(source: ImageSource.gallery);

if (image != null) {
  final url = await storage.uploadProfilePicture(
    auth.currentUser!.id,
    File(image.path),
  );
  
  await auth.updateProfile(avatarUrl: url);
}
```

---

## 🎯 Production Checklist

Before going live:

- [ ] Change `JWT_SECRET_KEY` in `.env` to strong random value
- [ ] Enable Row Level Security (RLS) on all tables
- [ ] Set up storage bucket policies
- [ ] Enable email verification
- [ ] Configure custom email templates
- [ ] Set up database backups
- [ ] Switch M-Pesa to production mode
- [ ] Use HTTPS for backend
- [ ] Review security rules

---

## 📞 Need Help?

1. Check **SUPABASE_COMPLETE_INTEGRATION.md** for detailed steps
2. Check **SUPABASE_SETUP_GUIDE.md** for advanced configuration
3. Visit https://supabase.com/docs
4. Ask in this conversation

---

## 🎉 You're Ready!

**Your app now has:**
- ✅ Cloud authentication (Supabase Auth)
- ✅ Cloud database (PostgreSQL)
- ✅ File storage (Supabase Storage)
- ✅ Real-time capabilities (optional)
- ✅ Auto-scaling infrastructure
- ✅ Free tier for development

**Happy coding! 🚀**

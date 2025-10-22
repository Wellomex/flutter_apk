# 🎯 Quick Reference: External API Setup

## 1️⃣ Update Configuration (1 minute)

**File:** `lib/config/env_config.dart`

```dart
// Your external backend URL
static const String externalApiBaseUrl = 'https://your-backend.com';

// Enable external backend
static const bool useExternalBackend = true;
```

---

## 2️⃣ Common URLs

### Localhost (Another Folder/Computer)
```dart
// Same computer, different port
'http://localhost:3000'

// Another computer on network (replace with actual IP)
'http://192.168.1.100:8000'
```

### Cloud Hosting
```dart
// Render
'https://tumorheal-api.onrender.com'

// Railway
'https://tumorheal-production.up.railway.app'

// Heroku
'https://tumorheal-api.herokuapp.com'

// Vercel/Netlify (for serverless)
'https://tumorheal-api.vercel.app'
```

### Tunneling (Temporary)
```dart
// ngrok
'https://abc123.ngrok.io'

// localtunnel
'https://your-subdomain.loca.lt'
```

---

## 3️⃣ Required Backend Endpoints

Your external backend must have:

```
✅ POST /api/v1/auth/register
✅ POST /api/v1/auth/login
✅ POST /api/v1/payments/mpesa/stk-push
✅ GET  /api/v1/payments/mpesa/stk-push/status/{id}
✅ GET  /health
```

---

## 4️⃣ Test Connection

```bash
# Test if backend is reachable
curl https://your-backend.com/health

# Expected response:
{"status": "ok"}
```

---

## 🔧 Quick Troubleshooting

| Error | Fix |
|-------|-----|
| Connection timeout | ✅ Check backend is running<br>✅ Verify URL is correct |
| CORS error | ✅ Enable CORS on backend |
| 401 Unauthorized | ✅ Check token in request headers |
| SSL error | ✅ Use `https://` not `http://` |

---

## 📝 Example: Using Backend on Another Computer

**Step 1:** Find backend computer's IP
```bash
# Windows
ipconfig
# Look for: IPv4 Address: 192.168.1.100

# Mac/Linux
ifconfig
# Look for: inet 192.168.1.100
```

**Step 2:** Update config
```dart
static const String externalApiBaseUrl = 'http://192.168.1.100:8000';
static const bool useExternalBackend = true;
```

**Step 3:** Run app
```bash
flutter run
```

---

## 🚀 That's It!

Your app now uses external backend APIs instead of local backend.

**See full guide:** `EXTERNAL_API_INTEGRATION_GUIDE.md`

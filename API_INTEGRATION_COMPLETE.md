# ✅ Backend API Integration Complete

Your Flutter app is now fully configured to work with all your backend APIs.

---

## 📋 Configured Endpoints

### ✅ Authentication APIs
| Endpoint | Method | Flutter Method | File |
|----------|--------|----------------|------|
| `/api/v1/auth/register` | POST | `auth.register()` | `auth_provider.dart` |
| `/api/v1/auth/login` | POST | `auth.login()` | `auth_provider.dart` |
| `/api/v1/auth/me` | GET | `auth.getUserInfo()` | `auth_provider.dart` |
| `/api/v1/auth/profile` | PUT | `auth.updateProfile()` | `auth_provider.dart` |
| `/api/v1/auth/settings` | PUT | `auth.updateSettings()` | `auth_provider.dart` |
| `/api/v1/auth/reset-password` | POST | `auth.resetPassword()` | `auth_provider.dart` |
| `/api/v1/auth/reset-password/confirm` | POST | `auth.confirmResetPassword()` | `auth_provider.dart` |
| `/api/v1/auth/otp/request` | POST | `auth.requestOTP()` | `auth_provider.dart` |
| `/api/v1/auth/otp/verify` | POST | `auth.verifyOTP()` | `auth_provider.dart` |
| `/api/v1/auth/refresh` | POST | `auth.refreshToken()` | `auth_provider.dart` |
| `/api/v1/auth/logout` | POST | `auth.logout()` | `auth_provider.dart` |

### ✅ M-Pesa Payment APIs
| Endpoint | Method | Flutter Method | File |
|----------|--------|----------------|------|
| `/api/v1/payments/mpesa/stk-push` | POST | `mpesa.initiateStkPush()` | `mpesa_service.dart` |
| `/api/v1/payments/mpesa/check-payment-status` | POST | `mpesa.queryStkPushStatus()` | `mpesa_service.dart` |
| `/api/v1/payments/mpesa/callback` | POST | Webhook (backend only) | - |

### ✅ Health Profile APIs
| Endpoint | Method | Flutter Method | File |
|----------|--------|----------------|------|
| `/api/v1/health/profile` | POST | `health.createHealthProfile()` | `health_profile_service.dart` |
| `/api/v1/health/profile` | GET | `health.getHealthProfile()` | `health_profile_service.dart` |
| `/api/v1/health/profile` | PUT | `health.updateHealthProfile()` | `health_profile_service.dart` |
| `/api/v1/health/metrics` | POST | `health.createHealthMetric()` | `health_profile_service.dart` |
| `/api/v1/health/metrics/summary` | GET | `health.getMetricsSummary()` | `health_profile_service.dart` |
| `/api/v1/health/metrics/history` | GET | `health.getMetricsHistory()` | `health_profile_service.dart` |

### ✅ Optimization Plan APIs
| Endpoint | Method | Flutter Method | File |
|----------|--------|----------------|------|
| `/api/v1/plan/run` | POST | `plan.generatePlan()` | `optimization_plan_service.dart` |

---

## 📁 Files Created/Updated

### Configuration
- ✅ `lib/config/env_config.dart` - All API endpoints defined

### Services
- ✅ `lib/services/api_service.dart` - HTTP client with auth token injection
- ✅ `lib/services/mpesa_service.dart` - M-Pesa payment service
- ✅ `lib/services/health_profile_service.dart` - Health profile service (NEW)
- ✅ `lib/services/optimization_plan_service.dart` - Optimization plan service (NEW)

### Providers
- ✅ `lib/providers/auth_provider.dart` - Authentication provider with all methods

---

## 🎯 How to Use

### 1. Authentication Example

```dart
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

// Register
final auth = context.read<AuthProvider>();
final request = AuthRequest(
  email: 'user@example.com',
  password: 'password123',
);
final success = await auth.register(request);

// Login
final success = await auth.login('user@example.com', 'password123');

// Get user info
final user = await auth.getUserInfo();

// Update profile
final success = await auth.updateProfile({
  'name': 'John Doe',
  'phone': '+254712345678',
});

// Request OTP
final success = await auth.requestOTP('user@example.com', 'login');

// Verify OTP
final success = await auth.verifyOTP('user@example.com', '123456', 'login');

// Logout
await auth.logout();
```

### 2. M-Pesa Payment Example

```dart
import '../services/mpesa_service.dart';
import '../services/api_service.dart';

final mpesa = MpesaService(apiService: ApiService());

// Initiate payment
final response = await mpesa.initiateStkPush(
  phoneNumber: '254712345678',
  amount: 100.0,
  accountReference: 'TumorHeal',
  transactionDesc: 'Consultation fee',
);

// Check payment status
final status = await mpesa.queryStkPushStatus(
  checkoutRequestId: response.checkoutRequestId,
);
```

### 3. Health Profile Example

```dart
import '../services/health_profile_service.dart';
import '../services/api_service.dart';

final health = HealthProfileService(apiService: ApiService());

// Create health profile
final profile = await health.createHealthProfile(
  profileData: {
    'age': 30,
    'gender': 'male',
    'height': 175,
    'weight': 70,
  },
);

// Get health profile
final profile = await health.getHealthProfile();

// Update health profile
final updated = await health.updateHealthProfile(
  profileData: {
    'weight': 72,
  },
);

// Create health metric
final metric = await health.createHealthMetric(
  metricType: 'blood_pressure',
  value: '120/80',
  unit: 'mmHg',
  notes: 'Morning reading',
);

// Get metrics summary
final summary = await health.getMetricsSummary(
  metricType: 'blood_pressure',
  period: 'week',
);

// Get metrics history
final history = await health.getMetricsHistory(
  metricType: 'blood_pressure',
  limit: 30,
);
```

### 4. Optimization Plan Example

```dart
import '../services/optimization_plan_service.dart';
import '../services/api_service.dart';

final planService = OptimizationPlanService(apiService: ApiService());

// Generate plan
final plan = await planService.generatePlan(
  focusArea: 'nutrition',
  durationDays: 30,
  preferences: {
    'dietary_restrictions': ['vegetarian'],
    'fitness_level': 'intermediate',
  },
);
```

---

## 🔐 Authentication Flow

1. **User logs in** → Token stored in secure storage
2. **API Service automatically adds token** to all requests:
   ```
   Authorization: Bearer {token}
   ```
3. **All authenticated endpoints work automatically**
4. **Token expired (401)?** → Call `auth.refreshToken()` or re-login

---

## 🚀 Quick Start

### Step 1: Set Your Backend URL

```dart
// lib/config/env_config.dart
static const String externalApiBaseUrl = 'http://10.0.2.2:8000';
```

### Step 2: Start Your Backend

```bash
# Start your backend server on port 8000
# The app will connect automatically
```

### Step 3: Run Your App

```bash
flutter run
```

### Step 4: Test Features

1. **Register/Login** - Try creating account and logging in
2. **M-Pesa** - Test payment flow
3. **Health Profile** - Create and update health data
4. **Optimization Plan** - Generate personalized plan

---

## 🐛 Debugging

### Enable Debug Logs

Already enabled in `env_config.dart`:
```dart
static const bool enableDebugLogs = true;
```

You'll see all API requests/responses in the console:
```
→ POST http://10.0.2.2:8000/api/v1/auth/login
   {"email": "user@example.com", "password": "..."}
   
← 200 OK
   {"access_token": "...", "user": {...}}
```

### Common Issues

| Issue | Solution |
|-------|----------|
| Connection timeout | Check backend is running on port 8000 |
| 401 Unauthorized | Token expired - call `auth.refreshToken()` |
| 404 Not Found | Verify endpoint path matches backend |
| CORS error (web) | Enable CORS on backend |

---

## 📝 API Response Format

### Success Response
```json
{
  "data": {...},
  "message": "Success",
  "status": 200
}
```

### Error Response
```json
{
  "error": {
    "message": "Error description",
    "code": "ERROR_CODE",
    "details": {}
  },
  "status": 400
}
```

---

## ✅ Summary

Your Flutter app is now configured to work with all backend APIs:

- ✅ **11 Authentication endpoints** - Full auth flow
- ✅ **3 M-Pesa endpoints** - Payment processing
- ✅ **6 Health Profile endpoints** - Health data management
- ✅ **1 Optimization Plan endpoint** - Plan generation

**All services are ready to use!** Just start your backend and run the app. 🚀

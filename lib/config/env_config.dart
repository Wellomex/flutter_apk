/// Environment Configuration
/// Configure your external backend API URLs here
class EnvConfig {
  // ============ API Configuration ============
  
  /// Set this to your external backend URL
  /// Examples:
  /// - Production: 'https://api.yourdomain.com'
  /// - Staging: 'https://staging-api.yourdomain.com'
  /// - Local network: 'http://192.168.1.100:8000'
  /// - ngrok/tunneling: 'https://your-app.ngrok.io'
  /// - Render/Railway/Vercel: 'https://your-backend.onrender.com'
  static const String externalApiBaseUrl = 'http://10.0.2.2:8000';
  
  /// Use external backend instead of local
  /// Set to true to use externalApiBaseUrl
  /// Set to false to use local backend (10.0.2.2:8000 for Android emulator)
  static const bool useExternalBackend = true;
  
  /// Local backend URL (for Android emulator)
  static const String localApiBaseUrl = 'http://10.0.2.2:8000';
  
  /// Local backend URL (for iOS simulator)
  static const String localApiBaseUrlIOS = 'http://localhost:8000';
  
  /// Local backend URL (for physical device on same network)
  /// Replace with your computer's local IP address
  static const String localApiBaseUrlDevice = 'http://192.168.1.100:8000';
  
  // ============ Computed Values ============
  
  /// Get the active API base URL based on configuration
  static String get apiBaseUrl {
    if (useExternalBackend) {
      return externalApiBaseUrl;
    }
    // Return local URL (you can add platform detection here if needed)
    return localApiBaseUrl;
  }
  
  // ============ API Endpoints ============
  
  /// Authentication endpoints
  static String get authRegisterUrl => '$apiBaseUrl/api/v1/auth/register';
  static String get authLoginUrl => '$apiBaseUrl/api/v1/auth/login';
  static String get authMeUrl => '$apiBaseUrl/api/v1/auth/me';
  static String get authProfileUrl => '$apiBaseUrl/api/v1/auth/profile';
  static String get authSettingsUrl => '$apiBaseUrl/api/v1/auth/settings';
  static String get authLogoutUrl => '$apiBaseUrl/api/v1/auth/logout';
  static String get authRefreshUrl => '$apiBaseUrl/api/v1/auth/refresh';
  static String get authResetPasswordUrl => '$apiBaseUrl/api/v1/auth/reset-password';
  static String get authResetPasswordConfirmUrl => '$apiBaseUrl/api/v1/auth/reset-password/confirm';
  static String get authOtpRequestUrl => '$apiBaseUrl/api/v1/auth/otp/request';
  static String get authOtpVerifyUrl => '$apiBaseUrl/api/v1/auth/otp/verify';
  
  /// M-Pesa payment endpoints
  static String get mpesaStkPushUrl => '$apiBaseUrl/api/v1/payments/mpesa/stk-push';
  static String get mpesaCheckPaymentStatusUrl => '$apiBaseUrl/api/v1/payments/mpesa/check-payment-status';
  static String get mpesaCallbackUrl => '$apiBaseUrl/api/v1/payments/mpesa/callback';
  
  /// Health Profile endpoints
  static String get healthProfileUrl => '$apiBaseUrl/api/v1/health/profile';
  static String get healthMetricsUrl => '$apiBaseUrl/api/v1/health/metrics';
  static String get healthMetricsSummaryUrl => '$apiBaseUrl/api/v1/health/metrics/summary';
  static String get healthMetricsHistoryUrl => '$apiBaseUrl/api/v1/health/metrics/history';
  
  /// Optimization Plan endpoints
  static String get planRunUrl => '$apiBaseUrl/api/v1/plan/run';
  
  /// Health check
  static String get healthCheckUrl => '$apiBaseUrl/health';
  static String get apiVersionUrl => '$apiBaseUrl/api/v1/version';
  
  // ============ Request Configuration ============
  
  /// Request timeout settings
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
  static const Duration sendTimeout = Duration(seconds: 30);
  
  /// Retry configuration
  static const int maxRetries = 3;
  static const Duration retryDelay = Duration(seconds: 2);
  
  /// Debug mode
  static const bool enableDebugLogs = true;
  
  // ============ Simple Endpoint Paths (for services) ============
  
  /// Auth endpoint paths
  static const String registerEndpoint = '/api/v1/auth/register';
  static const String loginEndpoint = '/api/v1/auth/login';
  static const String userMeEndpoint = '/api/v1/auth/me';
  static const String updateProfileEndpoint = '/api/v1/auth/profile';
  static const String updateSettingsEndpoint = '/api/v1/auth/settings';
  static const String resetPasswordEndpoint = '/api/v1/auth/reset-password';
  static const String requestOtpEndpoint = '/api/v1/auth/otp/request';
  static const String verifyOtpEndpoint = '/api/v1/auth/otp/verify';
  
  /// M-Pesa endpoint paths
  static const String mpesaStkPushEndpoint = '/api/v1/payments/mpesa/stk-push';
  static const String mpesaCheckStatusEndpoint = '/api/v1/payments/mpesa/check-payment-status';
}

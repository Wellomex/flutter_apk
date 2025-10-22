import 'package:supabase_flutter/supabase_flutter.dart';

/// Supabase Configuration for TumorHeal App
class SupabaseConfig {
  // ============ Supabase Credentials ============
  // Get these from: https://app.supabase.com → Project Settings → API
  
  static const String supabaseUrl = 'https://lywtoarhqczjgmsuuhkd.supabase.co';
  static const String supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imx5d3RvYXJocWN6amdtc3V1aGtkIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjEwODM4NTksImV4cCI6MjA3NjY1OTg1OX0.8LSsGVWx3o9N_OemOHi2uU5fuyvDBllXyyov0uGq32k';
  
  // ============ Storage Bucket Names ============
  static const String profilePicturesBucket = 'profile-pictures';
  static const String medicalDocumentsBucket = 'medical-documents';
  static const String reportsBucket = 'reports';
  static const String scanImagesBucket = 'scan-images';
  
  // ============ Configuration ============
  static const bool enableRealtime = true;
  static const bool enableAutoRefreshToken = true;
  static const int storageRetryAttempts = 10;
  
  /// Initialize Supabase
  static Future<void> initialize() async {
    try {
      await Supabase.initialize(
        url: supabaseUrl,
        anonKey: supabaseAnonKey,
        authOptions: const FlutterAuthClientOptions(
          authFlowType: AuthFlowType.pkce,
          autoRefreshToken: enableAutoRefreshToken,
        ),
        realtimeClientOptions: RealtimeClientOptions(
          logLevel: RealtimeLogLevel.info,
          timeout: const Duration(seconds: 30),
        ),
        storageOptions: const StorageClientOptions(
          retryAttempts: storageRetryAttempts,
        ),
        debug: false, // Set to true for development
      );
      
      print('✅ Supabase initialized successfully');
    } catch (e) {
      print('❌ Error initializing Supabase: $e');
      rethrow;
    }
  }
  
  /// Get Supabase client instance
  static SupabaseClient get client => Supabase.instance.client;
  
  /// Storage client
  static SupabaseStorageClient get storage => client.storage;
  
  /// Auth client
  static GoTrueClient get auth => client.auth;
  
  /// Get current user
  static User? get currentUser => auth.currentUser;
  
  /// Get current session
  static Session? get currentSession => auth.currentSession;
  
  /// Check if user is authenticated
  static bool get isAuthenticated => currentUser != null;
  
  /// Database query helper
  static SupabaseQueryBuilder from(String table) => client.from(table);
  
  /// Realtime channel
  static RealtimeChannel channel(String name) => client.channel(name);
  
  /// Sign out
  static Future<void> signOut() async {
    await auth.signOut();
  }
}

// Convenience getter for quick access
final supabase = Supabase.instance.client;

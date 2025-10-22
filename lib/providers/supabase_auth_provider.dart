import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../config/supabase_config.dart';
import '../models/user_model.dart' as app_models;

/// Supabase Authentication Provider
/// Replaces the existing auth provider with Supabase authentication
class SupabaseAuthProvider with ChangeNotifier {
  final _auth = SupabaseConfig.auth;
  User? _currentUser;
  bool _isLoading = false;
  String? _errorMessage;

  // Getters
  User? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isAuthenticated => _currentUser != null;

  /// Initialize auth state (check if user is already logged in)
  Future<void> initialize() async {
    _isLoading = true;
    notifyListeners();

    try {
      _currentUser = _auth.currentUser;
      
      // Listen to auth state changes
      _auth.onAuthStateChange.listen((data) {
        _currentUser = data.session?.user;
        notifyListeners();
      });
    } catch (e) {
      _errorMessage = 'Failed to initialize auth: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Sign up with email and password
  Future<bool> signUp({
    required String email,
    required String password,
    required String fullName,
    Map<String, dynamic>? additionalData,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await _auth.signUp(
        email: email,
        password: password,
        data: {
          'full_name': fullName,
          ...?additionalData,
        },
      );

      if (response.user != null) {
        _currentUser = response.user;
        _errorMessage = null;
        notifyListeners();
        return true;
      } else {
        _errorMessage = 'Sign up failed. Please try again.';
        return false;
      }
    } on AuthException catch (e) {
      _errorMessage = e.message;
      return false;
    } catch (e) {
      _errorMessage = 'An unexpected error occurred: $e';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Sign in with email and password
  Future<bool> signIn({
    required String email,
    required String password,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await _auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user != null) {
        _currentUser = response.user;
        _errorMessage = null;
        notifyListeners();
        return true;
      } else {
        _errorMessage = 'Sign in failed. Please check your credentials.';
        return false;
      }
    } on AuthException catch (e) {
      _errorMessage = e.message;
      return false;
    } catch (e) {
      _errorMessage = 'An unexpected error occurred: $e';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Sign out
  Future<void> signOut() async {
    _isLoading = true;
    notifyListeners();

    try {
      await _auth.signOut();
      _currentUser = null;
      _errorMessage = null;
    } catch (e) {
      _errorMessage = 'Failed to sign out: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Send password reset email
  Future<bool> resetPassword(String email) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _auth.resetPasswordForEmail(email);
      _errorMessage = null;
      return true;
    } on AuthException catch (e) {
      _errorMessage = e.message;
      return false;
    } catch (e) {
      _errorMessage = 'Failed to send reset email: $e';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Update password
  Future<bool> updatePassword(String newPassword) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await _auth.updateUser(
        UserAttributes(password: newPassword),
      );

      if (response.user != null) {
        _errorMessage = null;
        return true;
      } else {
        _errorMessage = 'Failed to update password';
        return false;
      }
    } on AuthException catch (e) {
      _errorMessage = e.message;
      return false;
    } catch (e) {
      _errorMessage = 'Failed to update password: $e';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Update user profile
  Future<bool> updateProfile({
    String? fullName,
    String? phone,
    String? avatarUrl,
    Map<String, dynamic>? additionalData,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final data = <String, dynamic>{};
      
      if (fullName != null) data['full_name'] = fullName;
      if (phone != null) data['phone'] = phone;
      if (avatarUrl != null) data['avatar_url'] = avatarUrl;
      if (additionalData != null) data.addAll(additionalData);

      final response = await _auth.updateUser(
        UserAttributes(data: data),
      );

      if (response.user != null) {
        _currentUser = response.user;
        _errorMessage = null;
        notifyListeners();
        return true;
      } else {
        _errorMessage = 'Failed to update profile';
        return false;
      }
    } on AuthException catch (e) {
      _errorMessage = e.message;
      return false;
    } catch (e) {
      _errorMessage = 'Failed to update profile: $e';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Get current session
  Session? getSession() {
    return _auth.currentSession;
  }

  /// Get access token
  String? getAccessToken() {
    return _auth.currentSession?.accessToken;
  }

  /// Refresh session
  Future<bool> refreshSession() async {
    try {
      final response = await _auth.refreshSession();
      if (response.session != null) {
        _currentUser = response.user;
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      _errorMessage = 'Failed to refresh session: $e';
      return false;
    }
  }

  /// Sign in with Google (OAuth)
  Future<bool> signInWithGoogle() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final result = await _auth.signInWithOAuth(
        OAuthProvider.google,
        redirectTo: 'tumorheal://login-callback',
      );

      return result;
    } on AuthException catch (e) {
      _errorMessage = e.message;
      return false;
    } catch (e) {
      _errorMessage = 'Google sign in failed: $e';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Sign in with Apple (OAuth)
  Future<bool> signInWithApple() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final result = await _auth.signInWithOAuth(
        OAuthProvider.apple,
        redirectTo: 'tumorheal://login-callback',
      );

      return result;
    } on AuthException catch (e) {
      _errorMessage = e.message;
      return false;
    } catch (e) {
      _errorMessage = 'Apple sign in failed: $e';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Verify OTP (for phone or email verification)
  Future<bool> verifyOTP({
    required String token,
    required OtpType type,
    String? email,
    String? phone,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await _auth.verifyOTP(
        token: token,
        type: type,
        email: email,
        phone: phone,
      );

      if (response.user != null) {
        _currentUser = response.user;
        _errorMessage = null;
        notifyListeners();
        return true;
      } else {
        _errorMessage = 'OTP verification failed';
        return false;
      }
    } on AuthException catch (e) {
      _errorMessage = e.message;
      return false;
    } catch (e) {
      _errorMessage = 'OTP verification failed: $e';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Convert Supabase User to app User model (if needed)
  app_models.User? toAppUser() {
    if (_currentUser == null) return null;

    // Get role from user metadata or default to cancerPatient
    final roleStr = _currentUser!.userMetadata?['role'] as String?;
    final role = roleStr != null 
        ? app_models.UserRole.values.firstWhere(
            (e) => e.name == roleStr,
            orElse: () => app_models.UserRole.cancerPatient,
          )
        : app_models.UserRole.cancerPatient;

    // Get subscription type from metadata or default to none
    final subStr = _currentUser!.userMetadata?['subscription_type'] as String?;
    final subscriptionType = subStr != null
        ? app_models.SubscriptionType.values.firstWhere(
            (e) => e.name == subStr,
            orElse: () => app_models.SubscriptionType.none,
          )
        : app_models.SubscriptionType.none;

    return app_models.User(
      id: _currentUser!.id,
      email: _currentUser!.email ?? '',
      name: _currentUser!.userMetadata?['full_name'] ?? '',
      role: role,
      subscriptionType: subscriptionType,
    );
  }

  /// Clear error message
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}

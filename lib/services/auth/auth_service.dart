import '../../config/env_config.dart';
import '../../models/common/api_error_simple.dart';
import '../api/api_service.dart';
import '../storage/secure_storage.dart';

/// Authentication Service
class AuthService {
  final ApiService _api;
  final SecureStorageService _storage = SecureStorageService();

  AuthService(this._api);

  /// Register new user
  Future<Map<String, dynamic>> register({
    required String email,
    required String password,
    required String name,
    String? phone,
  }) async {
    try {
      final response = await _api.post(
        EnvConfig.registerEndpoint,
        data: {
          'email': email,
          'password': password,
          'name': name,
          if (phone != null) 'phone': phone,
        },
      );

      if (response.data != null) {
        final data = response.data as Map<String, dynamic>;
        
        // Save token if provided
        if (data['access_token'] != null) {
          await _storage.setToken(data['access_token']);
        }
        
        return data;
      }

      throw ApiException(ApiError(
        message: 'Invalid response from server',
        statusCode: 500,
        timestamp: DateTime.now(),
      ));
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(ApiError.fromException(e));
    }
  }

  /// Login user
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _api.post(
        EnvConfig.loginEndpoint,
        data: {
          'email': email,
          'password': password,
        },
      );

      if (response.data != null) {
        final data = response.data as Map<String, dynamic>;
        
        // Save token
        if (data['access_token'] != null) {
          await _storage.setToken(data['access_token']);
        }
        
        return data;
      }

      throw ApiException(ApiError(
        message: 'Invalid response from server',
        statusCode: 500,
        timestamp: DateTime.now(),
      ));
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(ApiError.fromException(e));
    }
  }

  /// Get current user info
  Future<Map<String, dynamic>> getUserInfo() async {
    try {
      final response = await _api.get(EnvConfig.userMeEndpoint);
      
      if (response.data != null) {
        return response.data as Map<String, dynamic>;
      }

      throw ApiException(ApiError(
        message: 'Invalid response from server',
        statusCode: 500,
        timestamp: DateTime.now(),
      ));
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(ApiError.fromException(e));
    }
  }

  /// Update user profile
  Future<Map<String, dynamic>> updateProfile({
    String? name,
    String? phone,
    String? dateOfBirth,
    String? gender,
    String? address,
  }) async {
    try {
      final data = <String, dynamic>{};
      if (name != null) data['name'] = name;
      if (phone != null) data['phone'] = phone;
      if (dateOfBirth != null) data['date_of_birth'] = dateOfBirth;
      if (gender != null) data['gender'] = gender;
      if (address != null) data['address'] = address;

      final response = await _api.put(
        EnvConfig.updateProfileEndpoint,
        data: data,
      );

      if (response.data != null) {
        return response.data as Map<String, dynamic>;
      }

      throw ApiException(ApiError(
        message: 'Invalid response from server',
        statusCode: 500,
        timestamp: DateTime.now(),
      ));
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(ApiError.fromException(e));
    }
  }

  /// Update user settings
  Future<Map<String, dynamic>> updateSettings({
    bool? notifications,
    bool? emailNotifications,
    bool? smsNotifications,
    String? language,
    String? theme,
  }) async {
    try {
      final data = <String, dynamic>{};
      if (notifications != null) data['notifications'] = notifications;
      if (emailNotifications != null) data['email_notifications'] = emailNotifications;
      if (smsNotifications != null) data['sms_notifications'] = smsNotifications;
      if (language != null) data['language'] = language;
      if (theme != null) data['theme'] = theme;

      final response = await _api.put(
        EnvConfig.updateSettingsEndpoint,
        data: data,
      );

      if (response.data != null) {
        return response.data as Map<String, dynamic>;
      }

      throw ApiException(ApiError(
        message: 'Invalid response from server',
        statusCode: 500,
        timestamp: DateTime.now(),
      ));
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(ApiError.fromException(e));
    }
  }

  /// Request password reset
  Future<Map<String, dynamic>> requestPasswordReset({
    required String email,
  }) async {
    try {
      final response = await _api.post(
        EnvConfig.resetPasswordEndpoint,
        data: {'email': email},
      );

      if (response.data != null) {
        return response.data as Map<String, dynamic>;
      }

      return {'message': 'Password reset email sent'};
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(ApiError.fromException(e));
    }
  }

  /// Request OTP
  Future<Map<String, dynamic>> requestOTP({
    required String phone,
  }) async {
    try {
      final response = await _api.post(
        EnvConfig.requestOtpEndpoint,
        data: {'phone': phone},
      );

      if (response.data != null) {
        return response.data as Map<String, dynamic>;
      }

      return {'message': 'OTP sent successfully'};
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(ApiError.fromException(e));
    }
  }

  /// Verify OTP
  Future<Map<String, dynamic>> verifyOTP({
    required String phone,
    required String otp,
  }) async {
    try {
      final response = await _api.post(
        EnvConfig.verifyOtpEndpoint,
        data: {
          'phone': phone,
          'otp': otp,
        },
      );

      if (response.data != null) {
        final data = response.data as Map<String, dynamic>;
        
        // Save token if provided
        if (data['access_token'] != null) {
          await _storage.setToken(data['access_token']);
        }
        
        return data;
      }

      throw ApiException(ApiError(
        message: 'Invalid response from server',
        statusCode: 500,
        timestamp: DateTime.now(),
      ));
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(ApiError.fromException(e));
    }
  }

  /// Logout user
  Future<void> logout() async {
    try {
      // Clear token from storage
      await _storage.deleteToken();
      await _api.clearToken();
    } catch (e) {
      throw ApiException(ApiError.fromException(e));
    }
  }

  /// Check if user is authenticated
  Future<bool> isAuthenticated() async {
    final token = await _storage.getToken();
    return token != null && token.isNotEmpty;
  }

  /// Get stored token
  Future<String?> getToken() async {
    return await _storage.getToken();
  }

  /// Refresh token (if backend supports it)
  Future<Map<String, dynamic>?> refreshToken() async {
    try {
      final response = await _api.post('/auth/refresh');
      
      if (response.data != null) {
        final data = response.data as Map<String, dynamic>;
        
        if (data['access_token'] != null) {
          await _storage.setToken(data['access_token']);
        }
        
        return data;
      }
      
      return null;
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(ApiError.fromException(e));
    }
  }
}

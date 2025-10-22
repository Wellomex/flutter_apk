import 'package:dio/dio.dart';
import '../../config/env_config.dart';
import '../../models/common/api_error_simple.dart';
import '../storage/secure_storage.dart';

/// Enhanced API Service with authentication and error handling
class ApiService {
  late final Dio _dio;
  final SecureStorageService _storage = SecureStorageService();

  ApiService() {
    _dio = Dio(BaseOptions(
      baseUrl: EnvConfig.apiBaseUrl,
      connectTimeout: EnvConfig.connectTimeout,
      receiveTimeout: EnvConfig.receiveTimeout,
      sendTimeout: EnvConfig.sendTimeout,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ));

    _setupInterceptors();
  }

  void _setupInterceptors() {
    // Request interceptor - Add auth token
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await _storage.getToken();
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          
          if (EnvConfig.enableDebugLogs) {
            print('→ ${options.method} ${options.uri}');
            print('  Headers: ${options.headers}');
            if (options.data != null) print('  Body: ${options.data}');
          }
          
          return handler.next(options);
        },
        onResponse: (response, handler) {
          if (EnvConfig.enableDebugLogs) {
            print('← ${response.statusCode} ${response.requestOptions.uri}');
            print('  Body: ${response.data}');
          }
          return handler.next(response);
        },
        onError: (error, handler) async {
          if (EnvConfig.enableDebugLogs) {
            print('✗ ${error.response?.statusCode} ${error.requestOptions.uri}');
            print('  Error: ${error.message}');
            if (error.response?.data != null) {
              print('  Response: ${error.response?.data}');
            }
          }

          // Handle 401 Unauthorized - token expired
          if (error.response?.statusCode == 401) {
            print('⚠️  Token expired or invalid');
            // Could implement token refresh here
          }

          return handler.next(error);
        },
      ),
    );

    // Logging interceptor
    if (EnvConfig.enableDebugLogs) {
      _dio.interceptors.add(LogInterceptor(
        requestBody: true,
        responseBody: true,
        error: true,
        requestHeader: true,
        responseHeader: false,
      ));
    }
  }

  /// GET request
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.get<T>(
        path,
        queryParameters: queryParameters,
        options: options,
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// POST request
  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// PUT request
  Future<Response<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.put<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// DELETE request
  Future<Response<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.delete<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// PATCH request
  Future<Response<T>> patch<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.patch<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Handle errors and convert to ApiException
  ApiException _handleError(DioException error) {
    final statusCode = error.response?.statusCode ?? 500;
    final responseData = error.response?.data;

    String message;
    String? code;
    Map<String, dynamic>? details;

    if (responseData != null && responseData is Map<String, dynamic>) {
      message = responseData['message'] ?? 
                responseData['error']?['message'] ??
                error.message ?? 
                'An error occurred';
      code = responseData['code'] ?? responseData['error']?['code'];
      details = responseData['details'] ?? responseData['error']?['details'];
    } else {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
          message = 'Connection timeout';
          break;
        case DioExceptionType.sendTimeout:
          message = 'Send timeout';
          break;
        case DioExceptionType.receiveTimeout:
          message = 'Receive timeout';
          break;
        case DioExceptionType.badResponse:
          message = 'Bad response: ${error.response?.statusMessage}';
          break;
        case DioExceptionType.cancel:
          message = 'Request cancelled';
          break;
        case DioExceptionType.connectionError:
          message = 'Connection error. Please check your internet connection.';
          break;
        default:
          message = error.message ?? 'An unexpected error occurred';
      }
    }

    final apiError = ApiError(
      message: message,
      statusCode: statusCode,
      code: code,
      details: details,
      timestamp: DateTime.now(),
    );

    return ApiException(apiError);
  }

  /// Set auth token
  Future<void> setToken(String token) async {
    await _storage.setToken(token);
  }

  /// Clear auth token
  Future<void> clearToken() async {
    await _storage.deleteToken();
  }

  /// Get current token
  Future<String?> getToken() async {
    return await _storage.getToken();
  }
}

import 'package:dio/dio.dart';
import '../config/env_config.dart';
import '../models/payment_models.dart';
import 'secure_storage.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: EnvConfig.apiBaseUrl,
    connectTimeout: EnvConfig.connectTimeout,
    receiveTimeout: EnvConfig.receiveTimeout,
    sendTimeout: EnvConfig.sendTimeout,
  ));
  
  final SecureStorageService _storage = SecureStorageService();

  ApiService() {
    // Add request/response interceptors for debugging
    if (EnvConfig.enableDebugLogs) {
      _dio.interceptors.add(LogInterceptor(
        requestBody: true,
        responseBody: true,
        error: true,
      ));
    }
    
    // Add auth token interceptor
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // Add auth token to requests if available
          final token = await _storage.getToken();
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onError: (error, handler) async {
          if (error.type == DioExceptionType.connectionTimeout ||
              error.type == DioExceptionType.receiveTimeout) {
            print('⚠️ Request timeout to: ${error.requestOptions.uri}');
          }
          
          // Handle 401 Unauthorized - token expired
          if (error.response?.statusCode == 401) {
            print('⚠️ Unauthorized - Token may be expired');
          }
          
          return handler.next(error);
        },
      ),
    );
  }

  Future<Response> post(String path, Map<String, dynamic> data, {Map<String, dynamic>? headers}) async {
    return _dio.post(path, data: data, options: Options(headers: headers));
  }

  Future<Response> get(String path, {Map<String, dynamic>? params, Map<String, dynamic>? headers}) async {
    return _dio.get(path, queryParameters: params, options: Options(headers: headers));
  }

  Future<Response> put(String path, Map<String, dynamic> data, {Map<String, dynamic>? headers}) async {
    return _dio.put(path, data: data, options: Options(headers: headers));
  }

  Future<Response> delete(String path, {Map<String, dynamic>? headers}) async {
    return _dio.delete(path, options: Options(headers: headers));
  }

  Future<Payment> processPayment(Map<String, dynamic> data) async {
    final response = await post('/api/v1/payments', data);
    return Payment.fromJson(response.data);
  }

  Future<Map<String, dynamic>> verifyPayment(String paymentId, Map<String, dynamic> data) async {
    final response = await post('/api/v1/payments/$paymentId/verify', data);
    return response.data;
  }

  Future<Map<String, dynamic>> analyzePaymentRisk(Map<String, dynamic> data) async {
    final response = await post('/api/v1/payments/risk-analysis', data);
    return response.data;
  }

  Future<String> createPaymentMethod(Map<String, dynamic> data) async {
    final response = await post('/api/v1/payment-methods', data);
    return response.data['id'];
  }
}

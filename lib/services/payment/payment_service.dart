import '../../config/env_config.dart';
import '../../models/common/api_error_simple.dart';
import '../api/api_service.dart';

/// Payment Service
class PaymentService {
  final ApiService _api;

  PaymentService(this._api);

  /// Initiate M-Pesa STK Push
  Future<Map<String, dynamic>> initiateMpesaStkPush({
    required String phoneNumber,
    required double amount,
    String? accountReference,
    String? transactionDesc,
  }) async {
    try {
      final response = await _api.post(
        EnvConfig.mpesaStkPushEndpoint,
        data: {
          'phone_number': phoneNumber,
          'amount': amount,
          'account_reference': accountReference ?? 'TumorHeal',
          'transaction_desc': transactionDesc ?? 'Payment',
        },
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
      throw ApiException(ApiError(
        message: e.toString(),
        statusCode: 500,
        timestamp: DateTime.now(),
      ));
    }
  }

  /// Check M-Pesa payment status
  Future<Map<String, dynamic>> checkMpesaPaymentStatus({
    required String checkoutRequestId,
  }) async {
    try {
      final response = await _api.post(
        EnvConfig.mpesaCheckStatusEndpoint,
        data: {
          'checkout_request_id': checkoutRequestId,
        },
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
      throw ApiException(ApiError(
        message: e.toString(),
        statusCode: 500,
        timestamp: DateTime.now(),
      ));
    }
  }

  /// Get payment history
  Future<List<Map<String, dynamic>>> getPaymentHistory() async {
    try {
      final response = await _api.get('/payments/history');

      if (response.data != null) {
        final data = response.data;
        if (data is List) {
          return data.cast<Map<String, dynamic>>();
        } else if (data is Map && data['payments'] != null) {
          return (data['payments'] as List).cast<Map<String, dynamic>>();
        }
      }

      return [];
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(ApiError(
        message: e.toString(),
        statusCode: 500,
        timestamp: DateTime.now(),
      ));
    }
  }

  /// Get payment by ID
  Future<Map<String, dynamic>> getPaymentById(String paymentId) async {
    try {
      final response = await _api.get('/payments/$paymentId');

      if (response.data != null) {
        return response.data as Map<String, dynamic>;
      }

      throw ApiException(ApiError(
        message: 'Payment not found',
        statusCode: 404,
        timestamp: DateTime.now(),
      ));
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(ApiError(
        message: e.toString(),
        statusCode: 500,
        timestamp: DateTime.now(),
      ));
    }
  }

  /// Process Stripe payment
  Future<Map<String, dynamic>> processStripePayment({
    required String paymentMethodId,
    required double amount,
    String? currency,
  }) async {
    try {
      final response = await _api.post(
        '/payments/stripe',
        data: {
          'payment_method_id': paymentMethodId,
          'amount': amount,
          'currency': currency ?? 'usd',
        },
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
      throw ApiException(ApiError(
        message: e.toString(),
        statusCode: 500,
        timestamp: DateTime.now(),
      ));
    }
  }

  /// Create payment intent (Stripe)
  Future<Map<String, dynamic>> createPaymentIntent({
    required double amount,
    String? currency,
  }) async {
    try {
      final response = await _api.post(
        '/payments/stripe/create-intent',
        data: {
          'amount': amount,
          'currency': currency ?? 'usd',
        },
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
      throw ApiException(ApiError(
        message: e.toString(),
        statusCode: 500,
        timestamp: DateTime.now(),
      ));
    }
  }

  /// Verify payment
  Future<Map<String, dynamic>> verifyPayment({
    required String paymentId,
  }) async {
    try {
      final response = await _api.post(
        '/payments/verify',
        data: {'payment_id': paymentId},
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
      throw ApiException(ApiError(
        message: e.toString(),
        statusCode: 500,
        timestamp: DateTime.now(),
      ));
    }
  }

  /// Cancel payment
  Future<Map<String, dynamic>> cancelPayment({
    required String paymentId,
  }) async {
    try {
      final response = await _api.post(
        '/payments/cancel',
        data: {'payment_id': paymentId},
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
      throw ApiException(ApiError(
        message: e.toString(),
        statusCode: 500,
        timestamp: DateTime.now(),
      ));
    }
  }
}

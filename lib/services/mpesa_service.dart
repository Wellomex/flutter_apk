import 'package:dio/dio.dart';
import 'api_service.dart';
import '../models/mpesa_models.dart';

class MpesaService {
  final ApiService _api;

  MpesaService({required ApiService apiService}) : _api = apiService;

  /// Initiate M-Pesa STK Push (Lipa Na M-Pesa Online)
  /// This prompts the user to enter their M-Pesa PIN on their phone
  Future<MpesaStkPushResponse> initiateStkPush({
    required String phoneNumber,
    required double amount,
    required String accountReference,
    required String transactionDesc,
  }) async {
    try {
      final response = await _api.post(
        '/api/v1/payments/mpesa/stk-push',
        {
          'phone_number': _formatPhoneNumber(phoneNumber),
          'amount': amount,
          'account_reference': accountReference,
          'transaction_desc': transactionDesc,
        },
      );

      return MpesaStkPushResponse.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to initiate M-Pesa payment: $e');
    }
  }

  /// Query the status of an STK Push transaction
  Future<MpesaTransactionStatus> queryStkPushStatus({
    required String checkoutRequestId,
  }) async {
    try {
      final response = await _api.post(
        '/api/v1/payments/mpesa/check-payment-status',
        {
          'checkout_request_id': checkoutRequestId,
        },
      );

      return MpesaTransactionStatus.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to query M-Pesa status: $e');
    }
  }

  /// Register C2B URLs for M-Pesa callbacks
  Future<bool> registerC2BUrls() async {
    try {
      final response = await _api.post(
        '/api/v1/payments/mpesa/register-urls',
        {},
      );

      return response.statusCode == 200;
    } catch (e) {
      throw Exception('Failed to register C2B URLs: $e');
    }
  }

  /// Check account balance (Business account)
  Future<MpesaAccountBalance> checkAccountBalance() async {
    try {
      final response = await _api.get(
        '/api/v1/payments/mpesa/balance',
      );

      return MpesaAccountBalance.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to check M-Pesa balance: $e');
    }
  }

  /// Get transaction history
  Future<List<MpesaTransaction>> getTransactionHistory({
    int? limit,
    int? offset,
  }) async {
    try {
      final response = await _api.get(
        '/api/v1/payments/mpesa/transactions',
        params: {
          if (limit != null) 'limit': limit,
          if (offset != null) 'offset': offset,
        },
      );

      final transactions = (response.data['transactions'] as List)
          .map((json) => MpesaTransaction.fromJson(json))
          .toList();

      return transactions;
    } catch (e) {
      throw Exception('Failed to get transaction history: $e');
    }
  }

  /// Reverse a transaction (refund)
  Future<MpesaReversalResponse> reverseTransaction({
    required String transactionId,
    required double amount,
    required String remarks,
  }) async {
    try {
      final response = await _api.post(
        '/api/v1/payments/mpesa/reverse',
        {
          'transaction_id': transactionId,
          'amount': amount,
          'remarks': remarks,
        },
      );

      return MpesaReversalResponse.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to reverse transaction: $e');
    }
  }

  /// B2C - Send money to customer (withdrawals/payouts)
  Future<MpesaB2CResponse> sendMoneyToCustomer({
    required String phoneNumber,
    required double amount,
    required String remarks,
    String occasion = '',
  }) async {
    try {
      final response = await _api.post(
        '/api/v1/payments/mpesa/b2c',
        {
          'phone_number': _formatPhoneNumber(phoneNumber),
          'amount': amount,
          'remarks': remarks,
          'occasion': occasion,
        },
      );

      return MpesaB2CResponse.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to send money: $e');
    }
  }

  /// Format phone number to M-Pesa format (254XXXXXXXXX)
  String _formatPhoneNumber(String phone) {
    // Remove any spaces, dashes, or plus signs
    phone = phone.replaceAll(RegExp(r'[\s\-\+]'), '');

    // If starts with 0, replace with 254
    if (phone.startsWith('0')) {
      phone = '254${phone.substring(1)}';
    }

    // If starts with 7 or 1 (Kenyan format), add 254
    if (phone.startsWith('7') || phone.startsWith('1')) {
      phone = '254$phone';
    }

    return phone;
  }

  /// Validate phone number is in correct M-Pesa format
  bool isValidMpesaPhone(String phone) {
    final formatted = _formatPhoneNumber(phone);
    // Kenyan M-Pesa numbers: 2547XXXXXXXX or 2541XXXXXXXX
    return RegExp(r'^254[71]\d{8}$').hasMatch(formatted);
  }
}

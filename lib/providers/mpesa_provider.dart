import 'package:flutter/material.dart';
import '../services/mpesa_service.dart';
import '../services/api_service.dart';
import '../models/mpesa_models.dart';

class MpesaProvider extends ChangeNotifier {
  final MpesaService _mpesaService;
  
  bool _loading = false;
  String? _error;
  MpesaStkPushResponse? _lastPushResponse;
  MpesaTransactionStatus? _transactionStatus;
  List<MpesaTransaction> _transactions = [];

  MpesaProvider({MpesaService? mpesaService})
      : _mpesaService = mpesaService ?? MpesaService(apiService: ApiService());

  bool get loading => _loading;
  String? get error => _error;
  MpesaStkPushResponse? get lastPushResponse => _lastPushResponse;
  MpesaTransactionStatus? get transactionStatus => _transactionStatus;
  List<MpesaTransaction> get transactions => _transactions;

  /// Initiate M-Pesa payment
  Future<bool> initiatePayment({
    required String phoneNumber,
    required double amount,
    required String accountReference,
    required String description,
  }) async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      // Validate phone number
      if (!_mpesaService.isValidMpesaPhone(phoneNumber)) {
        throw Exception('Invalid phone number. Use format: 0712345678 or 254712345678');
      }

      // Initiate STK Push
      _lastPushResponse = await _mpesaService.initiateStkPush(
        phoneNumber: phoneNumber,
        amount: amount,
        accountReference: accountReference,
        transactionDesc: description,
      );

      _loading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      _loading = false;
      notifyListeners();
      return false;
    }
  }

  /// Check payment status
  Future<bool> checkPaymentStatus(String checkoutRequestId) async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      _transactionStatus = await _mpesaService.queryStkPushStatus(
        checkoutRequestId: checkoutRequestId,
      );

      _loading = false;
      notifyListeners();

      // Return true if payment was successful
      return _transactionStatus?.responseCode == '0';
    } catch (e) {
      _error = e.toString();
      _loading = false;
      notifyListeners();
      return false;
    }
  }

  /// Poll payment status (check every few seconds)
  Future<bool> pollPaymentStatus({
    required String checkoutRequestId,
    int maxAttempts = 30,
    Duration interval = const Duration(seconds: 2),
  }) async {
    for (int i = 0; i < maxAttempts; i++) {
      await Future.delayed(interval);

      await checkPaymentStatus(checkoutRequestId);
      
      if (_transactionStatus != null) {
        final resultCode = _transactionStatus!.resultCode;
        
        if (resultCode == '0') {
          // Payment successful
          return true;
        } else if (resultCode != '0' && resultCode.isNotEmpty) {
          // Payment failed or cancelled
          return false;
        }
      }
      
      // Continue polling if still pending
    }

    // Timeout
    _error = 'Payment verification timeout';
    notifyListeners();
    return false;
  }

  /// Load transaction history
  Future<void> loadTransactions({int limit = 50, int offset = 0}) async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      _transactions = await _mpesaService.getTransactionHistory(
        limit: limit,
        offset: offset,
      );

      _loading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _loading = false;
      notifyListeners();
    }
  }

  /// Clear error
  void clearError() {
    _error = null;
    notifyListeners();
  }

  /// Reset state
  void reset() {
    _loading = false;
    _error = null;
    _lastPushResponse = null;
    _transactionStatus = null;
    notifyListeners();
  }
}

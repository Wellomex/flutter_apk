import 'package:flutter/foundation.dart';
import '../models/common/api_error_simple.dart';
import '../services/payment/payment_service.dart';

enum PaymentMethod { mpesa, stripe, googlePay, applePay, card }

enum PaymentStatus { pending, processing, completed, failed, cancelled }

class PaymentState {
  final bool isLoading;
  final String? error;
  final List<Map<String, dynamic>> payments;
  final Map<String, dynamic>? currentPayment;
  final String? checkoutRequestId;

  PaymentState({
    this.isLoading = false,
    this.error,
    this.payments = const [],
    this.currentPayment,
    this.checkoutRequestId,
  });

  PaymentState copyWith({
    bool? isLoading,
    String? error,
    List<Map<String, dynamic>>? payments,
    Map<String, dynamic>? currentPayment,
    String? checkoutRequestId,
  }) {
    return PaymentState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      payments: payments ?? this.payments,
      currentPayment: currentPayment ?? this.currentPayment,
      checkoutRequestId: checkoutRequestId ?? this.checkoutRequestId,
    );
  }
}

class PaymentProvider with ChangeNotifier {
  final PaymentService _paymentService;
  
  PaymentState _state = PaymentState();
  PaymentState get state => _state;

  bool get isLoading => _state.isLoading;
  String? get error => _state.error;
  List<Map<String, dynamic>> get payments => _state.payments;
  Map<String, dynamic>? get currentPayment => _state.currentPayment;
  String? get checkoutRequestId => _state.checkoutRequestId;

  PaymentProvider(this._paymentService);

  void _setState(PaymentState newState) {
    _state = newState;
    notifyListeners();
  }

  void clearError() {
    _setState(_state.copyWith(error: null));
  }

  /// Initiate M-Pesa STK Push payment
  Future<bool> initiateMpesaPayment({
    required String phoneNumber,
    required double amount,
    String? accountReference,
    String? transactionDesc,
  }) async {
    try {
      _setState(_state.copyWith(isLoading: true, error: null));

      final result = await _paymentService.initiateMpesaStkPush(
        phoneNumber: phoneNumber,
        amount: amount,
        accountReference: accountReference,
        transactionDesc: transactionDesc,
      );

      final checkoutRequestId = result['CheckoutRequestID'] ?? result['checkout_request_id'];
      
      _setState(_state.copyWith(
        isLoading: false,
        currentPayment: result,
        checkoutRequestId: checkoutRequestId,
      ));

      return true;
    } on ApiException catch (e) {
      _setState(_state.copyWith(
        isLoading: false,
        error: e.error.message,
      ));
      return false;
    } catch (e) {
      _setState(_state.copyWith(
        isLoading: false,
        error: e.toString(),
      ));
      return false;
    }
  }

  /// Check M-Pesa payment status
  Future<Map<String, dynamic>?> checkMpesaPaymentStatus({
    String? checkoutRequestId,
  }) async {
    try {
      _setState(_state.copyWith(isLoading: true, error: null));

      final requestId = checkoutRequestId ?? _state.checkoutRequestId;
      if (requestId == null) {
        throw Exception('No checkout request ID available');
      }

      final result = await _paymentService.checkMpesaPaymentStatus(
        checkoutRequestId: requestId,
      );

      _setState(_state.copyWith(
        isLoading: false,
        currentPayment: result,
      ));

      return result;
    } on ApiException catch (e) {
      _setState(_state.copyWith(
        isLoading: false,
        error: e.error.message,
      ));
      return null;
    } catch (e) {
      _setState(_state.copyWith(
        isLoading: false,
        error: e.toString(),
      ));
      return null;
    }
  }

  /// Process Stripe payment
  Future<bool> processStripePayment({
    required String paymentMethodId,
    required double amount,
    String? currency,
  }) async {
    try {
      _setState(_state.copyWith(isLoading: true, error: null));

      final result = await _paymentService.processStripePayment(
        paymentMethodId: paymentMethodId,
        amount: amount,
        currency: currency,
      );

      _setState(_state.copyWith(
        isLoading: false,
        currentPayment: result,
      ));

      return true;
    } on ApiException catch (e) {
      _setState(_state.copyWith(
        isLoading: false,
        error: e.error.message,
      ));
      return false;
    } catch (e) {
      _setState(_state.copyWith(
        isLoading: false,
        error: e.toString(),
      ));
      return false;
    }
  }

  /// Create Stripe payment intent
  Future<Map<String, dynamic>?> createPaymentIntent({
    required double amount,
    String? currency,
  }) async {
    try {
      _setState(_state.copyWith(isLoading: true, error: null));

      final result = await _paymentService.createPaymentIntent(
        amount: amount,
        currency: currency,
      );

      _setState(_state.copyWith(
        isLoading: false,
        currentPayment: result,
      ));

      return result;
    } on ApiException catch (e) {
      _setState(_state.copyWith(
        isLoading: false,
        error: e.error.message,
      ));
      return null;
    } catch (e) {
      _setState(_state.copyWith(
        isLoading: false,
        error: e.toString(),
      ));
      return null;
    }
  }

  /// Load payment history
  Future<void> loadPaymentHistory() async {
    try {
      _setState(_state.copyWith(isLoading: true, error: null));

      final payments = await _paymentService.getPaymentHistory();

      _setState(_state.copyWith(
        isLoading: false,
        payments: payments,
      ));
    } on ApiException catch (e) {
      _setState(_state.copyWith(
        isLoading: false,
        error: e.error.message,
      ));
    } catch (e) {
      _setState(_state.copyWith(
        isLoading: false,
        error: e.toString(),
      ));
    }
  }

  /// Get payment by ID
  Future<Map<String, dynamic>?> getPaymentById(String paymentId) async {
    try {
      _setState(_state.copyWith(isLoading: true, error: null));

      final payment = await _paymentService.getPaymentById(paymentId);

      _setState(_state.copyWith(
        isLoading: false,
        currentPayment: payment,
      ));

      return payment;
    } on ApiException catch (e) {
      _setState(_state.copyWith(
        isLoading: false,
        error: e.error.message,
      ));
      return null;
    } catch (e) {
      _setState(_state.copyWith(
        isLoading: false,
        error: e.toString(),
      ));
      return null;
    }
  }

  /// Verify payment
  Future<bool> verifyPayment(String paymentId) async {
    try {
      _setState(_state.copyWith(isLoading: true, error: null));

      final result = await _paymentService.verifyPayment(
        paymentId: paymentId,
      );

      _setState(_state.copyWith(
        isLoading: false,
        currentPayment: result,
      ));

      return result['verified'] == true || result['status'] == 'completed';
    } on ApiException catch (e) {
      _setState(_state.copyWith(
        isLoading: false,
        error: e.error.message,
      ));
      return false;
    } catch (e) {
      _setState(_state.copyWith(
        isLoading: false,
        error: e.toString(),
      ));
      return false;
    }
  }

  /// Cancel payment
  Future<bool> cancelPayment(String paymentId) async {
    try {
      _setState(_state.copyWith(isLoading: true, error: null));

      final result = await _paymentService.cancelPayment(
        paymentId: paymentId,
      );

      _setState(_state.copyWith(
        isLoading: false,
        currentPayment: result,
      ));

      // Refresh payment history
      await loadPaymentHistory();

      return true;
    } on ApiException catch (e) {
      _setState(_state.copyWith(
        isLoading: false,
        error: e.error.message,
      ));
      return false;
    } catch (e) {
      _setState(_state.copyWith(
        isLoading: false,
        error: e.toString(),
      ));
      return false;
    }
  }

  /// Reset payment state
  void resetPayment() {
    _setState(PaymentState());
  }
}

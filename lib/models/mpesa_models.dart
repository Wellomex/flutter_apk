import 'package:freezed_annotation/freezed_annotation.dart';

part 'mpesa_models.freezed.dart';
part 'mpesa_models.g.dart';

/// M-Pesa STK Push (Lipa Na M-Pesa Online) Response
@freezed
class MpesaStkPushResponse with _$MpesaStkPushResponse {
  const factory MpesaStkPushResponse({
    required String merchantRequestId,
    required String checkoutRequestId,
    required String responseCode,
    required String responseDescription,
    required String customerMessage,
  }) = _MpesaStkPushResponse;

  factory MpesaStkPushResponse.fromJson(Map<String, dynamic> json) =>
      _$MpesaStkPushResponseFromJson(json);
}

/// M-Pesa Transaction Status
@freezed
class MpesaTransactionStatus with _$MpesaTransactionStatus {
  const factory MpesaTransactionStatus({
    required String merchantRequestId,
    required String checkoutRequestId,
    required String responseCode,
    required String responseDescription,
    required String resultCode,
    required String resultDesc,
    String? mpesaReceiptNumber,
    double? amount,
    String? phoneNumber,
    String? transactionDate,
  }) = _MpesaTransactionStatus;

  factory MpesaTransactionStatus.fromJson(Map<String, dynamic> json) =>
      _$MpesaTransactionStatusFromJson(json);
}

/// M-Pesa Account Balance
@freezed
class MpesaAccountBalance with _$MpesaAccountBalance {
  const factory MpesaAccountBalance({
    required String accountBalance,
    required String resultCode,
    required String resultDesc,
    String? workingAccountBalance,
    String? utilityAccountBalance,
    String? chargesPaidAccountBalance,
  }) = _MpesaAccountBalance;

  factory MpesaAccountBalance.fromJson(Map<String, dynamic> json) =>
      _$MpesaAccountBalanceFromJson(json);
}

/// M-Pesa Transaction
@freezed
class MpesaTransaction with _$MpesaTransaction {
  const factory MpesaTransaction({
    required String id,
    required String transactionType,
    required String mpesaReceiptNumber,
    required String phoneNumber,
    required double amount,
    required String transactionDate,
    required String status,
    String? accountReference,
    String? transactionDesc,
    Map<String, dynamic>? metadata,
  }) = _MpesaTransaction;

  factory MpesaTransaction.fromJson(Map<String, dynamic> json) =>
      _$MpesaTransactionFromJson(json);
}

/// M-Pesa Reversal Response
@freezed
class MpesaReversalResponse with _$MpesaReversalResponse {
  const factory MpesaReversalResponse({
    required String originatorConversationId,
    required String conversationId,
    required String responseCode,
    required String responseDescription,
  }) = _MpesaReversalResponse;

  factory MpesaReversalResponse.fromJson(Map<String, dynamic> json) =>
      _$MpesaReversalResponseFromJson(json);
}

/// M-Pesa B2C (Business to Customer) Response
@freezed
class MpesaB2CResponse with _$MpesaB2CResponse {
  const factory MpesaB2CResponse({
    required String originatorConversationId,
    required String conversationId,
    required String responseCode,
    required String responseDescription,
  }) = _MpesaB2CResponse;

  factory MpesaB2CResponse.fromJson(Map<String, dynamic> json) =>
      _$MpesaB2CResponseFromJson(json);
}

/// M-Pesa Callback Metadata
@freezed
class MpesaCallbackMetadata with _$MpesaCallbackMetadata {
  const factory MpesaCallbackMetadata({
    required double amount,
    required String mpesaReceiptNumber,
    required String transactionDate,
    required String phoneNumber,
  }) = _MpesaCallbackMetadata;

  factory MpesaCallbackMetadata.fromJson(Map<String, dynamic> json) =>
      _$MpesaCallbackMetadataFromJson(json);
}

/// M-Pesa Payment Request (for internal use)
@freezed
class MpesaPaymentRequest with _$MpesaPaymentRequest {
  const factory MpesaPaymentRequest({
    required String phoneNumber,
    required double amount,
    required String accountReference,
    required String transactionDesc,
  }) = _MpesaPaymentRequest;

  factory MpesaPaymentRequest.fromJson(Map<String, dynamic> json) =>
      _$MpesaPaymentRequestFromJson(json);
}

/// M-Pesa Configuration
class MpesaConfig {
  final String consumerKey;
  final String consumerSecret;
  final String businessShortCode;
  final String passkey;
  final String environment; // 'sandbox' or 'production'
  final String callbackUrl;
  final String validationUrl;
  final String confirmationUrl;

  const MpesaConfig({
    required this.consumerKey,
    required this.consumerSecret,
    required this.businessShortCode,
    required this.passkey,
    required this.environment,
    required this.callbackUrl,
    required this.validationUrl,
    required this.confirmationUrl,
  });

  bool get isSandbox => environment == 'sandbox';
  bool get isProduction => environment == 'production';

  String get baseUrl => isSandbox
      ? 'https://sandbox.safaricom.co.ke'
      : 'https://api.safaricom.co.ke';
}

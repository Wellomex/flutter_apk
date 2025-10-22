// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mpesa_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MpesaStkPushResponseImpl _$$MpesaStkPushResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$MpesaStkPushResponseImpl(
      merchantRequestId: json['merchantRequestId'] as String,
      checkoutRequestId: json['checkoutRequestId'] as String,
      responseCode: json['responseCode'] as String,
      responseDescription: json['responseDescription'] as String,
      customerMessage: json['customerMessage'] as String,
    );

Map<String, dynamic> _$$MpesaStkPushResponseImplToJson(
        _$MpesaStkPushResponseImpl instance) =>
    <String, dynamic>{
      'merchantRequestId': instance.merchantRequestId,
      'checkoutRequestId': instance.checkoutRequestId,
      'responseCode': instance.responseCode,
      'responseDescription': instance.responseDescription,
      'customerMessage': instance.customerMessage,
    };

_$MpesaTransactionStatusImpl _$$MpesaTransactionStatusImplFromJson(
        Map<String, dynamic> json) =>
    _$MpesaTransactionStatusImpl(
      merchantRequestId: json['merchantRequestId'] as String,
      checkoutRequestId: json['checkoutRequestId'] as String,
      responseCode: json['responseCode'] as String,
      responseDescription: json['responseDescription'] as String,
      resultCode: json['resultCode'] as String,
      resultDesc: json['resultDesc'] as String,
      mpesaReceiptNumber: json['mpesaReceiptNumber'] as String?,
      amount: (json['amount'] as num?)?.toDouble(),
      phoneNumber: json['phoneNumber'] as String?,
      transactionDate: json['transactionDate'] as String?,
    );

Map<String, dynamic> _$$MpesaTransactionStatusImplToJson(
        _$MpesaTransactionStatusImpl instance) =>
    <String, dynamic>{
      'merchantRequestId': instance.merchantRequestId,
      'checkoutRequestId': instance.checkoutRequestId,
      'responseCode': instance.responseCode,
      'responseDescription': instance.responseDescription,
      'resultCode': instance.resultCode,
      'resultDesc': instance.resultDesc,
      'mpesaReceiptNumber': instance.mpesaReceiptNumber,
      'amount': instance.amount,
      'phoneNumber': instance.phoneNumber,
      'transactionDate': instance.transactionDate,
    };

_$MpesaAccountBalanceImpl _$$MpesaAccountBalanceImplFromJson(
        Map<String, dynamic> json) =>
    _$MpesaAccountBalanceImpl(
      accountBalance: json['accountBalance'] as String,
      resultCode: json['resultCode'] as String,
      resultDesc: json['resultDesc'] as String,
      workingAccountBalance: json['workingAccountBalance'] as String?,
      utilityAccountBalance: json['utilityAccountBalance'] as String?,
      chargesPaidAccountBalance: json['chargesPaidAccountBalance'] as String?,
    );

Map<String, dynamic> _$$MpesaAccountBalanceImplToJson(
        _$MpesaAccountBalanceImpl instance) =>
    <String, dynamic>{
      'accountBalance': instance.accountBalance,
      'resultCode': instance.resultCode,
      'resultDesc': instance.resultDesc,
      'workingAccountBalance': instance.workingAccountBalance,
      'utilityAccountBalance': instance.utilityAccountBalance,
      'chargesPaidAccountBalance': instance.chargesPaidAccountBalance,
    };

_$MpesaTransactionImpl _$$MpesaTransactionImplFromJson(
        Map<String, dynamic> json) =>
    _$MpesaTransactionImpl(
      id: json['id'] as String,
      transactionType: json['transactionType'] as String,
      mpesaReceiptNumber: json['mpesaReceiptNumber'] as String,
      phoneNumber: json['phoneNumber'] as String,
      amount: (json['amount'] as num).toDouble(),
      transactionDate: json['transactionDate'] as String,
      status: json['status'] as String,
      accountReference: json['accountReference'] as String?,
      transactionDesc: json['transactionDesc'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$MpesaTransactionImplToJson(
        _$MpesaTransactionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'transactionType': instance.transactionType,
      'mpesaReceiptNumber': instance.mpesaReceiptNumber,
      'phoneNumber': instance.phoneNumber,
      'amount': instance.amount,
      'transactionDate': instance.transactionDate,
      'status': instance.status,
      'accountReference': instance.accountReference,
      'transactionDesc': instance.transactionDesc,
      'metadata': instance.metadata,
    };

_$MpesaReversalResponseImpl _$$MpesaReversalResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$MpesaReversalResponseImpl(
      originatorConversationId: json['originatorConversationId'] as String,
      conversationId: json['conversationId'] as String,
      responseCode: json['responseCode'] as String,
      responseDescription: json['responseDescription'] as String,
    );

Map<String, dynamic> _$$MpesaReversalResponseImplToJson(
        _$MpesaReversalResponseImpl instance) =>
    <String, dynamic>{
      'originatorConversationId': instance.originatorConversationId,
      'conversationId': instance.conversationId,
      'responseCode': instance.responseCode,
      'responseDescription': instance.responseDescription,
    };

_$MpesaB2CResponseImpl _$$MpesaB2CResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$MpesaB2CResponseImpl(
      originatorConversationId: json['originatorConversationId'] as String,
      conversationId: json['conversationId'] as String,
      responseCode: json['responseCode'] as String,
      responseDescription: json['responseDescription'] as String,
    );

Map<String, dynamic> _$$MpesaB2CResponseImplToJson(
        _$MpesaB2CResponseImpl instance) =>
    <String, dynamic>{
      'originatorConversationId': instance.originatorConversationId,
      'conversationId': instance.conversationId,
      'responseCode': instance.responseCode,
      'responseDescription': instance.responseDescription,
    };

_$MpesaCallbackMetadataImpl _$$MpesaCallbackMetadataImplFromJson(
        Map<String, dynamic> json) =>
    _$MpesaCallbackMetadataImpl(
      amount: (json['amount'] as num).toDouble(),
      mpesaReceiptNumber: json['mpesaReceiptNumber'] as String,
      transactionDate: json['transactionDate'] as String,
      phoneNumber: json['phoneNumber'] as String,
    );

Map<String, dynamic> _$$MpesaCallbackMetadataImplToJson(
        _$MpesaCallbackMetadataImpl instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'mpesaReceiptNumber': instance.mpesaReceiptNumber,
      'transactionDate': instance.transactionDate,
      'phoneNumber': instance.phoneNumber,
    };

_$MpesaPaymentRequestImpl _$$MpesaPaymentRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$MpesaPaymentRequestImpl(
      phoneNumber: json['phoneNumber'] as String,
      amount: (json['amount'] as num).toDouble(),
      accountReference: json['accountReference'] as String,
      transactionDesc: json['transactionDesc'] as String,
    );

Map<String, dynamic> _$$MpesaPaymentRequestImplToJson(
        _$MpesaPaymentRequestImpl instance) =>
    <String, dynamic>{
      'phoneNumber': instance.phoneNumber,
      'amount': instance.amount,
      'accountReference': instance.accountReference,
      'transactionDesc': instance.transactionDesc,
    };

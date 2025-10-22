// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mpesa_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MpesaStkPushResponse _$MpesaStkPushResponseFromJson(Map<String, dynamic> json) {
  return _MpesaStkPushResponse.fromJson(json);
}

/// @nodoc
mixin _$MpesaStkPushResponse {
  String get merchantRequestId => throw _privateConstructorUsedError;
  String get checkoutRequestId => throw _privateConstructorUsedError;
  String get responseCode => throw _privateConstructorUsedError;
  String get responseDescription => throw _privateConstructorUsedError;
  String get customerMessage => throw _privateConstructorUsedError;

  /// Serializes this MpesaStkPushResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MpesaStkPushResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MpesaStkPushResponseCopyWith<MpesaStkPushResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MpesaStkPushResponseCopyWith<$Res> {
  factory $MpesaStkPushResponseCopyWith(MpesaStkPushResponse value,
          $Res Function(MpesaStkPushResponse) then) =
      _$MpesaStkPushResponseCopyWithImpl<$Res, MpesaStkPushResponse>;
  @useResult
  $Res call(
      {String merchantRequestId,
      String checkoutRequestId,
      String responseCode,
      String responseDescription,
      String customerMessage});
}

/// @nodoc
class _$MpesaStkPushResponseCopyWithImpl<$Res,
        $Val extends MpesaStkPushResponse>
    implements $MpesaStkPushResponseCopyWith<$Res> {
  _$MpesaStkPushResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MpesaStkPushResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? merchantRequestId = null,
    Object? checkoutRequestId = null,
    Object? responseCode = null,
    Object? responseDescription = null,
    Object? customerMessage = null,
  }) {
    return _then(_value.copyWith(
      merchantRequestId: null == merchantRequestId
          ? _value.merchantRequestId
          : merchantRequestId // ignore: cast_nullable_to_non_nullable
              as String,
      checkoutRequestId: null == checkoutRequestId
          ? _value.checkoutRequestId
          : checkoutRequestId // ignore: cast_nullable_to_non_nullable
              as String,
      responseCode: null == responseCode
          ? _value.responseCode
          : responseCode // ignore: cast_nullable_to_non_nullable
              as String,
      responseDescription: null == responseDescription
          ? _value.responseDescription
          : responseDescription // ignore: cast_nullable_to_non_nullable
              as String,
      customerMessage: null == customerMessage
          ? _value.customerMessage
          : customerMessage // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MpesaStkPushResponseImplCopyWith<$Res>
    implements $MpesaStkPushResponseCopyWith<$Res> {
  factory _$$MpesaStkPushResponseImplCopyWith(_$MpesaStkPushResponseImpl value,
          $Res Function(_$MpesaStkPushResponseImpl) then) =
      __$$MpesaStkPushResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String merchantRequestId,
      String checkoutRequestId,
      String responseCode,
      String responseDescription,
      String customerMessage});
}

/// @nodoc
class __$$MpesaStkPushResponseImplCopyWithImpl<$Res>
    extends _$MpesaStkPushResponseCopyWithImpl<$Res, _$MpesaStkPushResponseImpl>
    implements _$$MpesaStkPushResponseImplCopyWith<$Res> {
  __$$MpesaStkPushResponseImplCopyWithImpl(_$MpesaStkPushResponseImpl _value,
      $Res Function(_$MpesaStkPushResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of MpesaStkPushResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? merchantRequestId = null,
    Object? checkoutRequestId = null,
    Object? responseCode = null,
    Object? responseDescription = null,
    Object? customerMessage = null,
  }) {
    return _then(_$MpesaStkPushResponseImpl(
      merchantRequestId: null == merchantRequestId
          ? _value.merchantRequestId
          : merchantRequestId // ignore: cast_nullable_to_non_nullable
              as String,
      checkoutRequestId: null == checkoutRequestId
          ? _value.checkoutRequestId
          : checkoutRequestId // ignore: cast_nullable_to_non_nullable
              as String,
      responseCode: null == responseCode
          ? _value.responseCode
          : responseCode // ignore: cast_nullable_to_non_nullable
              as String,
      responseDescription: null == responseDescription
          ? _value.responseDescription
          : responseDescription // ignore: cast_nullable_to_non_nullable
              as String,
      customerMessage: null == customerMessage
          ? _value.customerMessage
          : customerMessage // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MpesaStkPushResponseImpl implements _MpesaStkPushResponse {
  const _$MpesaStkPushResponseImpl(
      {required this.merchantRequestId,
      required this.checkoutRequestId,
      required this.responseCode,
      required this.responseDescription,
      required this.customerMessage});

  factory _$MpesaStkPushResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$MpesaStkPushResponseImplFromJson(json);

  @override
  final String merchantRequestId;
  @override
  final String checkoutRequestId;
  @override
  final String responseCode;
  @override
  final String responseDescription;
  @override
  final String customerMessage;

  @override
  String toString() {
    return 'MpesaStkPushResponse(merchantRequestId: $merchantRequestId, checkoutRequestId: $checkoutRequestId, responseCode: $responseCode, responseDescription: $responseDescription, customerMessage: $customerMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MpesaStkPushResponseImpl &&
            (identical(other.merchantRequestId, merchantRequestId) ||
                other.merchantRequestId == merchantRequestId) &&
            (identical(other.checkoutRequestId, checkoutRequestId) ||
                other.checkoutRequestId == checkoutRequestId) &&
            (identical(other.responseCode, responseCode) ||
                other.responseCode == responseCode) &&
            (identical(other.responseDescription, responseDescription) ||
                other.responseDescription == responseDescription) &&
            (identical(other.customerMessage, customerMessage) ||
                other.customerMessage == customerMessage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, merchantRequestId,
      checkoutRequestId, responseCode, responseDescription, customerMessage);

  /// Create a copy of MpesaStkPushResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MpesaStkPushResponseImplCopyWith<_$MpesaStkPushResponseImpl>
      get copyWith =>
          __$$MpesaStkPushResponseImplCopyWithImpl<_$MpesaStkPushResponseImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MpesaStkPushResponseImplToJson(
      this,
    );
  }
}

abstract class _MpesaStkPushResponse implements MpesaStkPushResponse {
  const factory _MpesaStkPushResponse(
      {required final String merchantRequestId,
      required final String checkoutRequestId,
      required final String responseCode,
      required final String responseDescription,
      required final String customerMessage}) = _$MpesaStkPushResponseImpl;

  factory _MpesaStkPushResponse.fromJson(Map<String, dynamic> json) =
      _$MpesaStkPushResponseImpl.fromJson;

  @override
  String get merchantRequestId;
  @override
  String get checkoutRequestId;
  @override
  String get responseCode;
  @override
  String get responseDescription;
  @override
  String get customerMessage;

  /// Create a copy of MpesaStkPushResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MpesaStkPushResponseImplCopyWith<_$MpesaStkPushResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

MpesaTransactionStatus _$MpesaTransactionStatusFromJson(
    Map<String, dynamic> json) {
  return _MpesaTransactionStatus.fromJson(json);
}

/// @nodoc
mixin _$MpesaTransactionStatus {
  String get merchantRequestId => throw _privateConstructorUsedError;
  String get checkoutRequestId => throw _privateConstructorUsedError;
  String get responseCode => throw _privateConstructorUsedError;
  String get responseDescription => throw _privateConstructorUsedError;
  String get resultCode => throw _privateConstructorUsedError;
  String get resultDesc => throw _privateConstructorUsedError;
  String? get mpesaReceiptNumber => throw _privateConstructorUsedError;
  double? get amount => throw _privateConstructorUsedError;
  String? get phoneNumber => throw _privateConstructorUsedError;
  String? get transactionDate => throw _privateConstructorUsedError;

  /// Serializes this MpesaTransactionStatus to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MpesaTransactionStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MpesaTransactionStatusCopyWith<MpesaTransactionStatus> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MpesaTransactionStatusCopyWith<$Res> {
  factory $MpesaTransactionStatusCopyWith(MpesaTransactionStatus value,
          $Res Function(MpesaTransactionStatus) then) =
      _$MpesaTransactionStatusCopyWithImpl<$Res, MpesaTransactionStatus>;
  @useResult
  $Res call(
      {String merchantRequestId,
      String checkoutRequestId,
      String responseCode,
      String responseDescription,
      String resultCode,
      String resultDesc,
      String? mpesaReceiptNumber,
      double? amount,
      String? phoneNumber,
      String? transactionDate});
}

/// @nodoc
class _$MpesaTransactionStatusCopyWithImpl<$Res,
        $Val extends MpesaTransactionStatus>
    implements $MpesaTransactionStatusCopyWith<$Res> {
  _$MpesaTransactionStatusCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MpesaTransactionStatus
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? merchantRequestId = null,
    Object? checkoutRequestId = null,
    Object? responseCode = null,
    Object? responseDescription = null,
    Object? resultCode = null,
    Object? resultDesc = null,
    Object? mpesaReceiptNumber = freezed,
    Object? amount = freezed,
    Object? phoneNumber = freezed,
    Object? transactionDate = freezed,
  }) {
    return _then(_value.copyWith(
      merchantRequestId: null == merchantRequestId
          ? _value.merchantRequestId
          : merchantRequestId // ignore: cast_nullable_to_non_nullable
              as String,
      checkoutRequestId: null == checkoutRequestId
          ? _value.checkoutRequestId
          : checkoutRequestId // ignore: cast_nullable_to_non_nullable
              as String,
      responseCode: null == responseCode
          ? _value.responseCode
          : responseCode // ignore: cast_nullable_to_non_nullable
              as String,
      responseDescription: null == responseDescription
          ? _value.responseDescription
          : responseDescription // ignore: cast_nullable_to_non_nullable
              as String,
      resultCode: null == resultCode
          ? _value.resultCode
          : resultCode // ignore: cast_nullable_to_non_nullable
              as String,
      resultDesc: null == resultDesc
          ? _value.resultDesc
          : resultDesc // ignore: cast_nullable_to_non_nullable
              as String,
      mpesaReceiptNumber: freezed == mpesaReceiptNumber
          ? _value.mpesaReceiptNumber
          : mpesaReceiptNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double?,
      phoneNumber: freezed == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      transactionDate: freezed == transactionDate
          ? _value.transactionDate
          : transactionDate // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MpesaTransactionStatusImplCopyWith<$Res>
    implements $MpesaTransactionStatusCopyWith<$Res> {
  factory _$$MpesaTransactionStatusImplCopyWith(
          _$MpesaTransactionStatusImpl value,
          $Res Function(_$MpesaTransactionStatusImpl) then) =
      __$$MpesaTransactionStatusImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String merchantRequestId,
      String checkoutRequestId,
      String responseCode,
      String responseDescription,
      String resultCode,
      String resultDesc,
      String? mpesaReceiptNumber,
      double? amount,
      String? phoneNumber,
      String? transactionDate});
}

/// @nodoc
class __$$MpesaTransactionStatusImplCopyWithImpl<$Res>
    extends _$MpesaTransactionStatusCopyWithImpl<$Res,
        _$MpesaTransactionStatusImpl>
    implements _$$MpesaTransactionStatusImplCopyWith<$Res> {
  __$$MpesaTransactionStatusImplCopyWithImpl(
      _$MpesaTransactionStatusImpl _value,
      $Res Function(_$MpesaTransactionStatusImpl) _then)
      : super(_value, _then);

  /// Create a copy of MpesaTransactionStatus
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? merchantRequestId = null,
    Object? checkoutRequestId = null,
    Object? responseCode = null,
    Object? responseDescription = null,
    Object? resultCode = null,
    Object? resultDesc = null,
    Object? mpesaReceiptNumber = freezed,
    Object? amount = freezed,
    Object? phoneNumber = freezed,
    Object? transactionDate = freezed,
  }) {
    return _then(_$MpesaTransactionStatusImpl(
      merchantRequestId: null == merchantRequestId
          ? _value.merchantRequestId
          : merchantRequestId // ignore: cast_nullable_to_non_nullable
              as String,
      checkoutRequestId: null == checkoutRequestId
          ? _value.checkoutRequestId
          : checkoutRequestId // ignore: cast_nullable_to_non_nullable
              as String,
      responseCode: null == responseCode
          ? _value.responseCode
          : responseCode // ignore: cast_nullable_to_non_nullable
              as String,
      responseDescription: null == responseDescription
          ? _value.responseDescription
          : responseDescription // ignore: cast_nullable_to_non_nullable
              as String,
      resultCode: null == resultCode
          ? _value.resultCode
          : resultCode // ignore: cast_nullable_to_non_nullable
              as String,
      resultDesc: null == resultDesc
          ? _value.resultDesc
          : resultDesc // ignore: cast_nullable_to_non_nullable
              as String,
      mpesaReceiptNumber: freezed == mpesaReceiptNumber
          ? _value.mpesaReceiptNumber
          : mpesaReceiptNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double?,
      phoneNumber: freezed == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      transactionDate: freezed == transactionDate
          ? _value.transactionDate
          : transactionDate // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MpesaTransactionStatusImpl implements _MpesaTransactionStatus {
  const _$MpesaTransactionStatusImpl(
      {required this.merchantRequestId,
      required this.checkoutRequestId,
      required this.responseCode,
      required this.responseDescription,
      required this.resultCode,
      required this.resultDesc,
      this.mpesaReceiptNumber,
      this.amount,
      this.phoneNumber,
      this.transactionDate});

  factory _$MpesaTransactionStatusImpl.fromJson(Map<String, dynamic> json) =>
      _$$MpesaTransactionStatusImplFromJson(json);

  @override
  final String merchantRequestId;
  @override
  final String checkoutRequestId;
  @override
  final String responseCode;
  @override
  final String responseDescription;
  @override
  final String resultCode;
  @override
  final String resultDesc;
  @override
  final String? mpesaReceiptNumber;
  @override
  final double? amount;
  @override
  final String? phoneNumber;
  @override
  final String? transactionDate;

  @override
  String toString() {
    return 'MpesaTransactionStatus(merchantRequestId: $merchantRequestId, checkoutRequestId: $checkoutRequestId, responseCode: $responseCode, responseDescription: $responseDescription, resultCode: $resultCode, resultDesc: $resultDesc, mpesaReceiptNumber: $mpesaReceiptNumber, amount: $amount, phoneNumber: $phoneNumber, transactionDate: $transactionDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MpesaTransactionStatusImpl &&
            (identical(other.merchantRequestId, merchantRequestId) ||
                other.merchantRequestId == merchantRequestId) &&
            (identical(other.checkoutRequestId, checkoutRequestId) ||
                other.checkoutRequestId == checkoutRequestId) &&
            (identical(other.responseCode, responseCode) ||
                other.responseCode == responseCode) &&
            (identical(other.responseDescription, responseDescription) ||
                other.responseDescription == responseDescription) &&
            (identical(other.resultCode, resultCode) ||
                other.resultCode == resultCode) &&
            (identical(other.resultDesc, resultDesc) ||
                other.resultDesc == resultDesc) &&
            (identical(other.mpesaReceiptNumber, mpesaReceiptNumber) ||
                other.mpesaReceiptNumber == mpesaReceiptNumber) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.transactionDate, transactionDate) ||
                other.transactionDate == transactionDate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      merchantRequestId,
      checkoutRequestId,
      responseCode,
      responseDescription,
      resultCode,
      resultDesc,
      mpesaReceiptNumber,
      amount,
      phoneNumber,
      transactionDate);

  /// Create a copy of MpesaTransactionStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MpesaTransactionStatusImplCopyWith<_$MpesaTransactionStatusImpl>
      get copyWith => __$$MpesaTransactionStatusImplCopyWithImpl<
          _$MpesaTransactionStatusImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MpesaTransactionStatusImplToJson(
      this,
    );
  }
}

abstract class _MpesaTransactionStatus implements MpesaTransactionStatus {
  const factory _MpesaTransactionStatus(
      {required final String merchantRequestId,
      required final String checkoutRequestId,
      required final String responseCode,
      required final String responseDescription,
      required final String resultCode,
      required final String resultDesc,
      final String? mpesaReceiptNumber,
      final double? amount,
      final String? phoneNumber,
      final String? transactionDate}) = _$MpesaTransactionStatusImpl;

  factory _MpesaTransactionStatus.fromJson(Map<String, dynamic> json) =
      _$MpesaTransactionStatusImpl.fromJson;

  @override
  String get merchantRequestId;
  @override
  String get checkoutRequestId;
  @override
  String get responseCode;
  @override
  String get responseDescription;
  @override
  String get resultCode;
  @override
  String get resultDesc;
  @override
  String? get mpesaReceiptNumber;
  @override
  double? get amount;
  @override
  String? get phoneNumber;
  @override
  String? get transactionDate;

  /// Create a copy of MpesaTransactionStatus
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MpesaTransactionStatusImplCopyWith<_$MpesaTransactionStatusImpl>
      get copyWith => throw _privateConstructorUsedError;
}

MpesaAccountBalance _$MpesaAccountBalanceFromJson(Map<String, dynamic> json) {
  return _MpesaAccountBalance.fromJson(json);
}

/// @nodoc
mixin _$MpesaAccountBalance {
  String get accountBalance => throw _privateConstructorUsedError;
  String get resultCode => throw _privateConstructorUsedError;
  String get resultDesc => throw _privateConstructorUsedError;
  String? get workingAccountBalance => throw _privateConstructorUsedError;
  String? get utilityAccountBalance => throw _privateConstructorUsedError;
  String? get chargesPaidAccountBalance => throw _privateConstructorUsedError;

  /// Serializes this MpesaAccountBalance to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MpesaAccountBalance
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MpesaAccountBalanceCopyWith<MpesaAccountBalance> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MpesaAccountBalanceCopyWith<$Res> {
  factory $MpesaAccountBalanceCopyWith(
          MpesaAccountBalance value, $Res Function(MpesaAccountBalance) then) =
      _$MpesaAccountBalanceCopyWithImpl<$Res, MpesaAccountBalance>;
  @useResult
  $Res call(
      {String accountBalance,
      String resultCode,
      String resultDesc,
      String? workingAccountBalance,
      String? utilityAccountBalance,
      String? chargesPaidAccountBalance});
}

/// @nodoc
class _$MpesaAccountBalanceCopyWithImpl<$Res, $Val extends MpesaAccountBalance>
    implements $MpesaAccountBalanceCopyWith<$Res> {
  _$MpesaAccountBalanceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MpesaAccountBalance
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accountBalance = null,
    Object? resultCode = null,
    Object? resultDesc = null,
    Object? workingAccountBalance = freezed,
    Object? utilityAccountBalance = freezed,
    Object? chargesPaidAccountBalance = freezed,
  }) {
    return _then(_value.copyWith(
      accountBalance: null == accountBalance
          ? _value.accountBalance
          : accountBalance // ignore: cast_nullable_to_non_nullable
              as String,
      resultCode: null == resultCode
          ? _value.resultCode
          : resultCode // ignore: cast_nullable_to_non_nullable
              as String,
      resultDesc: null == resultDesc
          ? _value.resultDesc
          : resultDesc // ignore: cast_nullable_to_non_nullable
              as String,
      workingAccountBalance: freezed == workingAccountBalance
          ? _value.workingAccountBalance
          : workingAccountBalance // ignore: cast_nullable_to_non_nullable
              as String?,
      utilityAccountBalance: freezed == utilityAccountBalance
          ? _value.utilityAccountBalance
          : utilityAccountBalance // ignore: cast_nullable_to_non_nullable
              as String?,
      chargesPaidAccountBalance: freezed == chargesPaidAccountBalance
          ? _value.chargesPaidAccountBalance
          : chargesPaidAccountBalance // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MpesaAccountBalanceImplCopyWith<$Res>
    implements $MpesaAccountBalanceCopyWith<$Res> {
  factory _$$MpesaAccountBalanceImplCopyWith(_$MpesaAccountBalanceImpl value,
          $Res Function(_$MpesaAccountBalanceImpl) then) =
      __$$MpesaAccountBalanceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String accountBalance,
      String resultCode,
      String resultDesc,
      String? workingAccountBalance,
      String? utilityAccountBalance,
      String? chargesPaidAccountBalance});
}

/// @nodoc
class __$$MpesaAccountBalanceImplCopyWithImpl<$Res>
    extends _$MpesaAccountBalanceCopyWithImpl<$Res, _$MpesaAccountBalanceImpl>
    implements _$$MpesaAccountBalanceImplCopyWith<$Res> {
  __$$MpesaAccountBalanceImplCopyWithImpl(_$MpesaAccountBalanceImpl _value,
      $Res Function(_$MpesaAccountBalanceImpl) _then)
      : super(_value, _then);

  /// Create a copy of MpesaAccountBalance
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accountBalance = null,
    Object? resultCode = null,
    Object? resultDesc = null,
    Object? workingAccountBalance = freezed,
    Object? utilityAccountBalance = freezed,
    Object? chargesPaidAccountBalance = freezed,
  }) {
    return _then(_$MpesaAccountBalanceImpl(
      accountBalance: null == accountBalance
          ? _value.accountBalance
          : accountBalance // ignore: cast_nullable_to_non_nullable
              as String,
      resultCode: null == resultCode
          ? _value.resultCode
          : resultCode // ignore: cast_nullable_to_non_nullable
              as String,
      resultDesc: null == resultDesc
          ? _value.resultDesc
          : resultDesc // ignore: cast_nullable_to_non_nullable
              as String,
      workingAccountBalance: freezed == workingAccountBalance
          ? _value.workingAccountBalance
          : workingAccountBalance // ignore: cast_nullable_to_non_nullable
              as String?,
      utilityAccountBalance: freezed == utilityAccountBalance
          ? _value.utilityAccountBalance
          : utilityAccountBalance // ignore: cast_nullable_to_non_nullable
              as String?,
      chargesPaidAccountBalance: freezed == chargesPaidAccountBalance
          ? _value.chargesPaidAccountBalance
          : chargesPaidAccountBalance // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MpesaAccountBalanceImpl implements _MpesaAccountBalance {
  const _$MpesaAccountBalanceImpl(
      {required this.accountBalance,
      required this.resultCode,
      required this.resultDesc,
      this.workingAccountBalance,
      this.utilityAccountBalance,
      this.chargesPaidAccountBalance});

  factory _$MpesaAccountBalanceImpl.fromJson(Map<String, dynamic> json) =>
      _$$MpesaAccountBalanceImplFromJson(json);

  @override
  final String accountBalance;
  @override
  final String resultCode;
  @override
  final String resultDesc;
  @override
  final String? workingAccountBalance;
  @override
  final String? utilityAccountBalance;
  @override
  final String? chargesPaidAccountBalance;

  @override
  String toString() {
    return 'MpesaAccountBalance(accountBalance: $accountBalance, resultCode: $resultCode, resultDesc: $resultDesc, workingAccountBalance: $workingAccountBalance, utilityAccountBalance: $utilityAccountBalance, chargesPaidAccountBalance: $chargesPaidAccountBalance)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MpesaAccountBalanceImpl &&
            (identical(other.accountBalance, accountBalance) ||
                other.accountBalance == accountBalance) &&
            (identical(other.resultCode, resultCode) ||
                other.resultCode == resultCode) &&
            (identical(other.resultDesc, resultDesc) ||
                other.resultDesc == resultDesc) &&
            (identical(other.workingAccountBalance, workingAccountBalance) ||
                other.workingAccountBalance == workingAccountBalance) &&
            (identical(other.utilityAccountBalance, utilityAccountBalance) ||
                other.utilityAccountBalance == utilityAccountBalance) &&
            (identical(other.chargesPaidAccountBalance,
                    chargesPaidAccountBalance) ||
                other.chargesPaidAccountBalance == chargesPaidAccountBalance));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      accountBalance,
      resultCode,
      resultDesc,
      workingAccountBalance,
      utilityAccountBalance,
      chargesPaidAccountBalance);

  /// Create a copy of MpesaAccountBalance
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MpesaAccountBalanceImplCopyWith<_$MpesaAccountBalanceImpl> get copyWith =>
      __$$MpesaAccountBalanceImplCopyWithImpl<_$MpesaAccountBalanceImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MpesaAccountBalanceImplToJson(
      this,
    );
  }
}

abstract class _MpesaAccountBalance implements MpesaAccountBalance {
  const factory _MpesaAccountBalance(
      {required final String accountBalance,
      required final String resultCode,
      required final String resultDesc,
      final String? workingAccountBalance,
      final String? utilityAccountBalance,
      final String? chargesPaidAccountBalance}) = _$MpesaAccountBalanceImpl;

  factory _MpesaAccountBalance.fromJson(Map<String, dynamic> json) =
      _$MpesaAccountBalanceImpl.fromJson;

  @override
  String get accountBalance;
  @override
  String get resultCode;
  @override
  String get resultDesc;
  @override
  String? get workingAccountBalance;
  @override
  String? get utilityAccountBalance;
  @override
  String? get chargesPaidAccountBalance;

  /// Create a copy of MpesaAccountBalance
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MpesaAccountBalanceImplCopyWith<_$MpesaAccountBalanceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MpesaTransaction _$MpesaTransactionFromJson(Map<String, dynamic> json) {
  return _MpesaTransaction.fromJson(json);
}

/// @nodoc
mixin _$MpesaTransaction {
  String get id => throw _privateConstructorUsedError;
  String get transactionType => throw _privateConstructorUsedError;
  String get mpesaReceiptNumber => throw _privateConstructorUsedError;
  String get phoneNumber => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  String get transactionDate => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String? get accountReference => throw _privateConstructorUsedError;
  String? get transactionDesc => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;

  /// Serializes this MpesaTransaction to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MpesaTransaction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MpesaTransactionCopyWith<MpesaTransaction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MpesaTransactionCopyWith<$Res> {
  factory $MpesaTransactionCopyWith(
          MpesaTransaction value, $Res Function(MpesaTransaction) then) =
      _$MpesaTransactionCopyWithImpl<$Res, MpesaTransaction>;
  @useResult
  $Res call(
      {String id,
      String transactionType,
      String mpesaReceiptNumber,
      String phoneNumber,
      double amount,
      String transactionDate,
      String status,
      String? accountReference,
      String? transactionDesc,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class _$MpesaTransactionCopyWithImpl<$Res, $Val extends MpesaTransaction>
    implements $MpesaTransactionCopyWith<$Res> {
  _$MpesaTransactionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MpesaTransaction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? transactionType = null,
    Object? mpesaReceiptNumber = null,
    Object? phoneNumber = null,
    Object? amount = null,
    Object? transactionDate = null,
    Object? status = null,
    Object? accountReference = freezed,
    Object? transactionDesc = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      transactionType: null == transactionType
          ? _value.transactionType
          : transactionType // ignore: cast_nullable_to_non_nullable
              as String,
      mpesaReceiptNumber: null == mpesaReceiptNumber
          ? _value.mpesaReceiptNumber
          : mpesaReceiptNumber // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      transactionDate: null == transactionDate
          ? _value.transactionDate
          : transactionDate // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      accountReference: freezed == accountReference
          ? _value.accountReference
          : accountReference // ignore: cast_nullable_to_non_nullable
              as String?,
      transactionDesc: freezed == transactionDesc
          ? _value.transactionDesc
          : transactionDesc // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MpesaTransactionImplCopyWith<$Res>
    implements $MpesaTransactionCopyWith<$Res> {
  factory _$$MpesaTransactionImplCopyWith(_$MpesaTransactionImpl value,
          $Res Function(_$MpesaTransactionImpl) then) =
      __$$MpesaTransactionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String transactionType,
      String mpesaReceiptNumber,
      String phoneNumber,
      double amount,
      String transactionDate,
      String status,
      String? accountReference,
      String? transactionDesc,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class __$$MpesaTransactionImplCopyWithImpl<$Res>
    extends _$MpesaTransactionCopyWithImpl<$Res, _$MpesaTransactionImpl>
    implements _$$MpesaTransactionImplCopyWith<$Res> {
  __$$MpesaTransactionImplCopyWithImpl(_$MpesaTransactionImpl _value,
      $Res Function(_$MpesaTransactionImpl) _then)
      : super(_value, _then);

  /// Create a copy of MpesaTransaction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? transactionType = null,
    Object? mpesaReceiptNumber = null,
    Object? phoneNumber = null,
    Object? amount = null,
    Object? transactionDate = null,
    Object? status = null,
    Object? accountReference = freezed,
    Object? transactionDesc = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_$MpesaTransactionImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      transactionType: null == transactionType
          ? _value.transactionType
          : transactionType // ignore: cast_nullable_to_non_nullable
              as String,
      mpesaReceiptNumber: null == mpesaReceiptNumber
          ? _value.mpesaReceiptNumber
          : mpesaReceiptNumber // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      transactionDate: null == transactionDate
          ? _value.transactionDate
          : transactionDate // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      accountReference: freezed == accountReference
          ? _value.accountReference
          : accountReference // ignore: cast_nullable_to_non_nullable
              as String?,
      transactionDesc: freezed == transactionDesc
          ? _value.transactionDesc
          : transactionDesc // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: freezed == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MpesaTransactionImpl implements _MpesaTransaction {
  const _$MpesaTransactionImpl(
      {required this.id,
      required this.transactionType,
      required this.mpesaReceiptNumber,
      required this.phoneNumber,
      required this.amount,
      required this.transactionDate,
      required this.status,
      this.accountReference,
      this.transactionDesc,
      final Map<String, dynamic>? metadata})
      : _metadata = metadata;

  factory _$MpesaTransactionImpl.fromJson(Map<String, dynamic> json) =>
      _$$MpesaTransactionImplFromJson(json);

  @override
  final String id;
  @override
  final String transactionType;
  @override
  final String mpesaReceiptNumber;
  @override
  final String phoneNumber;
  @override
  final double amount;
  @override
  final String transactionDate;
  @override
  final String status;
  @override
  final String? accountReference;
  @override
  final String? transactionDesc;
  final Map<String, dynamic>? _metadata;
  @override
  Map<String, dynamic>? get metadata {
    final value = _metadata;
    if (value == null) return null;
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'MpesaTransaction(id: $id, transactionType: $transactionType, mpesaReceiptNumber: $mpesaReceiptNumber, phoneNumber: $phoneNumber, amount: $amount, transactionDate: $transactionDate, status: $status, accountReference: $accountReference, transactionDesc: $transactionDesc, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MpesaTransactionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.transactionType, transactionType) ||
                other.transactionType == transactionType) &&
            (identical(other.mpesaReceiptNumber, mpesaReceiptNumber) ||
                other.mpesaReceiptNumber == mpesaReceiptNumber) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.transactionDate, transactionDate) ||
                other.transactionDate == transactionDate) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.accountReference, accountReference) ||
                other.accountReference == accountReference) &&
            (identical(other.transactionDesc, transactionDesc) ||
                other.transactionDesc == transactionDesc) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      transactionType,
      mpesaReceiptNumber,
      phoneNumber,
      amount,
      transactionDate,
      status,
      accountReference,
      transactionDesc,
      const DeepCollectionEquality().hash(_metadata));

  /// Create a copy of MpesaTransaction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MpesaTransactionImplCopyWith<_$MpesaTransactionImpl> get copyWith =>
      __$$MpesaTransactionImplCopyWithImpl<_$MpesaTransactionImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MpesaTransactionImplToJson(
      this,
    );
  }
}

abstract class _MpesaTransaction implements MpesaTransaction {
  const factory _MpesaTransaction(
      {required final String id,
      required final String transactionType,
      required final String mpesaReceiptNumber,
      required final String phoneNumber,
      required final double amount,
      required final String transactionDate,
      required final String status,
      final String? accountReference,
      final String? transactionDesc,
      final Map<String, dynamic>? metadata}) = _$MpesaTransactionImpl;

  factory _MpesaTransaction.fromJson(Map<String, dynamic> json) =
      _$MpesaTransactionImpl.fromJson;

  @override
  String get id;
  @override
  String get transactionType;
  @override
  String get mpesaReceiptNumber;
  @override
  String get phoneNumber;
  @override
  double get amount;
  @override
  String get transactionDate;
  @override
  String get status;
  @override
  String? get accountReference;
  @override
  String? get transactionDesc;
  @override
  Map<String, dynamic>? get metadata;

  /// Create a copy of MpesaTransaction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MpesaTransactionImplCopyWith<_$MpesaTransactionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MpesaReversalResponse _$MpesaReversalResponseFromJson(
    Map<String, dynamic> json) {
  return _MpesaReversalResponse.fromJson(json);
}

/// @nodoc
mixin _$MpesaReversalResponse {
  String get originatorConversationId => throw _privateConstructorUsedError;
  String get conversationId => throw _privateConstructorUsedError;
  String get responseCode => throw _privateConstructorUsedError;
  String get responseDescription => throw _privateConstructorUsedError;

  /// Serializes this MpesaReversalResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MpesaReversalResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MpesaReversalResponseCopyWith<MpesaReversalResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MpesaReversalResponseCopyWith<$Res> {
  factory $MpesaReversalResponseCopyWith(MpesaReversalResponse value,
          $Res Function(MpesaReversalResponse) then) =
      _$MpesaReversalResponseCopyWithImpl<$Res, MpesaReversalResponse>;
  @useResult
  $Res call(
      {String originatorConversationId,
      String conversationId,
      String responseCode,
      String responseDescription});
}

/// @nodoc
class _$MpesaReversalResponseCopyWithImpl<$Res,
        $Val extends MpesaReversalResponse>
    implements $MpesaReversalResponseCopyWith<$Res> {
  _$MpesaReversalResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MpesaReversalResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? originatorConversationId = null,
    Object? conversationId = null,
    Object? responseCode = null,
    Object? responseDescription = null,
  }) {
    return _then(_value.copyWith(
      originatorConversationId: null == originatorConversationId
          ? _value.originatorConversationId
          : originatorConversationId // ignore: cast_nullable_to_non_nullable
              as String,
      conversationId: null == conversationId
          ? _value.conversationId
          : conversationId // ignore: cast_nullable_to_non_nullable
              as String,
      responseCode: null == responseCode
          ? _value.responseCode
          : responseCode // ignore: cast_nullable_to_non_nullable
              as String,
      responseDescription: null == responseDescription
          ? _value.responseDescription
          : responseDescription // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MpesaReversalResponseImplCopyWith<$Res>
    implements $MpesaReversalResponseCopyWith<$Res> {
  factory _$$MpesaReversalResponseImplCopyWith(
          _$MpesaReversalResponseImpl value,
          $Res Function(_$MpesaReversalResponseImpl) then) =
      __$$MpesaReversalResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String originatorConversationId,
      String conversationId,
      String responseCode,
      String responseDescription});
}

/// @nodoc
class __$$MpesaReversalResponseImplCopyWithImpl<$Res>
    extends _$MpesaReversalResponseCopyWithImpl<$Res,
        _$MpesaReversalResponseImpl>
    implements _$$MpesaReversalResponseImplCopyWith<$Res> {
  __$$MpesaReversalResponseImplCopyWithImpl(_$MpesaReversalResponseImpl _value,
      $Res Function(_$MpesaReversalResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of MpesaReversalResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? originatorConversationId = null,
    Object? conversationId = null,
    Object? responseCode = null,
    Object? responseDescription = null,
  }) {
    return _then(_$MpesaReversalResponseImpl(
      originatorConversationId: null == originatorConversationId
          ? _value.originatorConversationId
          : originatorConversationId // ignore: cast_nullable_to_non_nullable
              as String,
      conversationId: null == conversationId
          ? _value.conversationId
          : conversationId // ignore: cast_nullable_to_non_nullable
              as String,
      responseCode: null == responseCode
          ? _value.responseCode
          : responseCode // ignore: cast_nullable_to_non_nullable
              as String,
      responseDescription: null == responseDescription
          ? _value.responseDescription
          : responseDescription // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MpesaReversalResponseImpl implements _MpesaReversalResponse {
  const _$MpesaReversalResponseImpl(
      {required this.originatorConversationId,
      required this.conversationId,
      required this.responseCode,
      required this.responseDescription});

  factory _$MpesaReversalResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$MpesaReversalResponseImplFromJson(json);

  @override
  final String originatorConversationId;
  @override
  final String conversationId;
  @override
  final String responseCode;
  @override
  final String responseDescription;

  @override
  String toString() {
    return 'MpesaReversalResponse(originatorConversationId: $originatorConversationId, conversationId: $conversationId, responseCode: $responseCode, responseDescription: $responseDescription)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MpesaReversalResponseImpl &&
            (identical(
                    other.originatorConversationId, originatorConversationId) ||
                other.originatorConversationId == originatorConversationId) &&
            (identical(other.conversationId, conversationId) ||
                other.conversationId == conversationId) &&
            (identical(other.responseCode, responseCode) ||
                other.responseCode == responseCode) &&
            (identical(other.responseDescription, responseDescription) ||
                other.responseDescription == responseDescription));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, originatorConversationId,
      conversationId, responseCode, responseDescription);

  /// Create a copy of MpesaReversalResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MpesaReversalResponseImplCopyWith<_$MpesaReversalResponseImpl>
      get copyWith => __$$MpesaReversalResponseImplCopyWithImpl<
          _$MpesaReversalResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MpesaReversalResponseImplToJson(
      this,
    );
  }
}

abstract class _MpesaReversalResponse implements MpesaReversalResponse {
  const factory _MpesaReversalResponse(
      {required final String originatorConversationId,
      required final String conversationId,
      required final String responseCode,
      required final String responseDescription}) = _$MpesaReversalResponseImpl;

  factory _MpesaReversalResponse.fromJson(Map<String, dynamic> json) =
      _$MpesaReversalResponseImpl.fromJson;

  @override
  String get originatorConversationId;
  @override
  String get conversationId;
  @override
  String get responseCode;
  @override
  String get responseDescription;

  /// Create a copy of MpesaReversalResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MpesaReversalResponseImplCopyWith<_$MpesaReversalResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

MpesaB2CResponse _$MpesaB2CResponseFromJson(Map<String, dynamic> json) {
  return _MpesaB2CResponse.fromJson(json);
}

/// @nodoc
mixin _$MpesaB2CResponse {
  String get originatorConversationId => throw _privateConstructorUsedError;
  String get conversationId => throw _privateConstructorUsedError;
  String get responseCode => throw _privateConstructorUsedError;
  String get responseDescription => throw _privateConstructorUsedError;

  /// Serializes this MpesaB2CResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MpesaB2CResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MpesaB2CResponseCopyWith<MpesaB2CResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MpesaB2CResponseCopyWith<$Res> {
  factory $MpesaB2CResponseCopyWith(
          MpesaB2CResponse value, $Res Function(MpesaB2CResponse) then) =
      _$MpesaB2CResponseCopyWithImpl<$Res, MpesaB2CResponse>;
  @useResult
  $Res call(
      {String originatorConversationId,
      String conversationId,
      String responseCode,
      String responseDescription});
}

/// @nodoc
class _$MpesaB2CResponseCopyWithImpl<$Res, $Val extends MpesaB2CResponse>
    implements $MpesaB2CResponseCopyWith<$Res> {
  _$MpesaB2CResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MpesaB2CResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? originatorConversationId = null,
    Object? conversationId = null,
    Object? responseCode = null,
    Object? responseDescription = null,
  }) {
    return _then(_value.copyWith(
      originatorConversationId: null == originatorConversationId
          ? _value.originatorConversationId
          : originatorConversationId // ignore: cast_nullable_to_non_nullable
              as String,
      conversationId: null == conversationId
          ? _value.conversationId
          : conversationId // ignore: cast_nullable_to_non_nullable
              as String,
      responseCode: null == responseCode
          ? _value.responseCode
          : responseCode // ignore: cast_nullable_to_non_nullable
              as String,
      responseDescription: null == responseDescription
          ? _value.responseDescription
          : responseDescription // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MpesaB2CResponseImplCopyWith<$Res>
    implements $MpesaB2CResponseCopyWith<$Res> {
  factory _$$MpesaB2CResponseImplCopyWith(_$MpesaB2CResponseImpl value,
          $Res Function(_$MpesaB2CResponseImpl) then) =
      __$$MpesaB2CResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String originatorConversationId,
      String conversationId,
      String responseCode,
      String responseDescription});
}

/// @nodoc
class __$$MpesaB2CResponseImplCopyWithImpl<$Res>
    extends _$MpesaB2CResponseCopyWithImpl<$Res, _$MpesaB2CResponseImpl>
    implements _$$MpesaB2CResponseImplCopyWith<$Res> {
  __$$MpesaB2CResponseImplCopyWithImpl(_$MpesaB2CResponseImpl _value,
      $Res Function(_$MpesaB2CResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of MpesaB2CResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? originatorConversationId = null,
    Object? conversationId = null,
    Object? responseCode = null,
    Object? responseDescription = null,
  }) {
    return _then(_$MpesaB2CResponseImpl(
      originatorConversationId: null == originatorConversationId
          ? _value.originatorConversationId
          : originatorConversationId // ignore: cast_nullable_to_non_nullable
              as String,
      conversationId: null == conversationId
          ? _value.conversationId
          : conversationId // ignore: cast_nullable_to_non_nullable
              as String,
      responseCode: null == responseCode
          ? _value.responseCode
          : responseCode // ignore: cast_nullable_to_non_nullable
              as String,
      responseDescription: null == responseDescription
          ? _value.responseDescription
          : responseDescription // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MpesaB2CResponseImpl implements _MpesaB2CResponse {
  const _$MpesaB2CResponseImpl(
      {required this.originatorConversationId,
      required this.conversationId,
      required this.responseCode,
      required this.responseDescription});

  factory _$MpesaB2CResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$MpesaB2CResponseImplFromJson(json);

  @override
  final String originatorConversationId;
  @override
  final String conversationId;
  @override
  final String responseCode;
  @override
  final String responseDescription;

  @override
  String toString() {
    return 'MpesaB2CResponse(originatorConversationId: $originatorConversationId, conversationId: $conversationId, responseCode: $responseCode, responseDescription: $responseDescription)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MpesaB2CResponseImpl &&
            (identical(
                    other.originatorConversationId, originatorConversationId) ||
                other.originatorConversationId == originatorConversationId) &&
            (identical(other.conversationId, conversationId) ||
                other.conversationId == conversationId) &&
            (identical(other.responseCode, responseCode) ||
                other.responseCode == responseCode) &&
            (identical(other.responseDescription, responseDescription) ||
                other.responseDescription == responseDescription));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, originatorConversationId,
      conversationId, responseCode, responseDescription);

  /// Create a copy of MpesaB2CResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MpesaB2CResponseImplCopyWith<_$MpesaB2CResponseImpl> get copyWith =>
      __$$MpesaB2CResponseImplCopyWithImpl<_$MpesaB2CResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MpesaB2CResponseImplToJson(
      this,
    );
  }
}

abstract class _MpesaB2CResponse implements MpesaB2CResponse {
  const factory _MpesaB2CResponse(
      {required final String originatorConversationId,
      required final String conversationId,
      required final String responseCode,
      required final String responseDescription}) = _$MpesaB2CResponseImpl;

  factory _MpesaB2CResponse.fromJson(Map<String, dynamic> json) =
      _$MpesaB2CResponseImpl.fromJson;

  @override
  String get originatorConversationId;
  @override
  String get conversationId;
  @override
  String get responseCode;
  @override
  String get responseDescription;

  /// Create a copy of MpesaB2CResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MpesaB2CResponseImplCopyWith<_$MpesaB2CResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MpesaCallbackMetadata _$MpesaCallbackMetadataFromJson(
    Map<String, dynamic> json) {
  return _MpesaCallbackMetadata.fromJson(json);
}

/// @nodoc
mixin _$MpesaCallbackMetadata {
  double get amount => throw _privateConstructorUsedError;
  String get mpesaReceiptNumber => throw _privateConstructorUsedError;
  String get transactionDate => throw _privateConstructorUsedError;
  String get phoneNumber => throw _privateConstructorUsedError;

  /// Serializes this MpesaCallbackMetadata to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MpesaCallbackMetadata
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MpesaCallbackMetadataCopyWith<MpesaCallbackMetadata> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MpesaCallbackMetadataCopyWith<$Res> {
  factory $MpesaCallbackMetadataCopyWith(MpesaCallbackMetadata value,
          $Res Function(MpesaCallbackMetadata) then) =
      _$MpesaCallbackMetadataCopyWithImpl<$Res, MpesaCallbackMetadata>;
  @useResult
  $Res call(
      {double amount,
      String mpesaReceiptNumber,
      String transactionDate,
      String phoneNumber});
}

/// @nodoc
class _$MpesaCallbackMetadataCopyWithImpl<$Res,
        $Val extends MpesaCallbackMetadata>
    implements $MpesaCallbackMetadataCopyWith<$Res> {
  _$MpesaCallbackMetadataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MpesaCallbackMetadata
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amount = null,
    Object? mpesaReceiptNumber = null,
    Object? transactionDate = null,
    Object? phoneNumber = null,
  }) {
    return _then(_value.copyWith(
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      mpesaReceiptNumber: null == mpesaReceiptNumber
          ? _value.mpesaReceiptNumber
          : mpesaReceiptNumber // ignore: cast_nullable_to_non_nullable
              as String,
      transactionDate: null == transactionDate
          ? _value.transactionDate
          : transactionDate // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MpesaCallbackMetadataImplCopyWith<$Res>
    implements $MpesaCallbackMetadataCopyWith<$Res> {
  factory _$$MpesaCallbackMetadataImplCopyWith(
          _$MpesaCallbackMetadataImpl value,
          $Res Function(_$MpesaCallbackMetadataImpl) then) =
      __$$MpesaCallbackMetadataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double amount,
      String mpesaReceiptNumber,
      String transactionDate,
      String phoneNumber});
}

/// @nodoc
class __$$MpesaCallbackMetadataImplCopyWithImpl<$Res>
    extends _$MpesaCallbackMetadataCopyWithImpl<$Res,
        _$MpesaCallbackMetadataImpl>
    implements _$$MpesaCallbackMetadataImplCopyWith<$Res> {
  __$$MpesaCallbackMetadataImplCopyWithImpl(_$MpesaCallbackMetadataImpl _value,
      $Res Function(_$MpesaCallbackMetadataImpl) _then)
      : super(_value, _then);

  /// Create a copy of MpesaCallbackMetadata
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amount = null,
    Object? mpesaReceiptNumber = null,
    Object? transactionDate = null,
    Object? phoneNumber = null,
  }) {
    return _then(_$MpesaCallbackMetadataImpl(
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      mpesaReceiptNumber: null == mpesaReceiptNumber
          ? _value.mpesaReceiptNumber
          : mpesaReceiptNumber // ignore: cast_nullable_to_non_nullable
              as String,
      transactionDate: null == transactionDate
          ? _value.transactionDate
          : transactionDate // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MpesaCallbackMetadataImpl implements _MpesaCallbackMetadata {
  const _$MpesaCallbackMetadataImpl(
      {required this.amount,
      required this.mpesaReceiptNumber,
      required this.transactionDate,
      required this.phoneNumber});

  factory _$MpesaCallbackMetadataImpl.fromJson(Map<String, dynamic> json) =>
      _$$MpesaCallbackMetadataImplFromJson(json);

  @override
  final double amount;
  @override
  final String mpesaReceiptNumber;
  @override
  final String transactionDate;
  @override
  final String phoneNumber;

  @override
  String toString() {
    return 'MpesaCallbackMetadata(amount: $amount, mpesaReceiptNumber: $mpesaReceiptNumber, transactionDate: $transactionDate, phoneNumber: $phoneNumber)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MpesaCallbackMetadataImpl &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.mpesaReceiptNumber, mpesaReceiptNumber) ||
                other.mpesaReceiptNumber == mpesaReceiptNumber) &&
            (identical(other.transactionDate, transactionDate) ||
                other.transactionDate == transactionDate) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, amount, mpesaReceiptNumber, transactionDate, phoneNumber);

  /// Create a copy of MpesaCallbackMetadata
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MpesaCallbackMetadataImplCopyWith<_$MpesaCallbackMetadataImpl>
      get copyWith => __$$MpesaCallbackMetadataImplCopyWithImpl<
          _$MpesaCallbackMetadataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MpesaCallbackMetadataImplToJson(
      this,
    );
  }
}

abstract class _MpesaCallbackMetadata implements MpesaCallbackMetadata {
  const factory _MpesaCallbackMetadata(
      {required final double amount,
      required final String mpesaReceiptNumber,
      required final String transactionDate,
      required final String phoneNumber}) = _$MpesaCallbackMetadataImpl;

  factory _MpesaCallbackMetadata.fromJson(Map<String, dynamic> json) =
      _$MpesaCallbackMetadataImpl.fromJson;

  @override
  double get amount;
  @override
  String get mpesaReceiptNumber;
  @override
  String get transactionDate;
  @override
  String get phoneNumber;

  /// Create a copy of MpesaCallbackMetadata
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MpesaCallbackMetadataImplCopyWith<_$MpesaCallbackMetadataImpl>
      get copyWith => throw _privateConstructorUsedError;
}

MpesaPaymentRequest _$MpesaPaymentRequestFromJson(Map<String, dynamic> json) {
  return _MpesaPaymentRequest.fromJson(json);
}

/// @nodoc
mixin _$MpesaPaymentRequest {
  String get phoneNumber => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  String get accountReference => throw _privateConstructorUsedError;
  String get transactionDesc => throw _privateConstructorUsedError;

  /// Serializes this MpesaPaymentRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MpesaPaymentRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MpesaPaymentRequestCopyWith<MpesaPaymentRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MpesaPaymentRequestCopyWith<$Res> {
  factory $MpesaPaymentRequestCopyWith(
          MpesaPaymentRequest value, $Res Function(MpesaPaymentRequest) then) =
      _$MpesaPaymentRequestCopyWithImpl<$Res, MpesaPaymentRequest>;
  @useResult
  $Res call(
      {String phoneNumber,
      double amount,
      String accountReference,
      String transactionDesc});
}

/// @nodoc
class _$MpesaPaymentRequestCopyWithImpl<$Res, $Val extends MpesaPaymentRequest>
    implements $MpesaPaymentRequestCopyWith<$Res> {
  _$MpesaPaymentRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MpesaPaymentRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phoneNumber = null,
    Object? amount = null,
    Object? accountReference = null,
    Object? transactionDesc = null,
  }) {
    return _then(_value.copyWith(
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      accountReference: null == accountReference
          ? _value.accountReference
          : accountReference // ignore: cast_nullable_to_non_nullable
              as String,
      transactionDesc: null == transactionDesc
          ? _value.transactionDesc
          : transactionDesc // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MpesaPaymentRequestImplCopyWith<$Res>
    implements $MpesaPaymentRequestCopyWith<$Res> {
  factory _$$MpesaPaymentRequestImplCopyWith(_$MpesaPaymentRequestImpl value,
          $Res Function(_$MpesaPaymentRequestImpl) then) =
      __$$MpesaPaymentRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String phoneNumber,
      double amount,
      String accountReference,
      String transactionDesc});
}

/// @nodoc
class __$$MpesaPaymentRequestImplCopyWithImpl<$Res>
    extends _$MpesaPaymentRequestCopyWithImpl<$Res, _$MpesaPaymentRequestImpl>
    implements _$$MpesaPaymentRequestImplCopyWith<$Res> {
  __$$MpesaPaymentRequestImplCopyWithImpl(_$MpesaPaymentRequestImpl _value,
      $Res Function(_$MpesaPaymentRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of MpesaPaymentRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phoneNumber = null,
    Object? amount = null,
    Object? accountReference = null,
    Object? transactionDesc = null,
  }) {
    return _then(_$MpesaPaymentRequestImpl(
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      accountReference: null == accountReference
          ? _value.accountReference
          : accountReference // ignore: cast_nullable_to_non_nullable
              as String,
      transactionDesc: null == transactionDesc
          ? _value.transactionDesc
          : transactionDesc // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MpesaPaymentRequestImpl implements _MpesaPaymentRequest {
  const _$MpesaPaymentRequestImpl(
      {required this.phoneNumber,
      required this.amount,
      required this.accountReference,
      required this.transactionDesc});

  factory _$MpesaPaymentRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$MpesaPaymentRequestImplFromJson(json);

  @override
  final String phoneNumber;
  @override
  final double amount;
  @override
  final String accountReference;
  @override
  final String transactionDesc;

  @override
  String toString() {
    return 'MpesaPaymentRequest(phoneNumber: $phoneNumber, amount: $amount, accountReference: $accountReference, transactionDesc: $transactionDesc)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MpesaPaymentRequestImpl &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.accountReference, accountReference) ||
                other.accountReference == accountReference) &&
            (identical(other.transactionDesc, transactionDesc) ||
                other.transactionDesc == transactionDesc));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, phoneNumber, amount, accountReference, transactionDesc);

  /// Create a copy of MpesaPaymentRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MpesaPaymentRequestImplCopyWith<_$MpesaPaymentRequestImpl> get copyWith =>
      __$$MpesaPaymentRequestImplCopyWithImpl<_$MpesaPaymentRequestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MpesaPaymentRequestImplToJson(
      this,
    );
  }
}

abstract class _MpesaPaymentRequest implements MpesaPaymentRequest {
  const factory _MpesaPaymentRequest(
      {required final String phoneNumber,
      required final double amount,
      required final String accountReference,
      required final String transactionDesc}) = _$MpesaPaymentRequestImpl;

  factory _MpesaPaymentRequest.fromJson(Map<String, dynamic> json) =
      _$MpesaPaymentRequestImpl.fromJson;

  @override
  String get phoneNumber;
  @override
  double get amount;
  @override
  String get accountReference;
  @override
  String get transactionDesc;

  /// Create a copy of MpesaPaymentRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MpesaPaymentRequestImplCopyWith<_$MpesaPaymentRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

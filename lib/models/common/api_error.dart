import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_error.freezed.dart';
part 'api_error.g.dart';

@freezed
class ApiError with _$ApiError {
  const factory ApiError({
    required String message,
    required int statusCode,
    String? code,
    Map<String, dynamic>? details,
    DateTime? timestamp,
  }) = _ApiError;

  factory ApiError.fromJson(Map<String, dynamic> json) =>
      _$ApiErrorFromJson(json);

  factory ApiError.fromException(dynamic exception, int statusCode) {
    return ApiError(
      message: exception.toString(),
      statusCode: statusCode,
      timestamp: DateTime.now(),
    );
  }
}

class ApiException implements Exception {
  final ApiError error;

  ApiException(this.error);

  @override
  String toString() => error.message;
}

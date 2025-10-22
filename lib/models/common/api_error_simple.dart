/// API Error model
class ApiError {
  final String message;
  final int statusCode;
  final String? code;
  final Map<String, dynamic>? details;
  final DateTime timestamp;

  ApiError({
    required this.message,
    required this.statusCode,
    this.code,
    this.details,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();

  factory ApiError.fromJson(Map<String, dynamic> json) {
    return ApiError(
      message: json['message'] ?? 'Unknown error',
      statusCode: json['status_code'] ?? json['statusCode'] ?? 500,
      code: json['code'],
      details: json['details'],
      timestamp: json['timestamp'] != null
          ? DateTime.parse(json['timestamp'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'status_code': statusCode,
      if (code != null) 'code': code,
      if (details != null) 'details': details,
      'timestamp': timestamp.toIso8601String(),
    };
  }
  
  factory ApiError.fromException(dynamic exception, [int statusCode = 500]) {
    return ApiError(
      message: exception.toString(),
      statusCode: statusCode,
      timestamp: DateTime.now(),
    );
  }
}

/// API Exception class
class ApiException implements Exception {
  final ApiError error;

  ApiException(this.error);

  @override
  String toString() => error.message;
}

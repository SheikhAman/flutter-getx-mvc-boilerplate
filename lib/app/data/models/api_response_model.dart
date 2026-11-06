class ApiResponse<T> {
  final bool success;
  final String? message;
  final T? data;
  final int? statusCode;
  final dynamic errors;

  const ApiResponse({
    required this.success,
    this.message,
    this.data,
    this.statusCode,
    this.errors,
  });

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic json)? fromJsonT,
  ) {
    return ApiResponse<T>(
      success: json['success'] as bool? ??
          (json['status'] == 'success' ||
              json['status'] == 200 ||
              json['error'] == null),
      message: json['message'] as String?,
      statusCode: json['statusCode'] as int? ?? json['status_code'] as int?,
      errors: json['errors'] ?? json['error'],
      data: json['data'] != null && fromJsonT != null
          ? fromJsonT(json['data'])
          : (json['data'] as T?),
    );
  }

  Map<String, dynamic> toJson([dynamic Function(T value)? toJsonT]) {
    return {
      'success': success,
      'message': message,
      'statusCode': statusCode,
      'errors': errors,
      'data': data != null && toJsonT != null ? toJsonT(data as T) : data,
    };
  }
}

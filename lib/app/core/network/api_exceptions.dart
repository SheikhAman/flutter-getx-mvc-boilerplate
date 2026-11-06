import 'package:dio/dio.dart';

class ApiException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic data;

  const ApiException({
    required this.message,
    this.statusCode,
    this.data,
  });

  factory ApiException.fromDioException(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return const ApiException(
          message:
              'Connection timed out. Please check your internet connection.',
          statusCode: 408,
        );
      case DioExceptionType.sendTimeout:
        return const ApiException(
          message: 'Send request timed out. Please try again.',
          statusCode: 408,
        );
      case DioExceptionType.receiveTimeout:
        return const ApiException(
          message: 'Server response timed out. Please try again later.',
          statusCode: 408,
        );
      case DioExceptionType.badCertificate:
        return const ApiException(
          message: 'Security certificate verification failed.',
          statusCode: 495,
        );
      case DioExceptionType.badResponse:
        return _handleBadResponse(dioException.response);
      case DioExceptionType.cancel:
        return const ApiException(
          message: 'Request was cancelled.',
          statusCode: 499,
        );
      case DioExceptionType.connectionError:
        return const ApiException(
          message:
              'No internet connection detected. Please verify your network.',
          statusCode: 503,
        );
      case DioExceptionType.unknown:
        return ApiException(
          message:
              dioException.message ?? 'An unexpected network error occurred.',
          statusCode: 500,
        );
    }
  }

  static ApiException _handleBadResponse(Response? response) {
    final statusCode = response?.statusCode;
    final data = response?.data;
    String message = 'Something went wrong. Please try again.';

    if (data is Map<String, dynamic>) {
      if (data['message'] != null) {
        message = data['message'].toString();
      } else if (data['error'] != null) {
        message = data['error'].toString();
      }
    } else if (data is String && data.isNotEmpty && data.length < 200) {
      message = data;
    }

    switch (statusCode) {
      case 400:
        return ApiException(
          message: message == 'Something went wrong. Please try again.'
              ? 'Bad request. Please verify your input.'
              : message,
          statusCode: 400,
          data: data,
        );
      case 401:
        return ApiException(
          message: 'Unauthorized. Please login again.',
          statusCode: 401,
          data: data,
        );
      case 403:
        return ApiException(
          message:
              'Access forbidden. You do not have permission for this resource.',
          statusCode: 403,
          data: data,
        );
      case 404:
        return ApiException(
          message: 'Resource not found.',
          statusCode: 404,
          data: data,
        );
      case 409:
        return ApiException(
          message: message,
          statusCode: 409,
          data: data,
        );
      case 422:
        return ApiException(
          message: message == 'Something went wrong. Please try again.'
              ? 'Validation error occurred.'
              : message,
          statusCode: 422,
          data: data,
        );
      case 500:
      case 502:
      case 503:
        return const ApiException(
          message: 'Server error. Our team has been notified.',
          statusCode: 500,
        );
      default:
        return ApiException(
          message: message,
          statusCode: statusCode,
          data: data,
        );
    }
  }

  @override
  String toString() => message;
}

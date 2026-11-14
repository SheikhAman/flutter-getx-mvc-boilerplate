import 'dart:developer' as developer;
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart' as getx;
import '../services/auth_service.dart';
import '../services/storage_service.dart';

class ApiInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Inject Authorization header if token exists
    if (getx.Get.isRegistered<StorageService>()) {
      final token = StorageService.to.token;
      if (token != null && token.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $token';
      }
    }

    options.headers['Accept'] = 'application/json';
    if (!options.headers.containsKey('Content-Type')) {
      options.headers['Content-Type'] = 'application/json';
    }

    if (kDebugMode) {
      developer.log(
        '--> ${options.method.toUpperCase()} ${options.baseUrl}${options.path}',
        name: 'DioClient',
      );
      if (options.queryParameters.isNotEmpty) {
        developer.log('Query: ${options.queryParameters}', name: 'DioClient');
      }
      if (options.data != null) {
        final sanitizedData = _sanitizePayload(options.data);
        developer.log('Data: $sanitizedData', name: 'DioClient');
      }
    }

    handler.next(options);
  }

  dynamic _sanitizePayload(dynamic data) {
    if (data is Map) {
      final sanitized = Map<dynamic, dynamic>.from(data);
      const sensitiveKeys = {
        'password',
        'token',
        'access_token',
        'refresh_token',
        'secret',
        'otp',
        'pin',
      };
      for (final key in sanitized.keys) {
        if (sensitiveKeys.contains(key.toString().toLowerCase())) {
          sanitized[key] = '***REDACTED***';
        } else if (sanitized[key] is Map) {
          sanitized[key] = _sanitizePayload(sanitized[key]);
        }
      }
      return sanitized;
    }
    return data;
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    developer.log(
      '<-- ${response.statusCode} ${response.requestOptions.method.toUpperCase()} ${response.requestOptions.path}',
      name: 'DioClient',
    );
    handler.next(response);
  }

  @override
  Future<void> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    developer.log(
      '<-- ERROR ${err.response?.statusCode} ${err.requestOptions.method.toUpperCase()} ${err.requestOptions.path}: ${err.message}',
      name: 'DioClient',
    );

    // If 401 Unauthorized, handle session expiration/logout
    if (err.response?.statusCode == 401) {
      if (getx.Get.isRegistered<AuthService>()) {
        final authService = AuthService.to;
        if (authService.isLoggedIn.value) {
          developer.log('401 detected: Logging user out', name: 'DioClient');
          await authService.logout();
        }
      }
    }

    handler.next(err);
  }
}

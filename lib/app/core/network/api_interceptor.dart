import 'dart:developer' as developer;
import 'package:dio/dio.dart';
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

    developer.log(
      '--> ${options.method.toUpperCase()} ${options.baseUrl}${options.path}',
      name: 'DioClient',
    );
    if (options.queryParameters.isNotEmpty) {
      developer.log('Query: ${options.queryParameters}', name: 'DioClient');
    }
    if (options.data != null) {
      developer.log('Data: ${options.data}', name: 'DioClient');
    }

    handler.next(options);
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

import 'package:dio/dio.dart';
import 'api_constants.dart';
import 'api_exceptions.dart';
import 'api_interceptor.dart';

class DioClient {
  static DioClient? _instance;
  late final Dio _dio;

  DioClient._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: ApiConstants.connectTimeout,
        receiveTimeout: ApiConstants.receiveTimeout,
        sendTimeout: ApiConstants.sendTimeout,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    _dio.interceptors.add(ApiInterceptor());
  }

  factory DioClient() {
    _instance ??= DioClient._internal();
    return _instance!;
  }

  Dio get rawDio => _dio;

  // Generic request runner with automatic error translation
  Future<T> _run<T>(Future<Response<T>> Function() request, {int maxRetries = 1}) async {
    int attempts = 0;
    while (true) {
      try {
        attempts++;
        final response = await request();
        return response.data as T;
      } on DioException catch (e) {
        if (attempts <= maxRetries && _shouldRetry(e)) {
          await Future.delayed(Duration(milliseconds: 500 * attempts));
          continue;
        }
        throw ApiException.fromDioException(e);
      } catch (e) {
        if (e is ApiException) rethrow;
        throw ApiException(message: e.toString());
      }
    }
  }

  bool _shouldRetry(DioException error) {
    return error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.receiveTimeout ||
        error.type == DioExceptionType.connectionError;
  }

  // GET
  Future<dynamic> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    return _run(() => _dio.get(
          path,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
        ));
  }

  // POST
  Future<dynamic> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    return _run(() => _dio.post(
          path,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
        ));
  }

  // PUT
  Future<dynamic> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    return _run(() => _dio.put(
          path,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
        ));
  }

  // PATCH
  Future<dynamic> patch(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    return _run(() => _dio.patch(
          path,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
        ));
  }

  // DELETE
  Future<dynamic> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    return _run(() => _dio.delete(
          path,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
        ));
  }

  // Multipart upload
  Future<dynamic> postMultipart(
    String path, {
    required Map<String, dynamic> fields,
    Map<String, String>? filePaths,
    ProgressCallback? onSendProgress,
    CancelToken? cancelToken,
  }) async {
    final Map<String, dynamic> formDataMap = {...fields};

    if (filePaths != null) {
      for (final entry in filePaths.entries) {
        formDataMap[entry.key] = await MultipartFile.fromFile(
          entry.value,
          filename: entry.value.split('/').last,
        );
      }
    }

    final formData = FormData.fromMap(formDataMap);

    return _run(() => _dio.post(
          path,
          data: formData,
          cancelToken: cancelToken,
          onSendProgress: onSendProgress,
        ));
  }
}


import 'package:dio/dio.dart';
import '../config/app_config.dart';
import 'network_info.dart';
import 'api_interceptors/logging_interceptor.dart';
import 'api_interceptors/error_interceptor.dart';

class ApiClient {
  final Dio dio;
  final AppConfig config;
  final NetworkInfo networkInfo;

  ApiClient({required this.config, required this.networkInfo, Dio? dioInstance})
      : dio = dioInstance ?? Dio() {
    dio.options = BaseOptions(
      baseUrl: '${config.baseUrl}/api/${config.apiVersion}',
      connectTimeout: Duration(milliseconds: config.connectTimeout),
      receiveTimeout: Duration(milliseconds: config.receiveTimeout),
      headers: {'Content-Type': 'application/json', 'Accept': 'application/json'},
    );
    dio.interceptors.addAll([
      if (config.enableLogging) AppLoggingInterceptor(),
      ErrorInterceptor(),
    ]);
  }

  Future<Response<T>> get<T>(String path, {Map<String, dynamic>? queryParams, Options? options, CancelToken? cancelToken}) =>
      dio.get<T>(path, queryParameters: queryParams, options: options, cancelToken: cancelToken);

  Future<Response<T>> post<T>(String path, {dynamic data, Map<String, dynamic>? queryParams, Options? options, CancelToken? cancelToken}) =>
      dio.post<T>(path, data: data, queryParameters: queryParams, options: options, cancelToken: cancelToken);

  Future<Response<T>> put<T>(String path, {dynamic data, Options? options, CancelToken? cancelToken}) =>
      dio.put<T>(path, data: data, options: options, cancelToken: cancelToken);

  Future<Response<T>> delete<T>(String path, {dynamic data, Options? options, CancelToken? cancelToken}) =>
      dio.delete<T>(path, data: data, options: options, cancelToken: cancelToken);
}

import 'package:dio/dio.dart';
import '../../errors/exceptions.dart';

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return handler.next(err);
      case DioExceptionType.connectionError:
        return handler.next(err);
      case DioExceptionType.badResponse:
        final status = err.response?.statusCode;
        if (status == 401) {
          handler.next(err.copyWith(error: const UnauthorizedException()));
          return;
        }
        final data = err.response?.data;
        final msg = data is Map ? (data['message'] ?? 'Server error') as String : 'Server error';
        handler.next(err.copyWith(error: ServerException(message: msg, statusCode: status)));
        return;
      default:
        handler.next(err);
    }
  }
}

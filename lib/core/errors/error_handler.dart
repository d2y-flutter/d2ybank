import 'package:dio/dio.dart';
import '../logging/app_logger.dart';
import 'exceptions.dart';
import 'failures.dart';

abstract final class ErrorHandler {
  static Failure handleException(dynamic exception) {
    AppLogger.error('ErrorHandler', error: exception);
    if (exception is ServerException) return ServerFailure(message: exception.message, statusCode: exception.statusCode);
    if (exception is NetworkException) return const NetworkFailure();
    if (exception is UnauthorizedException) return const UnauthorizedFailure();
    if (exception is CacheException) return const CacheFailure();
    if (exception is DioException) return _handleDio(exception);
    return UnknownFailure(message: exception.toString());
  }

  static Failure _handleDio(DioException e) {
    return switch (e.type) {
      DioExceptionType.connectionTimeout || DioExceptionType.sendTimeout || DioExceptionType.receiveTimeout => const TimeoutFailure(),
      DioExceptionType.connectionError => const NetworkFailure(),
      DioExceptionType.badResponse => _handleBadResponse(e),
      _ => const UnknownFailure(),
    };
  }

  static Failure _handleBadResponse(DioException e) {
    final status = e.response?.statusCode;
    final data = e.response?.data;
    final msg = data is Map ? (data['message'] ?? data['error'] ?? 'Error') as String : 'Error';
    return switch (status) {
      401 => const UnauthorizedFailure(),
      403 => const ForbiddenFailure(),
      422 => ValidationFailure(message: msg),
      _ => ServerFailure(message: msg, statusCode: status),
    };
  }
}

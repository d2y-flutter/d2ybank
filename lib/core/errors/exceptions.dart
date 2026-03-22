class AppException implements Exception {
  final String message;
  final String? code;
  final int? statusCode;
  const AppException({required this.message, this.code, this.statusCode});
  @override
  String toString() => 'AppException($code): $message';
}

class ServerException extends AppException {
  const ServerException({required super.message, super.code, super.statusCode});
}

class CacheException extends AppException {
  const CacheException({super.message = 'Cache operation failed', super.code = 'CACHE_ERROR'});
}

class NetworkException extends AppException {
  const NetworkException({super.message = 'No internet connection', super.code = 'NETWORK_ERROR'});
}

class UnauthorizedException extends AppException {
  const UnauthorizedException({super.message = 'Unauthorized', super.code = 'UNAUTHORIZED', super.statusCode = 401});
}

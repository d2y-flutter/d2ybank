import 'package:equatable/equatable.dart';

sealed class Failure extends Equatable {
  final String message;
  final String? code;
  const Failure({required this.message, this.code});
  @override
  List<Object?> get props => [message, code];
}

class ServerFailure extends Failure {
  final int? statusCode;
  const ServerFailure({required super.message, super.code, this.statusCode});
}

class NetworkFailure extends Failure {
  const NetworkFailure({super.message = 'No internet connection.', super.code = 'NETWORK_ERROR'});
}

class TimeoutFailure extends Failure {
  const TimeoutFailure({super.message = 'Request timed out.', super.code = 'TIMEOUT'});
}

class CacheFailure extends Failure {
  const CacheFailure({super.message = 'Cache error.', super.code = 'CACHE_ERROR'});
}

class ValidationFailure extends Failure {
  final Map<String, String>? fieldErrors;
  const ValidationFailure({required super.message, super.code = 'VALIDATION_ERROR', this.fieldErrors});
}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure({super.message = 'Session expired.', super.code = 'UNAUTHORIZED'});
}

class ForbiddenFailure extends Failure {
  const ForbiddenFailure({super.message = 'Access denied.', super.code = 'FORBIDDEN'});
}

class UnknownFailure extends Failure {
  const UnknownFailure({super.message = 'An unexpected error occurred.', super.code = 'UNKNOWN'});
}

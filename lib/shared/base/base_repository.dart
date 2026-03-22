import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../../core/errors/error_handler.dart';
import '../../core/network/network_info.dart';
import '../../core/logging/app_logger.dart';

abstract class BaseRepository {
  final NetworkInfo networkInfo;
  const BaseRepository({required this.networkInfo});

  Future<Either<Failure, T>> safeCall<T>(Future<T> Function() call) async {
    try { return Right(await call()); }
    catch (e) { return Left(ErrorHandler.handleException(e)); }
  }

  Future<Either<Failure, T>> networkAwareCall<T>({
    required Future<T> Function() remote,
    required Future<T> Function() cache,
  }) async {
    if (await networkInfo.isConnected) return safeCall(remote);
    try { return Right(await cache()); }
    catch (e) { AppLogger.warning('Cache miss, no network'); return const Left(NetworkFailure()); }
  }
}

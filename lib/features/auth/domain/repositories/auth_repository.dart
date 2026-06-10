import 'package:dartz/dartz.dart';
import 'package:d2ybank/core/errors/failures.dart';
import '../entities/user_entity.dart';

/// Contract: defined in domain, implemented in data.
/// Backend team builds the API matching these signatures.
abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> login({
    required String password,
  });
  Future<Either<Failure, void>> logout();
  Future<bool> isLoggedIn();
}
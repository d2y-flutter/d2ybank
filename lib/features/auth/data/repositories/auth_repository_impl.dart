import 'package:dartz/dartz.dart';
import 'package:d2ybank/core/errors/failures.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  bool _isLoggedIn = false;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, UserEntity>> login({required String password}) async {
    try {
      final user = await remoteDataSource.login(password: password);
      _isLoggedIn = true;
      return Right(user);
    } catch (e) {
      return const Left(ServerFailure(
        message: 'Invalid email or password.',
        code: 'INVALID_CREDENTIALS',
      ));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await remoteDataSource.logout();
      _isLoggedIn = false;
      return const Right(null);
    } catch (e) {
      _isLoggedIn = false;
      return const Right(null);
    }
  }

  @override
  Future<bool> isLoggedIn() async => _isLoggedIn;
}
import 'package:dartz/dartz.dart';
import 'package:d2ybank/core/errors/failures.dart';
import 'package:d2ybank/core/usecases/base_usecase.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class LoginUseCase extends UseCase<UserEntity, LoginParams> {
  final AuthRepository repository;
  LoginUseCase(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(LoginParams params) {
    return repository.login(password: params.password);
  }
}

class LoginParams {
  final String password;
  const LoginParams({required this.password});
}
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../entities/setup_password_entity.dart';
import '../repositories/setup_password_repository.dart';

class SetupPasswordUseCase {
  final SetupPasswordRepository repository;

  SetupPasswordUseCase(this.repository);

  Future<Either<String, SetupPasswordEntity>> call(
    SetupPasswordParams params,
  ) {
    return repository.setupPassword(password: params.password);
  }
}

class SetupPasswordParams extends Equatable {
  final String password;

  const SetupPasswordParams({
    required this.password,
  });

  @override
  List<Object?> get props => [password];
}
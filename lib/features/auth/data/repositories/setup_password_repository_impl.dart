import 'package:dartz/dartz.dart';

import '../../domain/entities/setup_password_entity.dart';
import '../../domain/repositories/setup_password_repository.dart';

class SetupPasswordRepositoryImpl implements SetupPasswordRepository {
  @override
  Future<Either<String, SetupPasswordEntity>> setupPassword({
    required String password,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 700));

    if (password.isEmpty) {
      return left('Password tidak boleh kosong.');
    }

    return right(SetupPasswordEntity(password: password));
  }
}
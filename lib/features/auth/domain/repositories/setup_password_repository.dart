import 'package:dartz/dartz.dart';

import '../entities/setup_password_entity.dart';

abstract class SetupPasswordRepository {
  Future<Either<String, SetupPasswordEntity>> setupPassword({
    required String password,
  });
}
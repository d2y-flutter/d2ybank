import 'package:dartz/dartz.dart';

import '../entities/setup_pin_entity.dart';

abstract class SetupPinRepository {
  Future<Either<String, SetupPinEntity>> setupPin({
    required String pin,
  });
}
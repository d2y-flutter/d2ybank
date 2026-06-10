import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../entities/setup_pin_entity.dart';
import '../repositories/setup_pin_repository.dart';

class SetupPinUseCase {
  final SetupPinRepository repository;

  SetupPinUseCase(this.repository);

  Future<Either<String, SetupPinEntity>> call(SetupPinParams params) {
    return repository.setupPin(pin: params.pin);
  }
}

class SetupPinParams extends Equatable {
  final String pin;

  const SetupPinParams({required this.pin});

  @override
  List<Object?> get props => [pin];
}
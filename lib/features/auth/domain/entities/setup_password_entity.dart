import 'package:equatable/equatable.dart';

class SetupPasswordEntity extends Equatable {
  final String password;

  const SetupPasswordEntity({
    required this.password,
  });

  @override
  List<Object?> get props => [password];
}
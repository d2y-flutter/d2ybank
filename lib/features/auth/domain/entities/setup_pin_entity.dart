import 'package:equatable/equatable.dart';

class SetupPinEntity extends Equatable {
  final bool isCreated;
  final DateTime createdAt;

  const SetupPinEntity({
    required this.isCreated,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [isCreated, createdAt];
}
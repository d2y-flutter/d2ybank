import 'package:equatable/equatable.dart';
import '../../../domain/entities/kyc_field.dart';

sealed class KycEvent extends Equatable {
  const KycEvent();

  @override
  List<Object?> get props => [];
}

class KycFieldChanged extends KycEvent {
  final KycField field;
  final String value;

  const KycFieldChanged({
    required this.field,
    required this.value,
  });

  @override
  List<Object?> get props => [field, value];
}

class KycStatementChanged extends KycEvent {
  final bool value;

  const KycStatementChanged(this.value);

  @override
  List<Object?> get props => [value];
}

class KycSubmitted extends KycEvent {
  const KycSubmitted();
}

class KycDateOfBirthChanged extends KycEvent {
  final DateTime? value;

  const KycDateOfBirthChanged(this.value);

  @override
  List<Object?> get props => [value];
}
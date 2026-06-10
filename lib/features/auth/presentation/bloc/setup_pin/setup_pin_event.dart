import 'package:equatable/equatable.dart';

sealed class SetupPinEvent extends Equatable {
  const SetupPinEvent();

  @override
  List<Object?> get props => [];
}

class SetupPinDigitPressed extends SetupPinEvent {
  final String digit;

  const SetupPinDigitPressed(this.digit);

  @override
  List<Object?> get props => [digit];
}

class SetupPinBackspacePressed extends SetupPinEvent {
  const SetupPinBackspacePressed();
}

class SetupPinResetRequested extends SetupPinEvent {
  const SetupPinResetRequested();
}
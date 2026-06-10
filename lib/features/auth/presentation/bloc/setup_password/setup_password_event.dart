import 'package:equatable/equatable.dart';

sealed class SetupPasswordEvent extends Equatable {
  const SetupPasswordEvent();

  @override
  List<Object?> get props => [];
}

class SetupPasswordChanged extends SetupPasswordEvent {
  final String password;

  const SetupPasswordChanged(this.password);

  @override
  List<Object?> get props => [password];
}

class SetupConfirmPasswordChanged extends SetupPasswordEvent {
  final String confirmPassword;

  const SetupConfirmPasswordChanged(this.confirmPassword);

  @override
  List<Object?> get props => [confirmPassword];
}

class SetupPasswordVisibilityToggled extends SetupPasswordEvent {
  const SetupPasswordVisibilityToggled();
}

class SetupConfirmPasswordVisibilityToggled extends SetupPasswordEvent {
  const SetupConfirmPasswordVisibilityToggled();
}

class SetupPasswordSubmitted extends SetupPasswordEvent {
  const SetupPasswordSubmitted();
}
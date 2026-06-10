import 'package:d2ybank/shared/base/base_event.dart';

sealed class AuthEvent extends BaseEvent {
  const AuthEvent();
}

class LoginRequested extends AuthEvent {
  final String password;
  const LoginRequested({required this.password});

  @override
  List<Object?> get props => [password];
}

class LogoutRequested extends AuthEvent {
  const LogoutRequested();
}
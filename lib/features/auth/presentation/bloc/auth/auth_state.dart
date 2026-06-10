import 'package:d2ybank/shared/base/base_state.dart';
import '../../../domain/entities/user_entity.dart';

class AuthState extends BaseState<UserEntity> {
  final bool isAuthenticated;

  const AuthState({
    super.status,
    super.data,
    super.failure,
    super.message,
    this.isAuthenticated = false,
  });

  AuthState copyWith({
    StateStatus? status,
    UserEntity? data,
    dynamic failure,
    String? message,
    bool? isAuthenticated,
  }) {
    return AuthState(
      status: status ?? this.status,
      data: data ?? this.data,
      failure: failure ?? this.failure,
      message: message ?? this.message,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
    );
  }

  @override
  List<Object?> get props => [...super.props, isAuthenticated];
}
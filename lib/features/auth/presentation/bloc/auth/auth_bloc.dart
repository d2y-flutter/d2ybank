import 'package:d2ybank/shared/base/base_bloc.dart';
import 'package:d2ybank/shared/base/base_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/login_usecase.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends BaseBloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;

  AuthBloc({required this.loginUseCase}) : super(const AuthState()) {
    on<LoginRequested>(_onLogin);
    on<LogoutRequested>(_onLogout);
  }

  Future<void> _onLogin(LoginRequested event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: StateStatus.loading));

    final result = await loginUseCase(LoginParams(password: event.password));

    result.fold(
      (failure) {
        handleFailure(failure);
        emit(state.copyWith(
          status: StateStatus.failure,
          failure: failure,
          isAuthenticated: false,
        ));
      },
      (user) => emit(state.copyWith(
        status: StateStatus.success,
        data: user,
        isAuthenticated: true,
      )),
    );
  }

  Future<void> _onLogout(LogoutRequested event, Emitter<AuthState> emit) async {
    emit(const AuthState(status: StateStatus.initial, isAuthenticated: false));
  }
}
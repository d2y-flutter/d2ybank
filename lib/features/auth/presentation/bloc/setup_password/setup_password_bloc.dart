import 'package:d2ybank/shared/base/base_bloc.dart';
import 'package:d2ybank/shared/base/base_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/password_requirement.dart';
import '../../../domain/usecases/setup_password_usecase.dart';
import 'setup_password_event.dart';
import 'setup_password_state.dart';

class SetupPasswordBloc extends BaseBloc<SetupPasswordEvent, SetupPasswordState> {
  final SetupPasswordUseCase setupPasswordUseCase;

  SetupPasswordBloc({
    required this.setupPasswordUseCase,
  }) : super(const SetupPasswordState()) {
    on<SetupPasswordChanged>(_onPasswordChanged);
    on<SetupConfirmPasswordChanged>(_onConfirmPasswordChanged);
    on<SetupPasswordVisibilityToggled>(_onPasswordVisibilityToggled);
    on<SetupConfirmPasswordVisibilityToggled>(
      _onConfirmPasswordVisibilityToggled,
    );
    on<SetupPasswordSubmitted>(_onSubmitted);
  }

  void _onPasswordChanged(
    SetupPasswordChanged event,
    Emitter<SetupPasswordState> emit,
  ) {
    final requirement = PasswordRequirement.from(
      password: event.password,
      confirmPassword: state.confirmPassword,
    );

    emit(
      state.copyWith(
        status: StateStatus.initial,
        password: event.password,
        requirement: requirement,
        clearPasswordError: true,
        clearConfirmPasswordError: true,
        clearGeneralError: true,
      ),
    );
  }

  void _onConfirmPasswordChanged(
    SetupConfirmPasswordChanged event,
    Emitter<SetupPasswordState> emit,
  ) {
    final requirement = PasswordRequirement.from(
      password: state.password,
      confirmPassword: event.confirmPassword,
    );

    emit(
      state.copyWith(
        status: StateStatus.initial,
        confirmPassword: event.confirmPassword,
        requirement: requirement,
        clearConfirmPasswordError: true,
        clearGeneralError: true,
      ),
    );
  }

  void _onPasswordVisibilityToggled(
    SetupPasswordVisibilityToggled event,
    Emitter<SetupPasswordState> emit,
  ) {
    emit(
      state.copyWith(
        obscurePassword: !state.obscurePassword,
      ),
    );
  }

  void _onConfirmPasswordVisibilityToggled(
    SetupConfirmPasswordVisibilityToggled event,
    Emitter<SetupPasswordState> emit,
  ) {
    emit(
      state.copyWith(
        obscureConfirmPassword: !state.obscureConfirmPassword,
      ),
    );
  }

  Future<void> _onSubmitted(
    SetupPasswordSubmitted event,
    Emitter<SetupPasswordState> emit,
  ) async {
    final requirement = PasswordRequirement.from(
      password: state.password,
      confirmPassword: state.confirmPassword,
    );

    String? passwordError;
    String? confirmPasswordError;

    if (!requirement.isStrongPassword) {
      passwordError = 'Password belum memenuhi semua syarat keamanan.';
    }

    if (state.confirmPassword.isEmpty) {
      confirmPasswordError = 'Konfirmasi password wajib diisi.';
    } else if (!requirement.isMatch) {
      confirmPasswordError = 'Password tidak cocok.';
    }

    if (passwordError != null || confirmPasswordError != null) {
      emit(
        state.copyWith(
          status: StateStatus.failure,
          requirement: requirement,
          passwordError: passwordError,
          confirmPasswordError: confirmPasswordError,
          generalError: 'Periksa kembali password Anda.',
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        status: StateStatus.loading,
        requirement: requirement,
        clearPasswordError: true,
        clearConfirmPasswordError: true,
        clearGeneralError: true,
      ),
    );

    final result = await setupPasswordUseCase(
      SetupPasswordParams(password: state.password),
    );

    result.fold(
      (message) {
        emit(
          state.copyWith(
            status: StateStatus.failure,
            generalError: message,
          ),
        );
      },
      (_) {
        emit(
          state.copyWith(
            status: StateStatus.success,
            clearGeneralError: true,
          ),
        );
      },
    );
  }
}
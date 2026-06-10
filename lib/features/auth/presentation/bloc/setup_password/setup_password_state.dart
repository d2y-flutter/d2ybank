import 'package:equatable/equatable.dart';
import 'package:d2ybank/shared/base/base_state.dart';

import '../../../domain/entities/password_requirement.dart';

class SetupPasswordState extends Equatable {
  final StateStatus status;
  final String password;
  final String confirmPassword;
  final bool obscurePassword;
  final bool obscureConfirmPassword;
  final PasswordRequirement requirement;
  final String? passwordError;
  final String? confirmPasswordError;
  final String? generalError;

  const SetupPasswordState({
    this.status = StateStatus.initial,
    this.password = '',
    this.confirmPassword = '',
    this.obscurePassword = true,
    this.obscureConfirmPassword = true,
    this.requirement = const PasswordRequirement(),
    this.passwordError,
    this.confirmPasswordError,
    this.generalError,
  });

  bool get isLoading => status == StateStatus.loading;
  bool get isSuccess => status == StateStatus.success;
  bool get canSubmit => requirement.isValid && !isLoading;

  SetupPasswordState copyWith({
    StateStatus? status,
    String? password,
    String? confirmPassword,
    bool? obscurePassword,
    bool? obscureConfirmPassword,
    PasswordRequirement? requirement,
    String? passwordError,
    String? confirmPasswordError,
    String? generalError,
    bool clearPasswordError = false,
    bool clearConfirmPasswordError = false,
    bool clearGeneralError = false,
  }) {
    return SetupPasswordState(
      status: status ?? this.status,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      obscurePassword: obscurePassword ?? this.obscurePassword,
      obscureConfirmPassword:
          obscureConfirmPassword ?? this.obscureConfirmPassword,
      requirement: requirement ?? this.requirement,
      passwordError:
          clearPasswordError ? null : passwordError ?? this.passwordError,
      confirmPasswordError: clearConfirmPasswordError
          ? null
          : confirmPasswordError ?? this.confirmPasswordError,
      generalError: clearGeneralError ? null : generalError ?? this.generalError,
    );
  }

  @override
  List<Object?> get props => [
        status,
        password,
        confirmPassword,
        obscurePassword,
        obscureConfirmPassword,
        requirement,
        passwordError,
        confirmPasswordError,
        generalError,
      ];
}
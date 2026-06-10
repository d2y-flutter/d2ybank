import 'package:equatable/equatable.dart';
import 'package:d2ybank/shared/base/base_state.dart';

class BiometricSetupState extends Equatable {
  final StateStatus status;
  final bool isAvailable;
  final bool isEnabled;
  final String biometricLabel;
  final String? errorMessage;

  const BiometricSetupState({
    this.status = StateStatus.initial,
    this.isAvailable = false,
    this.isEnabled = false,
    this.biometricLabel = 'Biometrik',
    this.errorMessage,
  });

  bool get isLoading => status == StateStatus.loading;
  bool get isSuccess => status == StateStatus.success;
  bool get isFailure => status == StateStatus.failure;

  BiometricSetupState copyWith({
    StateStatus? status,
    bool? isAvailable,
    bool? isEnabled,
    String? biometricLabel,
    String? errorMessage,
    bool clearError = false,
  }) {
    return BiometricSetupState(
      status: status ?? this.status,
      isAvailable: isAvailable ?? this.isAvailable,
      isEnabled: isEnabled ?? this.isEnabled,
      biometricLabel: biometricLabel ?? this.biometricLabel,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        isAvailable,
        isEnabled,
        biometricLabel,
        errorMessage,
      ];
}
import 'package:equatable/equatable.dart';
import 'package:d2ybank/shared/base/base_state.dart';

enum SetupPinStep {
  create,
  confirm,
}

class SetupPinState extends Equatable {
  final StateStatus status;
  final SetupPinStep step;
  final String pin;
  final String confirmPin;
  final String? firstPin;
  final String? errorMessage;

  const SetupPinState({
    this.status = StateStatus.initial,
    this.step = SetupPinStep.create,
    this.pin = '',
    this.confirmPin = '',
    this.firstPin,
    this.errorMessage,
  });

  int get currentLength {
    switch (step) {
      case SetupPinStep.create:
        return pin.length;
      case SetupPinStep.confirm:
        return confirmPin.length;
    }
  }

  String get title {
    switch (step) {
      case SetupPinStep.create:
        return 'Buat PIN Keamanan';
      case SetupPinStep.confirm:
        return 'Konfirmasi PIN';
    }
  }

  String get subtitle {
    switch (step) {
      case SetupPinStep.create:
        return 'Buat 6 digit PIN untuk mengamankan transaksi Anda.';
      case SetupPinStep.confirm:
        return 'Masukkan kembali PIN untuk memastikan tidak ada kesalahan.';
    }
  }

  bool get isLoading => status == StateStatus.loading;
  bool get isSuccess => status == StateStatus.success;

  SetupPinState copyWith({
    StateStatus? status,
    SetupPinStep? step,
    String? pin,
    String? confirmPin,
    String? firstPin,
    String? errorMessage,
    bool clearError = false,
  }) {
    return SetupPinState(
      status: status ?? this.status,
      step: step ?? this.step,
      pin: pin ?? this.pin,
      confirmPin: confirmPin ?? this.confirmPin,
      firstPin: firstPin ?? this.firstPin,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        step,
        pin,
        confirmPin,
        firstPin,
        errorMessage,
      ];
}
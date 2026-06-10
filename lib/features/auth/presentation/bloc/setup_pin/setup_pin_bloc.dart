import 'package:d2ybank/shared/base/base_bloc.dart';
import 'package:d2ybank/shared/base/base_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/setup_pin_usecase.dart';
import 'setup_pin_event.dart';
import 'setup_pin_state.dart';

class SetupPinBloc extends BaseBloc<SetupPinEvent, SetupPinState> {
  final SetupPinUseCase setupPinUseCase;

  SetupPinBloc({
    required this.setupPinUseCase,
  }) : super(const SetupPinState()) {
    on<SetupPinDigitPressed>(_onDigitPressed);
    on<SetupPinBackspacePressed>(_onBackspacePressed);
    on<SetupPinResetRequested>(_onResetRequested);
  }

  Future<void> _onDigitPressed(
    SetupPinDigitPressed event,
    Emitter<SetupPinState> emit,
  ) async {
    if (!RegExp(r'^\d$').hasMatch(event.digit)) return;
    if (state.isLoading) return;

    switch (state.step) {
      case SetupPinStep.create:
        await _handleCreateStep(event.digit, emit);
        break;
      case SetupPinStep.confirm:
        await _handleConfirmStep(event.digit, emit);
        break;
    }
  }

  Future<void> _handleCreateStep(
    String digit,
    Emitter<SetupPinState> emit,
  ) async {
    if (state.pin.length >= 6) return;

    final nextPin = '${state.pin}$digit';

    if (nextPin.length < 6) {
      emit(
        state.copyWith(
          pin: nextPin,
          status: StateStatus.initial,
          clearError: true,
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        pin: nextPin,
        firstPin: nextPin,
        step: SetupPinStep.confirm,
        confirmPin: '',
        status: StateStatus.initial,
        clearError: true,
      ),
    );
  }

  Future<void> _handleConfirmStep(
    String digit,
    Emitter<SetupPinState> emit,
  ) async {
    if (state.confirmPin.length >= 6) return;

    final nextConfirmPin = '${state.confirmPin}$digit';

    if (nextConfirmPin.length < 6) {
      emit(
        state.copyWith(
          confirmPin: nextConfirmPin,
          status: StateStatus.initial,
          clearError: true,
        ),
      );
      return;
    }

    if (nextConfirmPin != state.firstPin) {
      emit(
        state.copyWith(
          status: StateStatus.failure,
          confirmPin: '',
          errorMessage: 'PIN tidak cocok. Silakan ulangi konfirmasi PIN.',
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        confirmPin: nextConfirmPin,
        status: StateStatus.loading,
        clearError: true,
      ),
    );

    final result = await setupPinUseCase(
      SetupPinParams(pin: nextConfirmPin),
    );

    result.fold(
      (message) {
        emit(
          state.copyWith(
            status: StateStatus.failure,
            confirmPin: '',
            errorMessage: message,
          ),
        );
      },
      (_) {
        emit(
          state.copyWith(
            status: StateStatus.success,
            clearError: true,
          ),
        );
      },
    );
  }

  void _onBackspacePressed(
    SetupPinBackspacePressed event,
    Emitter<SetupPinState> emit,
  ) {
    if (state.isLoading) return;

    switch (state.step) {
      case SetupPinStep.create:
        if (state.pin.isEmpty) return;

        emit(
          state.copyWith(
            pin: state.pin.substring(0, state.pin.length - 1),
            status: StateStatus.initial,
            clearError: true,
          ),
        );
        break;

      case SetupPinStep.confirm:
        if (state.confirmPin.isEmpty) return;

        emit(
          state.copyWith(
            confirmPin: state.confirmPin.substring(
              0,
              state.confirmPin.length - 1,
            ),
            status: StateStatus.initial,
            clearError: true,
          ),
        );
        break;
    }
  }

  void _onResetRequested(
    SetupPinResetRequested event,
    Emitter<SetupPinState> emit,
  ) {
    emit(const SetupPinState());
  }
}
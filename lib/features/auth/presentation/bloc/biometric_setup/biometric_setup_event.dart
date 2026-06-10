import 'package:equatable/equatable.dart';

sealed class BiometricSetupEvent extends Equatable {
  const BiometricSetupEvent();

  @override
  List<Object?> get props => [];
}

class BiometricSetupStarted extends BiometricSetupEvent {
  const BiometricSetupStarted();
}

class BiometricEnableRequested extends BiometricSetupEvent {
  final String userId;
  final String deviceId;

  const BiometricEnableRequested({
    required this.userId,
    required this.deviceId,
  });

  @override
  List<Object?> get props => [userId, deviceId];
}

class BiometricSkipRequested extends BiometricSetupEvent {
  const BiometricSkipRequested();
}
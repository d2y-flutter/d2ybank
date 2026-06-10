import 'package:equatable/equatable.dart';
import 'package:local_auth/local_auth.dart';

class BiometricAvailabilityEntity extends Equatable {
  final bool isDeviceSupported;
  final bool canCheckBiometrics;
  final List<BiometricType> availableTypes;
  final String label;

  const BiometricAvailabilityEntity({
    required this.isDeviceSupported,
    required this.canCheckBiometrics,
    required this.availableTypes,
    required this.label,
  });

  bool get isAvailable =>
      isDeviceSupported && canCheckBiometrics && availableTypes.isNotEmpty;

  @override
  List<Object?> get props => [
        isDeviceSupported,
        canCheckBiometrics,
        availableTypes,
        label,
      ];
}
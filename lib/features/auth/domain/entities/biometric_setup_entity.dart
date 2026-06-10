import 'package:equatable/equatable.dart';

class BiometricSetupEntity extends Equatable {
  final bool isEnabled;
  final String? userId;
  final String? deviceId;
  final DateTime? registeredAt;

  const BiometricSetupEntity({
    required this.isEnabled,
    this.userId,
    this.deviceId,
    this.registeredAt,
  });

  @override
  List<Object?> get props => [
        isEnabled,
        userId,
        deviceId,
        registeredAt,
      ];
}
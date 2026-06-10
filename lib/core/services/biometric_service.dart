import 'package:local_auth/local_auth.dart';

class BiometricService {
  final LocalAuthentication _auth;

  BiometricService({
    LocalAuthentication? auth,
  }) : _auth = auth ?? LocalAuthentication();

  Future<bool> isDeviceSupported() {
    return _auth.isDeviceSupported();
  }

  Future<bool> canCheckBiometrics() {
    return _auth.canCheckBiometrics;
  }

  Future<List<BiometricType>> getAvailableBiometrics() {
    return _auth.getAvailableBiometrics();
  }

  Future<bool> isAvailable() async {
    final isSupported = await isDeviceSupported();
    final canCheck = await canCheckBiometrics();
    final biometrics = await getAvailableBiometrics();

    return isSupported && canCheck && biometrics.isNotEmpty;
  }

  Future<bool> authenticate({
    String localizedReason =
        'Autentikasi biometrik diperlukan untuk melanjutkan.',
    bool biometricOnly = true,
  }) async {
    return _auth.authenticate(
      localizedReason: localizedReason,
      options: AuthenticationOptions(
        biometricOnly: biometricOnly,
        stickyAuth: true,
        useErrorDialogs: true,
        sensitiveTransaction: true,
      ),
    );
  }

  String resolveBiometricLabel(List<BiometricType> types) {
    if (types.contains(BiometricType.face)) return 'Face ID';
    if (types.contains(BiometricType.fingerprint)) return 'Sidik Jari';
    if (types.contains(BiometricType.iris)) return 'Iris';
    if (types.contains(BiometricType.strong)) return 'Biometrik';
    if (types.contains(BiometricType.weak)) return 'Biometrik';
    return 'Biometrik';
  }
}
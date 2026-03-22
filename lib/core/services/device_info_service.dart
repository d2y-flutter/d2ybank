import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';

abstract class DeviceInfoService {
  Future<void> init();
  String get deviceId;
  String get deviceModel;
  String get platform;
}

class DeviceInfoServiceImpl implements DeviceInfoService {
  final DeviceInfoPlugin _plugin = DeviceInfoPlugin();
  String _deviceId = 'unknown';
  String _deviceModel = 'unknown';
  String _platform = 'unknown';

  @override
  Future<void> init() async {
    if (kIsWeb) { _platform = 'web'; return; }
    if (Platform.isAndroid) {
      final info = await _plugin.androidInfo;
      _deviceId = info.id;
      _deviceModel = '${info.manufacturer} ${info.model}';
      _platform = 'android';
    } else if (Platform.isIOS) {
      final info = await _plugin.iosInfo;
      _deviceId = info.identifierForVendor ?? 'unknown';
      _deviceModel = info.utsname.machine;
      _platform = 'ios';
    }
  }

  @override
  String get deviceId => _deviceId;
  @override
  String get deviceModel => _deviceModel;
  @override
  String get platform => _platform;
}

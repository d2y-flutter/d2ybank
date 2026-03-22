import 'dart:io';
import 'package:flutter/foundation.dart';

abstract final class PlatformChecker {
  static bool get isAndroid => !kIsWeb && Platform.isAndroid;
  static bool get isIOS => !kIsWeb && Platform.isIOS;
  static bool get isMobile => isAndroid || isIOS;
  static bool get isWeb => kIsWeb;
}

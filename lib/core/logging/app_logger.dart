import 'dart:developer' as developer;
import 'package:flutter/foundation.dart';

abstract final class AppLogger {
  static void debug(String message, {dynamic data}) => _log('🔍', message, data: data);
  static void info(String message, {dynamic data}) => _log('ℹ️', message, data: data);
  static void warning(String message, {dynamic data}) => _log('⚠️', message, data: data);
  static void error(String message, {dynamic error, StackTrace? stackTrace}) {
    _log('❌', message, data: error);
    if (stackTrace != null && kDebugMode) developer.log(stackTrace.toString(), name: 'D2YBank');
  }
  static void _log(String prefix, String message, {dynamic data}) {
    if (!kDebugMode) return;
    final output = data != null ? '$prefix $message | $data' : '$prefix $message';
    developer.log(output, name: 'D2YBank');
  }
}

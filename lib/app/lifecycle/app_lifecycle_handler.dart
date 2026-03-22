import 'package:flutter/material.dart';
import '../../core/logging/app_logger.dart';

class AppLifecycleHandler with WidgetsBindingObserver {
  void init() => WidgetsBinding.instance.addObserver(this);
  void dispose() => WidgetsBinding.instance.removeObserver(this);

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    AppLogger.debug('Lifecycle: $state');
  }
}

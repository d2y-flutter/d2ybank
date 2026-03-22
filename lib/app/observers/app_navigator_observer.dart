import 'package:flutter/material.dart';
import '../../core/logging/app_logger.dart';

class AppNavigatorObserver extends NavigatorObserver {
  @override
  void didPush(Route route, Route? previousRoute) { AppLogger.debug('NAV → ${route.settings.name}'); }
  @override
  void didPop(Route route, Route? previousRoute) { AppLogger.debug('NAV ← ${route.settings.name}'); }
}

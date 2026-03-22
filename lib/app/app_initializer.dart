import '../core/logging/app_logger.dart';
import 'di/injection_container.dart';

abstract final class AppInitializer {
  static Future<void> initialize() async {
    AppLogger.info('🚀 Initializing D2YBank...');
    await InjectionContainer.init();
    AppLogger.info('🏁 D2YBank ready!');
  }
}

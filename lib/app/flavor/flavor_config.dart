import 'app_flavor.dart';

abstract final class FlavorConfig {
  static String envFileFor(AppFlavor flavor) => '.env';
}

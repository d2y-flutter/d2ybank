import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  final String appName;
  final String baseUrl;
  final String socketUrl;
  final String apiVersion;
  final int connectTimeout;
  final int receiveTimeout;
  final int maxRetries;
  final bool enableLogging;

  const AppConfig({
    required this.appName, required this.baseUrl, required this.socketUrl,
    required this.apiVersion, required this.connectTimeout,
    required this.receiveTimeout, required this.maxRetries,
    required this.enableLogging,
  });

  factory AppConfig.fromEnv() => AppConfig(
    appName: dotenv.env['APP_NAME'] ?? 'D2YBank',
    baseUrl: dotenv.env['BASE_URL'] ?? '',
    socketUrl: dotenv.env['SOCKET_URL'] ?? '',
    apiVersion: dotenv.env['API_VERSION'] ?? 'v1',
    connectTimeout: int.tryParse(dotenv.env['CONNECT_TIMEOUT'] ?? '') ?? 30000,
    receiveTimeout: int.tryParse(dotenv.env['RECEIVE_TIMEOUT'] ?? '') ?? 30000,
    maxRetries: int.tryParse(dotenv.env['MAX_RETRIES'] ?? '') ?? 3,
    enableLogging: dotenv.env['ENABLE_LOGGING'] == 'true',
  );
}

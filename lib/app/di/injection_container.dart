import 'package:get_it/get_it.dart';
import '../../core/config/app_config.dart';
import '../../core/network/api_client.dart';
import '../../core/network/network_info.dart';
import '../../core/services/secure_storage_service.dart';
import '../../core/services/local_storage_service.dart';
import '../../core/services/connectivity_service.dart';
import '../../core/services/device_info_service.dart';
import '../../core/services/language_service.dart';

final GetIt sl = GetIt.instance;

abstract final class InjectionContainer {
  static Future<void> init() async {
    // Config
    sl.registerLazySingleton<AppConfig>(() => AppConfig.fromEnv());

    // Services - Tier 1
    sl.registerLazySingleton<SecureStorageService>(() => SecureStorageServiceImpl());
    final localStorage = LocalStorageServiceImpl();
    await localStorage.init();
    sl.registerLazySingleton<LocalStorageService>(() => localStorage);
    sl.registerLazySingleton<ConnectivityService>(() => ConnectivityServiceImpl());

    final deviceInfo = DeviceInfoServiceImpl();
    await deviceInfo.init();
    sl.registerLazySingleton<DeviceInfoService>(() => deviceInfo);

    // Services - Tier 2
    final langService = LanguageServiceImpl(localStorage: sl());
    await langService.init();
    sl.registerLazySingleton<LanguageService>(() => langService);

    // Network
    sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
    sl.registerLazySingleton<ApiClient>(() => ApiClient(config: sl(), networkInfo: sl()));
  }
}

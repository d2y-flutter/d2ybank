import 'package:d2ybank/core/services/face_detection_service.dart';
import 'package:d2ybank/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:d2ybank/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:d2ybank/features/auth/domain/repositories/auth_repository.dart';
import 'package:d2ybank/features/auth/domain/usecases/login_usecase.dart';
import 'package:d2ybank/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:d2ybank/features/auth/presentation/bloc/identity_verification/identity_verification_bloc.dart';
import 'package:d2ybank/features/dashboard/data/datasources/dashboard_data_source.dart';
import 'package:d2ybank/features/dashboard/data/repositories/dashboard_repository_impl.dart';
import 'package:d2ybank/features/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:d2ybank/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:d2ybank/features/auth/data/repositories/identity_verification_repository_impl.dart';
import 'package:d2ybank/features/auth/domain/repositories/identity_verification_repository.dart';
import 'package:d2ybank/features/auth/domain/usecases/submit_face_verification_usecase.dart';
import 'package:d2ybank/features/auth/domain/usecases/submit_ktp_photo_usecase.dart';
import 'package:d2ybank/features/auth/data/repositories/kyc_repository_impl.dart';
import 'package:d2ybank/features/auth/domain/repositories/kyc_repository.dart';
import 'package:d2ybank/features/auth/domain/usecases/submit_kyc_usecase.dart';
import 'package:d2ybank/features/auth/presentation/bloc/kyc/kyc_bloc.dart';
import 'package:d2ybank/features/auth/data/repositories/setup_password_repository_impl.dart';
import 'package:d2ybank/features/auth/domain/repositories/setup_password_repository.dart';
import 'package:d2ybank/features/auth/domain/usecases/setup_password_usecase.dart';
import 'package:d2ybank/features/auth/presentation/bloc/setup_password/setup_password_bloc.dart';

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

    // Data Sources
    sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthDummyDataSource(),
    );
    sl.registerLazySingleton<DashboardDataSource>(
      () => DashboardDummyDataSource(),
    );

    // Repository
    sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(remoteDataSource: sl()),
    );
    sl.registerLazySingleton<DashboardRepository>(
      () => DashboardRepositoryImpl(dataSource: sl()),
    );

    // UseCases
    sl.registerLazySingleton(() => LoginUseCase(sl()));

    // Bloc
    sl.registerFactory(() => AuthBloc(loginUseCase: sl()));
    sl.registerFactory(() => DashboardBloc(repository: sl()));

    sl.registerLazySingleton<IdentityVerificationRepository>(
      () => IdentityVerificationRepositoryImpl(),
    );

    // ============================================

    sl.registerLazySingleton(
      () => SubmitKtpPhotoUseCase(sl<IdentityVerificationRepository>()),
    );

    sl.registerLazySingleton(
      () => SubmitFaceVerificationUseCase(sl<IdentityVerificationRepository>()),
    );

    sl.registerLazySingleton<FaceDetectionService>(
      () => FaceDetectionService(),
    );

    sl.registerFactory(
      () => IdentityVerificationBloc(
        submitKtpPhotoUseCase: sl<SubmitKtpPhotoUseCase>(),
        submitFaceVerificationUseCase: sl<SubmitFaceVerificationUseCase>(),
      ),
    );

    sl.registerLazySingleton<KycRepository>(
      () => KycRepositoryImpl(),
    );

    sl.registerLazySingleton(
      () => SubmitKycUseCase(sl<KycRepository>()),
    );

    sl.registerFactory(
      () => KycBloc(
        submitKycUseCase: sl<SubmitKycUseCase>(),
      ),
    );
    
    sl.registerLazySingleton<SetupPasswordRepository>(
      () => SetupPasswordRepositoryImpl(),
    );

    sl.registerLazySingleton(
      () => SetupPasswordUseCase(sl<SetupPasswordRepository>()),
    );

    sl.registerFactory(
      () => SetupPasswordBloc(
        setupPasswordUseCase: sl<SetupPasswordUseCase>(),
      ),
    );
  }
}

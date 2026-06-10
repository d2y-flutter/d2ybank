import 'package:d2ybank/app/di/injection_container.dart';
import 'package:d2ybank/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:d2ybank/features/auth/presentation/bloc/biometric_setup/biometric_setup_bloc.dart';
import 'package:d2ybank/features/auth/presentation/bloc/identity_verification/identity_verification_bloc.dart';
import 'package:d2ybank/features/auth/presentation/bloc/kyc/kyc_bloc.dart';
import 'package:d2ybank/features/auth/presentation/bloc/setup_password/setup_password_bloc.dart';
import 'package:d2ybank/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import '../core/config/app_theme.dart';
import 'navigation/app_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class D2YBankApp extends StatelessWidget {
  const D2YBankApp({super.key});

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('id')],
        path: 'assets/translations',
        fallbackLocale: const Locale('en'),
        child: Builder(
          builder: (context) {
            return MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (_) => sl<AuthBloc>(),
                ),
                BlocProvider(
                  create: (_) => sl<DashboardBloc>(),
                ),
                BlocProvider(
                  create: (_) => sl<IdentityVerificationBloc>(),
                ),
                BlocProvider(
                  create: (_) => sl<KycBloc>(),
                ),
                BlocProvider(
                  create: (_) => sl<SetupPasswordBloc>(),
                ),
                BlocProvider(
                  create: (_) => sl<BiometricSetupBloc>(),
                ),
              ],
              child: MaterialApp.router(
                title: 'D2YBank',
                debugShowCheckedModeBanner: false,
                theme: AppTheme.light,
                themeMode: ThemeMode.system,
                localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
                locale: context.locale,
                routerConfig: AppRouter.router,
              ),
            );
          },
        ),
      ),
    );
  }
}
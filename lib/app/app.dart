import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import '../core/config/app_theme.dart';
import 'navigation/app_router.dart';

class D2YBankApp extends StatelessWidget {
  const D2YBankApp({super.key});

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('id')],
        path: 'assets/translations',
        fallbackLocale: const Locale('en'),
        child: Builder(builder: (context) => MaterialApp.router(
          title: 'D2YBank',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: ThemeMode.system,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          routerConfig: AppRouter.router,
        )),
      ),
    );
  }
}

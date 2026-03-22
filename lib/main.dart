import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:easy_localization/easy_localization.dart';
import 'app/app.dart';
import 'app/app_initializer.dart';
import 'app/observers/app_bloc_observer.dart';
import 'core/logging/app_logger.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));

  Bloc.observer = AppBlocObserver();

  await dotenv.load(fileName: '.env');
  await AppInitializer.initialize();

  FlutterError.onError = (details) {
    AppLogger.error('FlutterError', error: details.exception, stackTrace: details.stack);
  };

  runZonedGuarded(
    () => runApp(const D2YBankApp()),
    (error, stackTrace) => AppLogger.error('Uncaught error', error: error, stackTrace: stackTrace),
  );
}

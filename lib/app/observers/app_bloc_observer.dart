import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/logging/app_logger.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) { super.onCreate(bloc); AppLogger.debug('BLoC created: ${bloc.runtimeType}'); }
  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    AppLogger.error('BLoC error in ${bloc.runtimeType}', error: error, stackTrace: stackTrace);
    super.onError(bloc, error, stackTrace);
  }
}

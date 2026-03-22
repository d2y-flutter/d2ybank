import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/errors/failures.dart';
import '../../core/logging/app_logger.dart';

abstract class BaseBloc<Event, State> extends Bloc<Event, State> {
  BaseBloc(super.initialState);

  void handleFailure(Failure failure) {
    AppLogger.error('${runtimeType.toString()} failure: ${failure.message}');
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    AppLogger.error('${runtimeType.toString()} error', error: error, stackTrace: stackTrace);
    super.onError(error, stackTrace);
  }
}

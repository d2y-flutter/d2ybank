import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/errors/failures.dart';
import '../../core/logging/app_logger.dart';

abstract class BaseCubit<State> extends Cubit<State> {
  BaseCubit(super.initialState);

  void safeEmit(State state) { if (!isClosed) emit(state); }

  void handleFailure(Failure failure) {
    AppLogger.error('${runtimeType.toString()} failure: ${failure.message}');
  }
}

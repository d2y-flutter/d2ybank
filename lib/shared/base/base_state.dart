import 'package:equatable/equatable.dart';
import '../../core/errors/failures.dart';

enum StateStatus { initial, loading, success, failure, empty }

class BaseState<T> extends Equatable {
  final StateStatus status;
  final T? data;
  final Failure? failure;
  final String? message;

  const BaseState({this.status = StateStatus.initial, this.data, this.failure, this.message});

  bool get isInitial => status == StateStatus.initial;
  bool get isLoading => status == StateStatus.loading;
  bool get isSuccess => status == StateStatus.success;
  bool get isFailure => status == StateStatus.failure;
  bool get isEmpty => status == StateStatus.empty;

  @override
  List<Object?> get props => [status, data, failure, message];
}

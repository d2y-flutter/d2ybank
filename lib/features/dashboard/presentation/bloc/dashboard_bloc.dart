import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:d2ybank/shared/base/base_bloc.dart';
import 'package:d2ybank/shared/base/base_state.dart';

import '../../domain/repositories/dashboard_repository.dart';
import 'dashboard_event.dart';
import 'dashboard_state.dart';

class DashboardBloc extends BaseBloc<DashboardEvent, DashboardState> {
  final DashboardRepository repository;

  DashboardBloc({required this.repository}) : super(const DashboardState()) {
    on<DashboardStarted>(_onDashboardStarted);
    on<DashboardRefreshRequested>(_onDashboardRefreshRequested);
    on<DashboardBalanceVisibilityToggled>(_onBalanceVisibilityToggled);
  }

  Future<void> _onDashboardStarted(
    DashboardStarted event,
    Emitter<DashboardState> emit,
  ) async {
    await _loadDashboard(emit);
  }

  Future<void> _onDashboardRefreshRequested(
    DashboardRefreshRequested event,
    Emitter<DashboardState> emit,
  ) async {
    await _loadDashboard(emit);
  }

  void _onBalanceVisibilityToggled(
    DashboardBalanceVisibilityToggled event,
    Emitter<DashboardState> emit,
  ) {
    emit(state.copyWith(balanceVisible: !state.balanceVisible));
  }

  Future<void> _loadDashboard(Emitter<DashboardState> emit) async {
    emit(state.copyWith(status: StateStatus.loading, clearFailure: true));

    // Keep the current repository contract. When BE is ready, only the repository/data layer changes.
    final results = await Future.wait<dynamic>([
      repository.getAccount(),
      repository.getQuickActions(),
      repository.getExclusiveServices(),
      repository.getEWallets(),
      repository.getPromos(),
      repository.getProducts(),
    ]);

    final accountResult = results[0];
    final actionsResult = results[1];
    final servicesResult = results[2];
    final walletsResult = results[3];
    final promosResult = results[4];
    final productsResult = results[5];

    accountResult.fold(
      (failure) {
        emit(
          state.copyWith(
            status: StateStatus.failure,
            failure: failure,
          ),
        );
      },
      (account) {
        emit(
          state.copyWith(
            status: StateStatus.success,
            account: account,
            quickActions: actionsResult.fold((_) => [], (data) => data),
            exclusiveServices: servicesResult.fold((_) => [], (data) => data),
            eWallets: walletsResult.fold((_) => [], (data) => data),
            promos: promosResult.fold((_) => [], (data) => data),
            products: productsResult.fold((_) => [], (data) => data),
            clearFailure: true,
          ),
        );
      },
    );
  }
}

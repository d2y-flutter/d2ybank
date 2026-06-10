import 'package:d2ybank/shared/base/base_cubit.dart';
import 'package:d2ybank/shared/base/base_state.dart';
import '../../domain/repositories/dashboard_repository.dart';
import 'dashboard_state.dart';

class DashboardCubit extends BaseCubit<DashboardState> {
  final DashboardRepository repository;

  DashboardCubit({required this.repository}) : super(const DashboardState());

  Future<void> loadDashboard() async {
    safeEmit(state.copyWith(status: StateStatus.loading));

    // Fire all requests in parallel
    final results = await Future.wait([
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

    // Check if account (critical data) failed
    accountResult.fold(
      (failure) {
        handleFailure(failure);
        safeEmit(state.copyWith(status: StateStatus.failure, failure: failure));
      },
      (account) {
        safeEmit(state.copyWith(
          status: StateStatus.success,
          account: account as dynamic,
          quickActions: actionsResult.fold((_) => [], (d) => d as dynamic),
          exclusiveServices: servicesResult.fold((_) => [], (d) => d as dynamic),
          eWallets: walletsResult.fold((_) => [], (d) => d as dynamic),
          promos: promosResult.fold((_) => [], (d) => d as dynamic),
          products: productsResult.fold((_) => [], (d) => d as dynamic),
        ));
      },
    );
  }

  void toggleBalanceVisibility() {
    safeEmit(state.copyWith(balanceVisible: !state.balanceVisible));
  }
}
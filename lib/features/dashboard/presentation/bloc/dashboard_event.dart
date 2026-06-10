import 'package:equatable/equatable.dart';

sealed class DashboardEvent extends Equatable {
  const DashboardEvent();

  @override
  List<Object?> get props => const [];
}

final class DashboardStarted extends DashboardEvent {
  const DashboardStarted();
}

final class DashboardRefreshRequested extends DashboardEvent {
  const DashboardRefreshRequested();
}

final class DashboardBalanceVisibilityToggled extends DashboardEvent {
  const DashboardBalanceVisibilityToggled();
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:d2ybank/shared/base/base_state.dart';
import 'package:d2ybank/shared/components/feedback/d2y_error_view.dart';
import 'package:d2ybank/shared/components/feedback/d2y_loading.dart';

import '../bloc/dashboard_bloc.dart';
import '../bloc/dashboard_event.dart';
import '../bloc/dashboard_state.dart';
import '../widgets/dashboard_mobile_view.dart';
import '../widgets/dashboard_ui_tokens.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    super.initState();
    context.read<DashboardBloc>().add(const DashboardStarted());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DashboardUiTokens.background,
      body: BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
          final isInitialLoading =
              state.account == null &&
              (state.status == StateStatus.initial ||
                  state.status == StateStatus.loading);

          if (isInitialLoading) {
            return const D2YLoading(message: 'Loading your vault...');
          }

          if (state.status == StateStatus.failure && state.account == null) {
            return D2YErrorView(
              message: state.failure?.message,
              onRetry: () => context
                  .read<DashboardBloc>()
                  .add(const DashboardRefreshRequested()),
            );
          }

          return DashboardMobileView(
            account: state.account,
            quickActions: state.quickActions,
            promos: state.promos,
            balanceVisible: state.balanceVisible,
            onToggleBalanceVisibility: () => context
                .read<DashboardBloc>()
                .add(const DashboardBalanceVisibilityToggled()),
            onRefresh: () async => context
                .read<DashboardBloc>()
                .add(const DashboardRefreshRequested()),
            onTopUpTap: () {},
            onTransferTap: () {},
            onActionTap: (_) {},
            onPromoTap: (_) {},
            onSeeAllPromoTap: () {},
            onHelpTap: () {},
            onProfileTap: () {},
          );
        },
      ),
    );
  }
}

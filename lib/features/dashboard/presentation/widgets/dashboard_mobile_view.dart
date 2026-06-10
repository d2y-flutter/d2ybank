import 'package:flutter/material.dart';

import '../../domain/entities/dashboard_entities.dart';
import 'balance_hero_card.dart';
import 'dashboard_account_formatter.dart';
import 'dashboard_balance_formatter.dart';
import 'dashboard_greeting.dart';
import 'dashboard_sticky_app_bar.dart';
import 'dashboard_ui_tokens.dart';
import 'promo_section.dart';
import 'transaction_menu_grid.dart';

class DashboardMobileView extends StatelessWidget {
  const DashboardMobileView({
    required this.account,
    required this.quickActions,
    required this.promos,
    required this.balanceVisible,
    required this.onToggleBalanceVisibility,
    this.onActionTap,
    this.onPromoTap,
    this.onSeeAllPromoTap,
    this.onHelpTap,
    this.onProfileTap,
    this.onTopUpTap,
    this.onTransferTap,
    this.onBottomNavTap,
    this.onQrisTap,
    this.onRefresh,
    super.key,
  });

  final AccountEntity? account;
  final List<QuickActionEntity> quickActions;
  final List<PromoEntity> promos;
  final bool balanceVisible;
  final VoidCallback onToggleBalanceVisibility;
  final ValueChanged<QuickActionEntity>? onActionTap;
  final ValueChanged<PromoEntity>? onPromoTap;
  final VoidCallback? onSeeAllPromoTap;
  final VoidCallback? onHelpTap;
  final VoidCallback? onProfileTap;
  final VoidCallback? onTopUpTap;
  final VoidCallback? onTransferTap;
  final ValueChanged<int>? onBottomNavTap;
  final VoidCallback? onQrisTap;
  final Future<void> Function()? onRefresh;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            DashboardStickyAppBar(
              profileImageUrl: DashboardAccountFormatter.profileImageUrl(account),
              onHelpTap: onHelpTap,
              onProfileTap: onProfileTap,
            ),
            Expanded(
              child: RefreshIndicator.adaptive(
                color: DashboardUiTokens.primary,
                onRefresh: onRefresh ?? () async {},
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics(),
                  ),
                  padding: const EdgeInsets.only(bottom: 128),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: DashboardUiTokens.maxContentWidth,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                              DashboardUiTokens.marginMobile,
                              DashboardUiTokens.gapMd,
                              DashboardUiTokens.marginMobile,
                              0,
                            ),
                            child: DashboardGreeting(
                              userName: DashboardAccountFormatter.displayName(account),
                            ),
                          ),
                          const SizedBox(height: DashboardUiTokens.gapLg),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: DashboardUiTokens.marginMobile,
                            ),
                            child: BalanceHeroCard(
                              balanceText: DashboardBalanceFormatter.fromAccount(account),
                              balanceVisible: balanceVisible,
                              onToggleVisibility: onToggleBalanceVisibility,
                              onTopUpTap: onTopUpTap,
                              onTransferTap: onTransferTap,
                            ),
                          ),
                          // const SizedBox(height: DashboardUiTokens.gapXl),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: DashboardUiTokens.marginMobile,
                            ),
                            child: TransactionMenuGrid(
                              actions: quickActions,
                              onActionTap: onActionTap,
                            ),
                          ),
                          const SizedBox(height: DashboardUiTokens.gapXl),
                          PromoSection(
                            promos: promos,
                            onSeeAllTap: onSeeAllPromoTap,
                            onPromoTap: onPromoTap,
                          ),
                          const SizedBox(height: DashboardUiTokens.gapLg),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
     
      ],
    );
  }
}

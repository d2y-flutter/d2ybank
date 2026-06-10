import 'package:flutter/material.dart';
import 'package:d2ybank/core/config/app_colors.dart';
import 'package:d2ybank/core/config/app_spacing.dart';
import 'package:d2ybank/core/config/app_radius.dart';
import '../../domain/entities/dashboard_entities.dart';

/// 5-column quick actions grid matching HTML layout.
/// surfaceContainerLow bg tiles, icon + label.
class QuickActionsGrid extends StatelessWidget {
  final List<QuickActionEntity> actions;

  const QuickActionsGrid({super.key, required this.actions});

  /// Map iconName string → IconData
  static IconData _resolveIcon(String name) {
    return switch (name) {
      'swap_horiz' => Icons.swap_horiz_rounded,
      'account_balance' => Icons.account_balance_rounded,
      'add_circle' => Icons.add_circle_rounded,
      'contactless' => Icons.contactless_rounded,
      'local_atm' => Icons.local_atm_rounded,
      'currency_exchange' => Icons.currency_exchange_rounded,
      'receipt_long' => Icons.receipt_long_rounded,
      'nfc' => Icons.nfc_rounded,
      'qr_code_2' => Icons.qr_code_2_rounded,
      'grid_view' => Icons.grid_view_rounded,
      _ => Icons.circle_outlined,
    };
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: actions.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
        mainAxisSpacing: AppSpacing.lg,
        crossAxisSpacing: AppSpacing.xxs,
        childAspectRatio: 0.75,
      ),
      itemBuilder: (context, index) {
        final action = actions[index];
        final isLast = action.iconName == 'grid_view';

        return GestureDetector(
          onTap: () {
            // TODO: Navigate to action.route
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: isLast
                      ? AppColors.primary.withValues(alpha: 0.05)
                      : AppColors.surfaceContainerLow,
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                ),
                child: Icon(
                  _resolveIcon(action.iconName),
                  color: AppColors.primary,
                  size: 24,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                action.label,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontFamily: 'PlusJakartaSans',
                  fontSize: 13,
                  fontWeight: isLast ? FontWeight.w700 : FontWeight.w500,
                  color: isLast ? AppColors.primary : AppColors.onSurfaceVariant,
                  height: 1.3,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
import 'package:flutter/material.dart';

import '../../domain/entities/dashboard_entities.dart';
import 'dashboard_action_mapper.dart';
import 'dashboard_ui_tokens.dart';

class TransactionMenuGrid extends StatelessWidget {
  const TransactionMenuGrid({
    required this.actions,
    this.onActionTap,
    super.key,
  });

  final List<QuickActionEntity> actions;
  final ValueChanged<QuickActionEntity>? onActionTap;

  @override
  Widget build(BuildContext context) {
    final visibleActions = actions.take(8).toList(growable: false);

    if (visibleActions.isEmpty) return const SizedBox.shrink();

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: visibleActions.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisExtent: 86,
        crossAxisSpacing: 8,
        mainAxisSpacing: 20,
      ),
      itemBuilder: (context, index) {
        final action = visibleActions[index];
        return _TransactionMenuItem(
          label: DashboardActionMapper.label(action, index),
          icon: DashboardActionMapper.icon(action, index),
          onTap: () => onActionTap?.call(action),
        );
      },
    );
  }
}

class _TransactionMenuItem extends StatelessWidget {
  const _TransactionMenuItem({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: DashboardUiTokens.radiusLg,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: DashboardUiTokens.primaryContainer.withOpacity(0.10),
                borderRadius: DashboardUiTokens.radiusLg,
              ),
              child: Icon(
                icon,
                size: 28,
                color: DashboardUiTokens.primary,
              ),
            ),
            const SizedBox(height: DashboardUiTokens.gapSm),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'DMSans',
                fontSize: 12,
                height: 1.3,
                fontWeight: FontWeight.w700,
                color: DashboardUiTokens.onSurface,
                letterSpacing: 0.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

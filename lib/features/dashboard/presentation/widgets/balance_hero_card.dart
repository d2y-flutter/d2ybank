import 'package:flutter/material.dart';

import 'dashboard_ui_tokens.dart';

class BalanceHeroCard extends StatelessWidget {
  const BalanceHeroCard({
    required this.balanceText,
    required this.balanceVisible,
    required this.onToggleVisibility,
    this.onTopUpTap,
    this.onTransferTap,
    super.key,
  });

  final String balanceText;
  final bool balanceVisible;
  final VoidCallback onToggleVisibility;
  final VoidCallback? onTopUpTap;
  final VoidCallback? onTransferTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: DashboardUiTokens.radiusLg,
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            DashboardUiTokens.primary,
            DashboardUiTokens.primaryContainer,
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: DashboardUiTokens.primary.withOpacity(0.22),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            top: -48,
            right: -48,
            child: Container(
              width: 128,
              height: 128,
              decoration: BoxDecoration(
                color: DashboardUiTokens.secondaryContainer.withOpacity(0.20),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Total Saldo',
                        style: TextStyle(
                          fontFamily: 'DMSans',
                          fontSize: 14,
                          height: 1.4,
                          fontWeight: FontWeight.w600,
                          color: Colors.white.withOpacity(0.72),
                        ),
                      ),
                    ),
                    _BalanceVisibilityButton(
                      visible: balanceVisible,
                      onTap: onToggleVisibility,
                    ),
                  ],
                ),
                const SizedBox(height: DashboardUiTokens.gapSm),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    const Text(
                      'Rp',
                      style: TextStyle(
                        fontFamily: 'PlusJakartaSans',
                        fontSize: 20,
                        height: 1.3,
                        fontWeight: FontWeight.w700,
                        color: DashboardUiTokens.secondaryFixed,
                      ),
                    ),
                    const SizedBox(width: DashboardUiTokens.gapSm),
                    Flexible(
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 180),
                        child: Text(
                          balanceVisible ? balanceText : '••••••••',
                          key: ValueKey(balanceVisible),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontFamily: 'PlusJakartaSans',
                            fontSize: 32,
                            height: 1.2,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            letterSpacing: -0.6,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: DashboardUiTokens.gapLg),
                Row(
                  children: [
                    Expanded(
                      child: _HeroActionButton.filled(
                        label: 'Top Up',
                        icon: Icons.add_circle_rounded,
                        onTap: onTopUpTap,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _HeroActionButton.outlined(
                        label: 'Transfer',
                        icon: Icons.send_rounded,
                        onTap: onTransferTap,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BalanceVisibilityButton extends StatelessWidget {
  const _BalanceVisibilityButton({
    required this.visible,
    required this.onTap,
  });

  final bool visible;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white.withOpacity(0.10),
      borderRadius: BorderRadius.circular(999),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(999),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                visible ? Icons.visibility_rounded : Icons.visibility_off_rounded,
                size: 18,
                color: Colors.white.withOpacity(0.78),
              ),
              const SizedBox(width: DashboardUiTokens.gapXs),
              Text(
                visible ? 'Sembunyikan' : 'Lihat Saldo',
                style: TextStyle(
                  fontFamily: 'DMSans',
                  fontSize: 12,
                  height: 1.3,
                  fontWeight: FontWeight.w700,
                  color: Colors.white.withOpacity(0.78),
                  letterSpacing: 0.6,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeroActionButton extends StatelessWidget {
  const _HeroActionButton._({
    required this.label,
    required this.icon,
    required this.isFilled,
    this.onTap,
  });

  factory _HeroActionButton.filled({
    required String label,
    required IconData icon,
    VoidCallback? onTap,
  }) {
    return _HeroActionButton._(
      label: label,
      icon: icon,
      isFilled: true,
      onTap: onTap,
    );
  }

  factory _HeroActionButton.outlined({
    required String label,
    required IconData icon,
    VoidCallback? onTap,
  }) {
    return _HeroActionButton._(
      label: label,
      icon: icon,
      isFilled: false,
      onTap: onTap,
    );
  }

  final String label;
  final IconData icon;
  final bool isFilled;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final backgroundColor = isFilled
        ? DashboardUiTokens.secondaryContainer
        : Colors.white.withOpacity(0.10);
    final foregroundColor = isFilled
        ? DashboardUiTokens.onSecondaryContainer
        : Colors.white;

    return Material(
      color: backgroundColor,
      borderRadius: DashboardUiTokens.radiusMd,
      child: InkWell(
        onTap: onTap,
        borderRadius: DashboardUiTokens.radiusMd,
        child: Container(
          height: 48,
          decoration: BoxDecoration(
            borderRadius: DashboardUiTokens.radiusMd,
            border: isFilled
                ? null
                : Border.all(color: Colors.white.withOpacity(0.20)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 20, color: foregroundColor),
              const SizedBox(width: DashboardUiTokens.gapSm),
              Text(
                label,
                style: TextStyle(
                  fontFamily: 'DMSans',
                  fontSize: 14,
                  height: 1.4,
                  fontWeight: FontWeight.w700,
                  color: foregroundColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:ui';

import 'package:flutter/material.dart';

import 'dashboard_ui_tokens.dart';

class DashboardBottomNavBar extends StatelessWidget {
  const DashboardBottomNavBar({
    this.currentIndex = 0,
    this.onTap,
    this.onQrisTap,
    super.key,
  });

  final int currentIndex;
  final ValueChanged<int>? onTap;
  final VoidCallback? onQrisTap;

  static const double _barHeight = 76;
  static const double _floatingAreaHeight = 28;
  static const double _qrisSize = 64;

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.paddingOf(context).bottom;

    return SizedBox(
      height: _barHeight + _floatingAreaHeight + bottomInset,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomCenter,
        children: [
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: DashboardUiTokens.surface.withOpacity(0.86),
                    border: Border(
                      top: BorderSide(
                        color: DashboardUiTokens.outlineVariant.withOpacity(0.35),
                      ),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.12),
                        blurRadius: 24,
                        offset: const Offset(0, -8),
                      ),
                    ],
                  ),
                  child: SizedBox(
                    height: _barHeight + bottomInset,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: bottomInset),
                      child: Center(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(
                            maxWidth: DashboardUiTokens.maxContentWidth,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _BottomNavItem(
                                index: 0,
                                currentIndex: currentIndex,
                                icon: Icons.home_rounded,
                                label: 'Home',
                                onTap: onTap,
                              ),
                              _BottomNavItem(
                                index: 1,
                                currentIndex: currentIndex,
                                icon: Icons.account_balance_wallet_rounded,
                                label: 'Wealth',
                                onTap: onTap,
                              ),
                              const SizedBox(width: 72),
                              _BottomNavItem(
                                index: 2,
                                currentIndex: currentIndex,
                                icon: Icons.notifications_rounded,
                                label: 'Inbox',
                                onTap: onTap,
                              ),
                              _BottomNavItem(
                                index: 3,
                                currentIndex: currentIndex,
                                icon: Icons.grid_view_rounded,
                                label: 'Menu',
                                onTap: onTap,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            child: _QrisActionButton(onTap: onQrisTap),
          ),
        ],
      ),
    );
  }
}

class _QrisActionButton extends StatelessWidget {
  const _QrisActionButton({this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Material(
          color: DashboardUiTokens.primary,
          shape: const CircleBorder(),
          elevation: 12,
          shadowColor: DashboardUiTokens.primary.withOpacity(0.35),
          child: InkWell(
            onTap: onTap,
            customBorder: const CircleBorder(),
            child: const SizedBox(
              width: DashboardBottomNavBar._qrisSize,
              height: DashboardBottomNavBar._qrisSize,
              child: Icon(
                Icons.qr_code_scanner_rounded,
                color: Colors.white,
                size: 32,
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'QRIS',
          style: TextStyle(
            fontFamily: 'DMSans',
            fontSize: 12,
            height: 1.2,
            fontWeight: FontWeight.w800,
            color: DashboardUiTokens.primary,
          ),
        ),
      ],
    );
  }
}

class _BottomNavItem extends StatelessWidget {
  const _BottomNavItem({
    required this.index,
    required this.currentIndex,
    required this.icon,
    required this.label,
    this.onTap,
  });

  final int index;
  final int currentIndex;
  final IconData icon;
  final String label;
  final ValueChanged<int>? onTap;

  @override
  Widget build(BuildContext context) {
    final selected = index == currentIndex;
    final foregroundColor = selected
        ? DashboardUiTokens.onSecondaryContainer
        : DashboardUiTokens.onSurfaceVariant;

    return Expanded(
      child: Center(
        child: Material(
          color: selected ? DashboardUiTokens.secondaryContainer : Colors.transparent,
          borderRadius: BorderRadius.circular(999),
          child: InkWell(
            onTap: () => onTap?.call(index),
            borderRadius: BorderRadius.circular(999),
            child: AnimatedPadding(
              duration: const Duration(milliseconds: 180),
              curve: Curves.easeOut,
              padding: EdgeInsets.symmetric(
                horizontal: selected ? 14 : 6,
                vertical: selected ? 6 : 4,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(icon, color: foregroundColor, size: 24),
                  const SizedBox(height: 2),
                  Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: 'DMSans',
                      fontSize: 12,
                      height: 1.2,
                      fontWeight: selected ? FontWeight.w800 : FontWeight.w700,
                      color: foregroundColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

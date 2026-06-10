import 'package:d2ybank/core/config/app_colors.dart';
import 'package:d2ybank/core/config/app_spacing.dart';
import 'package:flutter/material.dart';

class PinDotIndicator extends StatelessWidget {
  final int length;
  final int activeLength;

  const PinDotIndicator({
    super.key,
    required this.length,
    required this.activeLength,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(length, (index) {
        final isActive = index < activeLength;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOut,
          width: isActive ? 17 : 16,
          height: isActive ? 17 : 16,
          margin: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive ? AppColors.primaryContainer : Colors.transparent,
            border: Border.all(
              color: isActive
                  ? AppColors.primaryContainer
                  : AppColors.outlineVariant,
              width: 2,
            ),
          ),
        );
      }),
    );
  }
}
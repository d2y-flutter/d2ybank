import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:d2ybank/core/config/app_colors.dart';
import 'package:d2ybank/core/config/app_duration.dart';
import 'package:d2ybank/core/config/app_radius.dart';
import 'package:d2ybank/core/config/app_spacing.dart';
import 'package:d2ybank/core/config/app_text_styles.dart';

class D2YOtpBoxes extends StatelessWidget {
  final String value;
  final int length;

  const D2YOtpBoxes({
    super.key,
    required this.value,
    this.length = 6,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth;

        final gap = maxWidth < 360 ? AppSpacing.xs : AppSpacing.sm;
        final totalGap = gap * (length - 1);

        final availableBoxWidth = (maxWidth - totalGap) / length;
        final boxWidth = availableBoxWidth.clamp(38.0, 48.0);
        final boxHeight = math.max(56.0, boxWidth * 1.32);

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(length, (index) {
            final hasValue = index < value.length;
            final isActive = index == value.length && value.length < length;

            return Padding(
              padding: EdgeInsets.only(
                right: index == length - 1 ? AppSpacing.none : gap,
              ),
              child: AnimatedContainer(
                duration: AppDuration.normal,
                curve: Curves.easeOut,
                width: boxWidth,
                height: boxHeight,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: hasValue ? AppColors.white : AppColors.surfaceContainerLow,
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  border: Border.all(
                    color: hasValue || isActive
                        ? AppColors.primaryContainer
                        : AppColors.inputBorder,
                    width: isActive ? 2 : 1,
                  ),
                  boxShadow: [
                    if (isActive)
                      BoxShadow(
                        color: AppColors.focusRing,
                        blurRadius: 18,
                        spreadRadius: 4,
                      ),
                    if (hasValue)
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.06),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                  ],
                ),
                child: Text(
                  hasValue ? value[index] : '',
                  style: AppTextStyles.headlineMedium.copyWith(
                    color: AppColors.onSurface,
                    fontSize: boxWidth < 42 ? 18 : 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }
}
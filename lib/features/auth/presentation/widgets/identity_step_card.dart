import 'package:d2ybank/core/config/app_colors.dart';
import 'package:d2ybank/core/config/app_icon_size.dart';
import 'package:d2ybank/core/config/app_radius.dart';
import 'package:d2ybank/core/config/app_spacing.dart';
import 'package:d2ybank/core/config/app_text_styles.dart';
import 'package:flutter/material.dart';

class IdentityStepCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool isCompleted;
  final bool isActive;
  final VoidCallback onTap;

  const IdentityStepCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.isCompleted,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final borderColor = isCompleted
        ? AppColors.primary
        : isActive
            ? AppColors.primaryContainer.withValues(alpha: 0.35)
            : AppColors.cardBorder;

    final bgColor = isCompleted
        ? AppColors.primaryFixedDim.withValues(alpha: 0.10)
        : AppColors.surfaceContainerLowest;

    return Material(
      color: bgColor,
      borderRadius: BorderRadius.circular(AppRadius.xl),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.lg),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.xl),
            border: Border.all(color: borderColor, width: isActive ? 2 : 1),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.04),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isCompleted
                      ? AppColors.primaryFixedDim.withValues(alpha: 0.20)
                      : AppColors.secondaryContainer.withValues(alpha: 0.12),
                ),
                child: Icon(
                  icon,
                  color: isCompleted ? AppColors.primaryContainer : AppColors.secondary,
                  size: AppIconSize.lg,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTextStyles.bodyLarge.copyWith(
                        color: AppColors.onSurface,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xxs),
                    Text(
                      subtitle,
                      style: AppTextStyles.labelLarge.copyWith(
                        color: AppColors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              _StatusIcon(isCompleted: isCompleted, isActive: isActive),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatusIcon extends StatelessWidget {
  final bool isCompleted;
  final bool isActive;

  const _StatusIcon({
    required this.isCompleted,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    if (isCompleted) {
      return Container(
        width: 32,
        height: 32,
        decoration: const BoxDecoration(
          color: AppColors.primary,
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.check_circle_rounded,
          color: AppColors.white,
          size: 20,
        ),
      );
    }

    return Icon(
      isActive ? Icons.play_circle_rounded : Icons.lock_outline_rounded,
      color: isActive ? AppColors.primaryContainer : AppColors.outline,
      size: AppIconSize.lg,
    );
  }
}
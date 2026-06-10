import 'package:flutter/material.dart';
import '../../../core/config/app_colors.dart';
import '../../../core/config/app_spacing.dart';
import '../../../core/config/app_text_styles.dart';
import '../buttons/d2y_button.dart';

class D2YErrorView extends StatelessWidget {
  final String? title;
  final String? message;
  final VoidCallback? onRetry;

  const D2YErrorView({super.key, this.title, this.message, this.onRetry});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Center(child: Padding(padding: const EdgeInsets.all(AppSpacing.xl), child: Column(mainAxisSize: MainAxisSize.min, children: [
      Icon(Icons.error_outline_rounded, size: 72, color: AppColors.error.withValues(alpha: 0.7)),
      const SizedBox(height: AppSpacing.lg),
      Text(title ?? 'Something Went Wrong', style: AppTextStyles.headlineSmall.copyWith(color: isDark ? AppColors.primary : AppColors.primaryContainer), textAlign: TextAlign.center),
      if (message != null) ...[const SizedBox(height: AppSpacing.xs),
        Text(message!, style: AppTextStyles.bodyMedium.copyWith(color: isDark ? AppColors.secondary : AppColors.secondaryContainer), textAlign: TextAlign.center)],
      if (onRetry != null) ...[const SizedBox(height: AppSpacing.xl),
        D2YButton(text: 'Try Again', onPressed: onRetry, isFullWidth: false, size: D2YButtonSize.medium, prefixIcon: const Icon(Icons.refresh_rounded))],
    ])));
  }
}

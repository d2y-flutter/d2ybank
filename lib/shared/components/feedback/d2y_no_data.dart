import 'package:flutter/material.dart';
import '../../../core/config/app_colors.dart';
import '../../../core/config/app_spacing.dart';
import '../../../core/config/app_text_styles.dart';
import '../buttons/d2y_button.dart';

class D2YNoData extends StatelessWidget {
  final String? title;
  final String? message;
  final Widget? icon;
  final String? actionLabel;
  final VoidCallback? onAction;

  const D2YNoData({super.key, this.title, this.message, this.icon, this.actionLabel, this.onAction});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Center(child: Padding(padding: const EdgeInsets.all(AppSpacing.xl), child: Column(mainAxisSize: MainAxisSize.min, children: [
      icon ?? Icon(Icons.inbox_outlined, size: 80, color: isDark ? AppColors.neutral600 : AppColors.neutral400),
      const SizedBox(height: AppSpacing.lg),
      Text(title ?? 'No Data', style: AppTextStyles.headlineSmall.copyWith(color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight), textAlign: TextAlign.center),
      if (message != null) ...[const SizedBox(height: AppSpacing.xs),
        Text(message!, style: AppTextStyles.bodyMedium.copyWith(color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight), textAlign: TextAlign.center)],
      if (actionLabel != null && onAction != null) ...[const SizedBox(height: AppSpacing.xl),
        D2YButton(text: actionLabel!, onPressed: onAction, isFullWidth: false, size: D2YButtonSize.medium)],
    ])));
  }
}

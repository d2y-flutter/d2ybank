import 'package:flutter/material.dart';
import '../../../core/config/app_colors.dart';
import '../../../core/config/app_spacing.dart';
import '../../../core/config/app_text_styles.dart';

class D2YLoading extends StatelessWidget {
  final String? message;
  final bool overlay;
  const D2YLoading({super.key, this.message, this.overlay = false});
  const D2YLoading.overlay({super.key, this.message}) : overlay = true;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    Widget indicator = const SizedBox(width: 32, height: 32,
      child: CircularProgressIndicator(strokeWidth: 3, strokeCap: StrokeCap.round));
    if (message != null) {
      indicator = Column(mainAxisSize: MainAxisSize.min, children: [
        indicator, const SizedBox(height: AppSpacing.md),
        Text(message!, style: AppTextStyles.bodyMedium.copyWith(
          color: isDark ? AppColors.secondary : AppColors.secondaryContainer), textAlign: TextAlign.center),
      ]);
    }
    if (overlay) return Container(color: isDark ? AppColors.outlineVariant : AppColors.onSurfaceVariant, child: Center(child: indicator));
    return Center(child: indicator);
  }
}

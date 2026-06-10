import 'package:flutter/material.dart';
import '../../../core/config/app_colors.dart';
import '../../../core/config/app_radius.dart';
import '../../../core/config/app_spacing.dart';
import '../../../core/config/app_text_styles.dart';
import '../../../core/config/app_duration.dart';

enum D2YToastType { success, error, warning, info }

class D2YToast {
  D2YToast._();
  static void show(BuildContext context, {required String message, D2YToastType type = D2YToastType.info}) {
    final (Color bg, Color fg, IconData icon) = switch (type) {
      D2YToastType.success => (AppColors.success, AppColors.white, Icons.check_circle_rounded),
      D2YToastType.error => (AppColors.error, AppColors.white, Icons.error_rounded),
      D2YToastType.warning => (AppColors.warning, AppColors.onPrimary, Icons.warning_rounded),
      D2YToastType.info => (AppColors.onPrimary, AppColors.white, Icons.info_rounded),
    };
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Row(children: [Icon(icon, color: fg, size: 20), const SizedBox(width: AppSpacing.xs),
        Expanded(child: Text(message, style: AppTextStyles.bodyMedium.copyWith(color: fg), maxLines: 2, overflow: TextOverflow.ellipsis))]),
      backgroundColor: bg, behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.sm)),
      margin: const EdgeInsets.all(AppSpacing.md), duration: AppDuration.snackbar));
  }
  static void success(BuildContext context, String msg) => show(context, message: msg, type: D2YToastType.success);
  static void error(BuildContext context, String msg) => show(context, message: msg, type: D2YToastType.error);
}

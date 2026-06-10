import 'package:d2ybank/core/config/app_colors.dart';
import 'package:d2ybank/core/config/app_spacing.dart';
import 'package:d2ybank/core/config/app_text_styles.dart';
import 'package:flutter/material.dart';

class BiometricHeader extends StatelessWidget {
  final String label;

  const BiometricHeader({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Aktifkan Biometrik',
          textAlign: TextAlign.center,
          style: AppTextStyles.displaySmall.copyWith(
            color: AppColors.onSurface,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          'Gunakan $label untuk masuk dan bertransaksi lebih cepat dan aman.',
          textAlign: TextAlign.center,
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.onSurfaceVariant,
            height: 1.55,
          ),
        ),
      ],
    );
  }
}
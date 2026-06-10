import 'package:d2ybank/core/config/app_colors.dart';
import 'package:d2ybank/core/config/app_icon_size.dart';
import 'package:d2ybank/core/config/app_spacing.dart';
import 'package:d2ybank/core/config/app_text_styles.dart';
import 'package:d2ybank/shared/components/buttons/d2y_button.dart';
import 'package:flutter/material.dart';

import 'registration_success_features.dart';
import 'registration_success_icon.dart';

class RegistrationSuccessCard extends StatelessWidget {
  final VoidCallback onEnterDashboard;

  const RegistrationSuccessCard({
    super.key,
    required this.onEnterDashboard,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: AppColors.outlineVariant.withValues(alpha: 0.20),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.08),
            blurRadius: 32,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: Column(
        children: [
          const RegistrationSuccessIcon(),
          const SizedBox(height: AppSpacing.xl),
          Text(
            'Registrasi Berhasil!',
            textAlign: TextAlign.center,
            style: AppTextStyles.displaySmall.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Selamat! Akun d2ybank Anda telah aktif. Sekarang Anda dapat menikmati semua fitur perbankan premium kami.',
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.onSurfaceVariant,
              height: 1.55,
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          const RegistrationSuccessFeatures(),
          const SizedBox(height: AppSpacing.xl),
          D2YButton(
            text: 'Masuk ke Dashboard',
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.onPrimary,
            suffixIcon: const Icon(
              Icons.arrow_forward_rounded,
              color: AppColors.onPrimary,
              size: AppIconSize.sm,
            ),
            onPressed: onEnterDashboard,
          ),
          const SizedBox(height: AppSpacing.md),
          Text.rich(
            TextSpan(
              text: 'Butuh bantuan? ',
              style: AppTextStyles.labelLarge.copyWith(
                color: AppColors.onSurfaceVariant,
              ),
              children: [
                TextSpan(
                  text: 'Pusat Bantuan',
                  style: AppTextStyles.labelLarge.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
import 'package:d2ybank/core/config/app_colors.dart';
import 'package:d2ybank/core/config/app_spacing.dart';
import 'package:d2ybank/core/config/app_text_styles.dart';
import 'package:flutter/material.dart';

class KycHeader extends StatelessWidget {
  const KycHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Konfirmasi Data Diri',
          style: AppTextStyles.displaySmall.copyWith(
            color: AppColors.onSurface,
            fontSize: 32,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.4,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          'Periksa kembali data yang berhasil kami ekstrak dari KTP Anda. Klik pada kolom untuk mengubah jika ada kesalahan.',
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.onSurfaceVariant,
            height: 1.55,
          ),
        ),
      ],
    );
  }
}
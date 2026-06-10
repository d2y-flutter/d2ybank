import 'dart:ui';

import 'package:d2ybank/core/config/app_colors.dart';
import 'package:d2ybank/core/config/app_radius.dart';
import 'package:d2ybank/core/config/app_spacing.dart';
import 'package:d2ybank/core/config/app_text_styles.dart';
import 'package:flutter/material.dart';

class BiometricSecurityCard extends StatelessWidget {
  const BiometricSecurityCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadius.xl),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.lg),
          decoration: BoxDecoration(
            color: AppColors.white.withValues(alpha: 0.70),
            borderRadius: BorderRadius.circular(AppRadius.xl),
            border: Border.all(
              color: AppColors.outlineVariant.withValues(alpha: 0.30),
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.05),
                blurRadius: 20,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(AppSpacing.sm),
                decoration: BoxDecoration(
                  color: AppColors.primaryFixed.withValues(alpha: 0.20),
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                ),
                child: const Icon(
                  Icons.security_rounded,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Data Anda Terenkripsi',
                      style: AppTextStyles.labelLarge.copyWith(
                        color: AppColors.onSurface,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      'Biometrik Anda aman dan hanya disimpan di dalam perangkat ini. Kami tidak pernah mengirimkannya ke server kami.',
                      style: AppTextStyles.labelSmall.copyWith(
                        color: AppColors.onSurfaceVariant,
                        height: 1.45,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
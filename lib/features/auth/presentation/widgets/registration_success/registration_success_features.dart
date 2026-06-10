import 'package:d2ybank/core/config/app_colors.dart';
import 'package:d2ybank/core/config/app_radius.dart';
import 'package:d2ybank/core/config/app_spacing.dart';
import 'package:d2ybank/core/config/app_text_styles.dart';
import 'package:flutter/material.dart';

class RegistrationSuccessFeatures extends StatelessWidget {
  const RegistrationSuccessFeatures({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(
          child: _FeatureCard(
            icon: Icons.verified_user_rounded,
            label: 'Terverifikasi',
            iconColor: AppColors.primary,
            backgroundColor: Color(0x0D003527),
          ),
        ),
        SizedBox(width: AppSpacing.sm),
        Expanded(
          child: _FeatureCard(
            icon: Icons.diamond_rounded,
            label: 'Akses Premium',
            iconColor: AppColors.secondary,
            backgroundColor: AppColors.surfaceContainerLow,
          ),
        ),
      ],
    );
  }
}

class _FeatureCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color iconColor;
  final Color backgroundColor;

  const _FeatureCard({
    required this.icon,
    required this.label,
    required this.iconColor,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        border: Border.all(
          color: AppColors.outlineVariant.withValues(alpha: 0.10),
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: iconColor,
            size: 28,
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            label,
            textAlign: TextAlign.center,
            style: AppTextStyles.labelSmall.copyWith(
              color: AppColors.onSurface,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}
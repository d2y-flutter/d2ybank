import 'package:d2ybank/core/config/app_colors.dart';
import 'package:d2ybank/core/config/app_radius.dart';
import 'package:d2ybank/core/config/app_spacing.dart';
import 'package:d2ybank/core/config/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class KtpPreviewSection extends StatelessWidget {
  const KtpPreviewSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerLow,
            borderRadius: BorderRadius.circular(AppRadius.xl),
          ),
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: 3 / 2,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(
                        'https://images.unsplash.com/photo-1601597111158-2fceff292cdc?q=80&w=1200&auto=format&fit=crop',
                        fit: BoxFit.cover,
                        color: AppColors.primary.withValues(alpha: 0.12),
                        colorBlendMode: BlendMode.overlay,
                        errorBuilder: (_, __, ___) {
                          return Container(
                            color: AppColors.surfaceContainer,
                            child: const Icon(
                              Icons.badge_rounded,
                              color: AppColors.primary,
                              size: 52,
                            ),
                          );
                        },
                      ),
                      Container(
                        color: AppColors.primary.withValues(alpha: 0.10),
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.verified_user_rounded,
                          color: AppColors.white,
                          size: 42,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'Scan KTP Berhasil',
                style: AppTextStyles.labelSmall.copyWith(
                  color: AppColors.onSurfaceVariant,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              TextButton.icon(
                onPressed: () => context.pop(),
                icon: const Icon(Icons.refresh_rounded, size: 16),
                label: const Text('Ulangi Foto'),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: AppColors.primaryContainer,
            borderRadius: BorderRadius.circular(AppRadius.xl),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.info_rounded,
                color: AppColors.onPrimaryContainer,
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Keamanan Data',
                      style: AppTextStyles.labelLarge.copyWith(
                        color: AppColors.onPrimaryContainer,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      'Data Anda dilindungi oleh enkripsi tingkat tinggi sesuai standar OJK.',
                      style: AppTextStyles.labelSmall.copyWith(
                        color: AppColors.onPrimaryContainer.withValues(alpha: 0.90),
                        height: 1.45,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
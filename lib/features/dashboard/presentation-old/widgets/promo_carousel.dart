import 'package:flutter/material.dart';
import 'package:d2ybank/core/config/app_colors.dart';
import 'package:d2ybank/core/config/app_text_styles.dart';
import 'package:d2ybank/core/config/app_spacing.dart';
import 'package:d2ybank/core/config/app_radius.dart';
import '../../domain/entities/dashboard_entities.dart';

/// Full-bleed horizontal promo carousel from HTML "Eksklusif Untuk Anda".
/// Design doc: full roundedness (9999px) for category chips = StadiumBorder.
class PromoCarousel extends StatelessWidget {
  final List<PromoEntity> promos;

  const PromoCarousel({super.key, required this.promos});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 240,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
        itemCount: promos.length,
        separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.md),
        itemBuilder: (context, index) => _PromoCard(promo: promos[index]),
      ),
    );
  }
}

class _PromoCard extends StatelessWidget {
  final PromoEntity promo;

  const _PromoCard({required this.promo});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.xxl),
        boxShadow: [
          BoxShadow(
            color: promo.overlayColor.withValues(alpha: 0.2),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadius.xxl),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Background color
            Container(color: promo.overlayColor),
            // Image
            Opacity(
              opacity: 0.7,
              child: Image.network(
                promo.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const SizedBox.shrink(),
              ),
            ),
            // Content overlay
            Padding(
              padding: const EdgeInsets.all(AppSpacing.xxl),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Category pill — full roundedness per design doc
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: promo.category == 'KULINER'
                          ? AppColors.secondary
                          : AppColors.primary,
                      borderRadius: BorderRadius.circular(AppRadius.full),
                    ),
                    child: Text(
                      promo.category,
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: AppColors.white,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                  // Text
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        promo.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.headlineMedium.copyWith(
                          color: AppColors.white,
                          fontWeight: FontWeight.w700,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        promo.subtitle,
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.surfaceContainerHighest.withValues(alpha: 0.8),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
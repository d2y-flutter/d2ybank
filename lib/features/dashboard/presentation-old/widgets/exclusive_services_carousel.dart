import 'package:flutter/material.dart';
import 'package:d2ybank/core/config/app_colors.dart';
import 'package:d2ybank/core/config/app_text_styles.dart';
import 'package:d2ybank/core/config/app_spacing.dart';
import 'package:d2ybank/core/config/app_radius.dart';
import '../../domain/entities/dashboard_entities.dart';

/// Horizontal scroll carousel from the HTML "Layanan Eksklusif" section.
/// No border — tonal shift (white card on surface bg). Design doc rule.
class ExclusiveServicesCarousel extends StatelessWidget {
  final List<ExclusiveServiceEntity> services;

  const ExclusiveServicesCarousel({super.key, required this.services});

  static IconData _resolveIcon(String name) {
    return switch (name) {
      'diamond' => Icons.diamond_rounded,
      'flight_takeoff' => Icons.flight_takeoff_rounded,
      'support_agent' => Icons.support_agent_rounded,
      _ => Icons.star_rounded,
    };
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
        itemCount: services.length,
        separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.md),
        itemBuilder: (context, index) {
          final service = services[index];
          return _ServiceCard(service: service, icon: _resolveIcon(service.iconName));
        },
      ),
    );
  }
}

class _ServiceCard extends StatelessWidget {
  final ExclusiveServiceEntity service;
  final IconData icon;

  const _ServiceCard({required this.service, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppRadius.xxl),
        // No border — tonal shift is the boundary
        border: Border.all(
          color: AppColors.outlineVariant.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: service.badge != null
                      ? AppColors.secondary.withValues(alpha: 0.05)
                      : AppColors.primary.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                ),
                child: Icon(
                  icon,
                  color: service.badge != null ? AppColors.secondary : AppColors.primary,
                  size: 28,
                ),
              ),
              // Badge
              if (service.badge != null)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.secondaryContainer.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(AppRadius.full),
                    border: Border.all(
                      color: AppColors.secondary.withValues(alpha: 0.1),
                    ),
                  ),
                  child: Text(
                    service.badge!.toUpperCase(),
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 9,
                      fontWeight: FontWeight.w800,
                      color: AppColors.onSecondaryFixedVariant,
                      letterSpacing: 2,
                    ),
                  ),
                ),
            ],
          ),
          const Spacer(),
          Text(
            service.title,
            style: AppTextStyles.titleLarge.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w700,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            service.description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.onSurfaceVariant,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
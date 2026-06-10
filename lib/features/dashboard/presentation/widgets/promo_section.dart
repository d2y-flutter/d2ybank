import 'package:flutter/material.dart';

import '../../domain/entities/dashboard_entities.dart';
import 'dashboard_promo_mapper.dart';
import 'dashboard_section_header.dart';
import 'dashboard_ui_tokens.dart';
import 'promo_card.dart';

class PromoSection extends StatelessWidget {
  const PromoSection({
    required this.promos,
    this.onSeeAllTap,
    this.onPromoTap,
    super.key,
  });

  final List<PromoEntity> promos;
  final VoidCallback? onSeeAllTap;
  final ValueChanged<PromoEntity>? onPromoTap;

  @override
  Widget build(BuildContext context) {
    if (promos.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: DashboardUiTokens.marginMobile,
          ),
          child: DashboardSectionHeader(
            title: 'Promo Menarik',
            actionLabel: 'Lihat Semua',
            onActionTap: onSeeAllTap,
          ),
        ),
        const SizedBox(height: DashboardUiTokens.gapMd),
        SizedBox(
          height: 166,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(
              horizontal: DashboardUiTokens.marginMobile,
            ),
            itemCount: promos.length,
            separatorBuilder: (_, __) =>
                const SizedBox(width: DashboardUiTokens.gapMd),
            itemBuilder: (context, index) {
              final promo = promos[index];
              return PromoCard(
                title: DashboardPromoMapper.title(promo, index),
                badge: DashboardPromoMapper.badge(promo, index),
                imageUrl: DashboardPromoMapper.imageUrl(promo, index),
                onTap: () => onPromoTap?.call(promo),
              );
            },
          ),
        ),
      ],
    );
  }
}

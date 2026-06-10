import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'dashboard_ui_tokens.dart';

class PromoCard extends StatelessWidget {
  const PromoCard({
    required this.title,
    required this.badge,
    required this.imageUrl,
    this.onTap,
    super.key,
  });

  final String title;
  final String badge;
  final String imageUrl;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280,
      height: 160,
      child: Material(
        color: Colors.white,
        borderRadius: DashboardUiTokens.radiusLg,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Stack(
            fit: StackFit.expand,
            children: [
              CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
                placeholder: (_, __) => const ColoredBox(
                  color: DashboardUiTokens.surfaceContainerHigh,
                ),
                errorWidget: (_, __, ___) => const Center(
                  child: Icon(
                    Icons.image_not_supported_rounded,
                    color: DashboardUiTokens.onSurfaceVariant,
                  ),
                ),
              ),
              const DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Color(0xCC000000),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 16,
                right: 16,
                bottom: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: DashboardUiTokens.secondaryContainer,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        badge.toUpperCase(),
                        style: const TextStyle(
                          fontFamily: 'DMSans',
                          fontSize: 10,
                          height: 1.2,
                          fontWeight: FontWeight.w800,
                          color: DashboardUiTokens.onSecondaryContainer,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                    const SizedBox(height: DashboardUiTokens.gapXs),
                    Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontFamily: 'DMSans',
                        fontSize: 14,
                        height: 1.35,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
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

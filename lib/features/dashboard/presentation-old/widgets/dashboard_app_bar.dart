import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:d2ybank/core/config/app_colors.dart';
import 'package:d2ybank/core/config/app_text_styles.dart';

/// Glassmorphism app bar: white/60% opacity + backdrop blur.
/// Design doc: "Glass & Gradient" rule.
class DashboardAppBar extends StatelessWidget {
  const DashboardAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      snap: true,
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: Colors.transparent,
      flexibleSpace: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.white.withValues(alpha: 0.6),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.06),
                  blurRadius: 60,
                  offset: const Offset(0, 40),
                ),
              ],
            ),
          ),
        ),
      ),
      title: Row(
        children: [
          // Avatar
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.outlineVariant.withValues(alpha: 0.5),
              ),
            ),
            child: ClipOval(
              child: Image.network(
                'https://i.pravatar.cc/80?u=rizky',
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: AppColors.surfaceContainerLow,
                  child: Icon(Icons.person, color: AppColors.outline, size: 20),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            'd2ybank',
            style: AppTextStyles.titleLarge.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.8,
              fontSize: 20,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.settings_outlined,
            color: AppColors.primary,
            size: 22,
          ),
        ),
        const SizedBox(width: 8),
      ],
    );
  }
}
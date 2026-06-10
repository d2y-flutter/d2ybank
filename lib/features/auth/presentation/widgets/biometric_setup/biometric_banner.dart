import 'package:d2ybank/core/config/app_colors.dart';
import 'package:flutter/material.dart';

class BiometricBanner extends StatelessWidget {
  const BiometricBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primary.withValues(alpha: 0.06),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.08),
                  blurRadius: 80,
                  spreadRadius: 20,
                ),
              ],
            ),
          ),
          Container(
            width: 168,
            height: 168,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: AppColors.primaryGradient,
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.22),
                  blurRadius: 36,
                  offset: const Offset(0, 18),
                ),
              ],
            ),
            child: const Icon(
              Icons.fingerprint_rounded,
              color: AppColors.onPrimary,
              size: 92,
            ),
          ),
        ],
      ),
    );
  }
}
import 'package:d2ybank/core/config/app_colors.dart';
import 'package:d2ybank/core/config/app_radius.dart';
import 'package:flutter/material.dart';

class PasswordBanner extends StatelessWidget {
  const PasswordBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadius.xl),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              'https://images.unsplash.com/photo-1563986768494-4dee2763ff3f?q=80&w=1200&auto=format&fit=crop',
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) {
                return Container(
                  color: AppColors.primaryContainer,
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.lock_rounded,
                    color: AppColors.white,
                    size: 56,
                  ),
                );
              },
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
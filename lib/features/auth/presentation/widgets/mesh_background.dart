import 'package:flutter/material.dart';
import 'package:d2ybank/core/config/app_colors.dart';

/// Decorative mesh gradient background from the HTML reference.
/// Radial gradients at corners creating depth atmosphere.
class MeshBackground extends StatelessWidget {
  const MeshBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return const Positioned.fill(
      child: IgnorePointer(
        child: _MeshPainter(),
      ),
    );
  }
}

class _MeshPainter extends StatelessWidget {
  const _MeshPainter();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        // Top-right blob — primary tint
        Positioned(
          top: -size.height * 0.15,
          right: -size.width * 0.15,
          child: Container(
            width: size.width * 0.6,
            height: size.width * 0.6,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  AppColors.primary.withValues(alpha: 0.05),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
        // Bottom-left blob — secondary tint
        Positioned(
          bottom: -size.height * 0.15,
          left: -size.width * 0.15,
          child: Container(
            width: size.width * 0.6,
            height: size.width * 0.6,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  AppColors.secondaryFixed.withValues(alpha: 0.1),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
        // Subtle top-left primary wash
        Positioned(
          top: 0,
          left: 0,
          child: Container(
            width: size.width * 0.5,
            height: size.height * 0.4,
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.topLeft,
                radius: 1,
                colors: [
                  AppColors.primary.withValues(alpha: 0.03),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
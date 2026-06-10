import 'dart:ui';

import 'package:d2ybank/core/config/app_colors.dart';
import 'package:flutter/material.dart';

class PinAmbientBackground extends StatelessWidget {
  const PinAmbientBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: -80,
          right: -70,
          child: _BlurCircle(
            size: 260,
            color: AppColors.primaryContainer.withValues(alpha: 0.18),
          ),
        ),
        Positioned(
          bottom: -100,
          left: -80,
          child: _BlurCircle(
            size: 320,
            color: AppColors.secondaryContainer.withValues(alpha: 0.10),
          ),
        ),
      ],
    );
  }
}

class _BlurCircle extends StatelessWidget {
  final double size;
  final Color color;

  const _BlurCircle({
    required this.size,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ImageFiltered(
      imageFilter: ImageFilter.blur(sigmaX: 90, sigmaY: 90),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
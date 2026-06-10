import 'package:d2ybank/core/config/app_colors.dart';
import 'package:d2ybank/core/config/app_radius.dart';
import 'package:d2ybank/core/config/app_spacing.dart';
import 'package:flutter/material.dart';

class RegistrationSuccessIcon extends StatefulWidget {
  const RegistrationSuccessIcon({super.key});

  @override
  State<RegistrationSuccessIcon> createState() => _RegistrationSuccessIconState();
}

class _RegistrationSuccessIconState extends State<RegistrationSuccessIcon>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _floatAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    )..repeat(reverse: true);

    _floatAnimation = Tween<double>(
      begin: 0,
      end: -10,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _floatAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _floatAnimation.value),
          child: child,
        );
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 184,
            height: 184,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primaryContainer.withValues(alpha: 0.14),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primaryContainer.withValues(alpha: 0.18),
                  blurRadius: 60,
                  spreadRadius: 12,
                ),
              ],
            ),
          ),
          
          Container(
            width: 128,
            height: 128,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primary,
              border: Border.all(
                color: AppColors.surfaceContainerLowest,
                width: 4,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.24),
                  blurRadius: 28,
                  offset: const Offset(0, 12),
                ),
              ],
            ),
            child: const Icon(
              Icons.check_rounded,
              color: AppColors.onPrimary,
              size: 78,
            ),
          ),
        ],
      ),
    );
  }
}
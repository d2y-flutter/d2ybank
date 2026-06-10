import 'dart:math' as math;

import 'package:d2ybank/core/services/app_startup_gate.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/navigation/route_paths.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  final AppStartupGate _startupGate = AppStartupGate();

  late final AnimationController _introController;
  late final AnimationController _floatController;
  late final AnimationController _progressController;

  late final Animation<double> _fadeAnimation;
  late final Animation<double> _scaleAnimation;
  late final Animation<Offset> _taglineSlideAnimation;

  bool _isLogoPressed = false;

  @override
  void initState() {
    super.initState();

    _introController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );

    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2800),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _introController,
      curve: Curves.easeOut,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.88,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _introController,
        curve: Curves.easeOutBack,
      ),
    );

    _taglineSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.45),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _introController,
        curve: const Interval(
          0.45,
          1,
          curve: Curves.easeOutCubic,
        ),
      ),
    );

    _introController.forward();
    _floatController.repeat();
    _progressController.forward();

    _navigateAfterSplash();
  }

  Future<void> _navigateAfterSplash() async {
    await Future<void>.delayed(const Duration(milliseconds: 3000));

    final destination = await _startupGate.resolveDestination();

    if (!mounted) return;

    switch (destination) {
      case AppStartupDestination.onboarding:
        context.go(RoutePaths.onboarding);
        break;
      case AppStartupDestination.home:
        context.go(RoutePaths.home);
        break;
      case AppStartupDestination.login:
        context.go(RoutePaths.login);
        break;
    }
  }

  @override
  void dispose() {
    _introController.dispose();
    _floatController.dispose();
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _SplashTokens.surfaceLowest,
      body: Stack(
        fit: StackFit.expand,
        children: [
          const _SplashBackground(),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: _SplashTokens.marginMobile,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 430),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Center(child: _buildBrandSection()),
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 48,
                        child: _SplashLoadingArea(
                          progressAnimation: _progressController,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBrandSection() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: AnimatedBuilder(
        animation: Listenable.merge([_introController, _floatController]),
        builder: (context, child) {
          final floatDy = -5 *
              (1 - math.cos(_floatController.value * math.pi * 2));

          return Transform.translate(
            offset: Offset(0, floatDy),
            child: Transform.scale(
              scale: _scaleAnimation.value,
              child: child,
            ),
          );
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _AnimatedLogo(
              controller: _floatController,
              isPressed: _isLogoPressed,
              onTapDown: () => setState(() => _isLogoPressed = true),
              onTapCancel: () => setState(() => _isLogoPressed = false),
              onTapUp: () => setState(() => _isLogoPressed = false),
            ),
            const SizedBox(height: _SplashTokens.spaceLg),
            const _BrandTitle(),
            const SizedBox(height: _SplashTokens.spaceXs),
            SlideTransition(
              position: _taglineSlideAnimation,
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: const Text(
                  'Secure Digital Wealth',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'DMSans',
                    fontSize: 14,
                    height: 20 / 14,
                    letterSpacing: 0.14,
                    fontWeight: FontWeight.w500,
                    color: _SplashTokens.onSurfaceVariant,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SplashBackground extends StatelessWidget {
  const _SplashBackground();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [
                _SplashTokens.surfaceLow.withOpacity(0.72),
                Colors.white.withOpacity(0.92),
              ],
            ),
          ),
          child: const SizedBox.expand(),
        ),
        Positioned(
          top: -92,
          right: -92,
          child: _BlurredCircle(
            size: 260,
            color: _SplashTokens.primaryContainer.withOpacity(0.08),
          ),
        ),
        Positioned(
          bottom: -96,
          left: -96,
          child: _BlurredCircle(
            size: 260,
            color: _SplashTokens.secondaryContainer.withOpacity(0.10),
          ),
        ),
      ],
    );
  }
}

class _BlurredCircle extends StatelessWidget {
  const _BlurredCircle({
    required this.size,
    required this.color,
  });

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        boxShadow: [
          BoxShadow(
            color: color,
            blurRadius: 72,
            spreadRadius: 32,
          ),
        ],
      ),
      child: SizedBox.square(dimension: size),
    );
  }
}

class _AnimatedLogo extends StatelessWidget {
  const _AnimatedLogo({
    required this.controller,
    required this.isPressed,
    required this.onTapDown,
    required this.onTapCancel,
    required this.onTapUp,
  });

  final AnimationController controller;
  final bool isPressed;
  final VoidCallback onTapDown;
  final VoidCallback onTapCancel;
  final VoidCallback onTapUp;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: 112,
      child: Stack(
        alignment: Alignment.center,
        children: [
          _PulseRing(controller: controller),
          GestureDetector(
            onTapDown: (_) => onTapDown(),
            onTapCancel: onTapCancel,
            onTapUp: (_) => onTapUp(),
            child: AnimatedScale(
              scale: isPressed ? 0.90 : 1,
              duration: const Duration(milliseconds: 120),
              curve: Curves.easeOut,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _SplashTokens.primary,
                  border: Border.all(
                    color: _SplashTokens.secondaryContainer,
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: _SplashTokens.primary.withOpacity(0.24),
                      blurRadius: 28,
                      offset: const Offset(0, 12),
                    ),
                  ],
                ),
                child: const SizedBox.square(
                  dimension: 80,
                  child: Icon(
                    Icons.account_balance_rounded,
                    color: _SplashTokens.secondaryContainer,
                    size: 40,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PulseRing extends StatelessWidget {
  const _PulseRing({required this.controller});

  final AnimationController controller;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        final progress = (controller.value * 2) % 1;
        final scale = 0.8 + (0.7 * Curves.easeOut.transform(progress));
        final opacity = 0.5 * (1 - progress);

        return Transform.scale(
          scale: scale,
          child: Opacity(
            opacity: opacity.clamp(0, 1),
            child: child,
          ),
        );
      },
      child: Container(
        width: 96,
        height: 96,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: _SplashTokens.secondaryContainer,
            width: 2,
          ),
        ),
      ),
    );
  }
}

class _BrandTitle extends StatelessWidget {
  const _BrandTitle();

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: const TextSpan(
        style: TextStyle(
          fontFamily: 'PlusJakartaSans',
          fontSize: 24,
          height: 32 / 24,
          letterSpacing: -0.24,
          fontWeight: FontWeight.w800,
          color: _SplashTokens.primary,
        ),
        children: [
          TextSpan(text: 'd2y'),
          TextSpan(
            text: 'bank',
            style: TextStyle(color: _SplashTokens.secondary),
          ),
        ],
      ),
    );
  }
}

class _SplashLoadingArea extends StatelessWidget {
  const _SplashLoadingArea({
    required this.progressAnimation,
  });

  final Animation<double> progressAnimation;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(999),
          child: SizedBox(
            height: 4,
            child: DecoratedBox(
              decoration: const BoxDecoration(
                color: _SplashTokens.surfaceHigh,
              ),
              child: AnimatedBuilder(
                animation: progressAnimation,
                builder: (context, child) {
                  final progress = Curves.easeInOut.transform(
                    progressAnimation.value,
                  );

                  return Align(
                    alignment: Alignment.centerLeft,
                    child: FractionallySizedBox(
                      widthFactor: progress.clamp(0.02, 1),
                      child: child,
                    ),
                  );
                },
                child: const DecoratedBox(
                  decoration: BoxDecoration(
                    color: _SplashTokens.primary,
                    borderRadius: BorderRadius.all(Radius.circular(999)),
                  ),
                  child: SizedBox.expand(),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: _SplashTokens.spaceSm),
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.lock_rounded,
              size: 14,
              color: _SplashTokens.primary,
            ),
            SizedBox(width: _SplashTokens.spaceXs),
            Text(
              'ENCRYPTED CONNECTION',
              style: TextStyle(
                fontFamily: 'DMSans',
                fontSize: 12,
                height: 16 / 12,
                letterSpacing: 1.6,
                fontWeight: FontWeight.w700,
                color: _SplashTokens.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

abstract final class _SplashTokens {
  static const Color primary = Color(0xFF003527);
  static const Color primaryContainer = Color(0xFF064E3B);
  static const Color secondary = Color(0xFF795900);
  static const Color secondaryContainer = Color(0xFFFFC329);
  static const Color surfaceLowest = Color(0xFFFFFFFF);
  static const Color surfaceLow = Color(0xFFF3F4F5);
  static const Color surfaceHigh = Color(0xFFE7E8E9);
  static const Color onSurfaceVariant = Color(0xFF404944);

  static const double marginMobile = 16;
  static const double spaceXs = 4;
  static const double spaceSm = 8;
  static const double spaceLg = 24;
}

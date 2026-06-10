import 'dart:math' as math;

import 'package:d2ybank/app/navigation/route_paths.dart';
import 'package:d2ybank/core/services/app_startup_gate.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage>
    with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController();
  final AppStartupGate _startupGate = AppStartupGate();

  late final AnimationController _floatController;

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();

    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _floatController.dispose();
    super.dispose();
  }

  Future<void> _nextPage() async {
    if (_currentIndex < 2) {
      await _pageController.nextPage(
        duration: const Duration(milliseconds: 420),
        curve: Curves.easeOutCubic,
      );
      return;
    }

    await _finishOnboarding(RoutePaths.register);
  }

  Future<void> _previousPage() async {
    if (_currentIndex == 0) return;

    await _pageController.previousPage(
      duration: const Duration(milliseconds: 420),
      curve: Curves.easeOutCubic,
    );
  }

  Future<void> _finishOnboarding(String targetPath) async {
    await _startupGate.markOnboardingCompleted();

    if (!mounted) return;
    context.go(targetPath);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _OnboardingTokens.background,
      body: PageView(
        controller: _pageController,
        physics: const BouncingScrollPhysics(),
        onPageChanged: (index) {
          setState(() => _currentIndex = index);
        },
        children: [
          _OnboardingSlide(
            index: 0,
            currentIndex: _currentIndex,
            floatAnimation: _floatController,
            header: const _CenteredBrandHeader(),
            illustration: _PremiumBankingIllustration(
              floatAnimation: _floatController,
            ),
            title: 'Selamat Datang di d2ybank',
            description: 'Solusi perbankan cerdas dalam genggaman Anda.',
            primaryLabel: 'Lanjut',
            secondaryLabel: 'Lewati',
            onPrimaryPressed: _nextPage,
            onSecondaryPressed: () => _finishOnboarding(RoutePaths.login),
          ),
          _OnboardingSlide(
            index: 1,
            currentIndex: _currentIndex,
            floatAnimation: _floatController,
            header: const _LanguageHeader(),
            illustration: _SecureBankingIllustration(
              floatAnimation: _floatController,
            ),
            title: 'Aman & Terpercaya',
            description:
                'Keamanan data dan transaksi Anda adalah prioritas utama kami. Nikmati ketenangan pikiran dalam setiap langkah finansial Anda.',
            primaryLabel: 'Lanjut',
            secondaryLabel: 'Kembali',
            onPrimaryPressed: _nextPage,
            onSecondaryPressed: _previousPage,
            infoCard: const _SecurityInfoCard(),
          ),
          _OnboardingSlide(
            index: 2,
            currentIndex: _currentIndex,
            floatAnimation: _floatController,
            header: const _LanguageHeader(),
            illustration: _InstantRegistrationIllustration(
              floatAnimation: _floatController,
            ),
            title: 'Mulai Sekarang',
            description:
                'Buka rekening hanya dalam hitungan menit tanpa harus ke kantor cabang.',
            primaryLabel: 'Daftar Sekarang',
            secondaryLabel: 'Masuk',
            onPrimaryPressed: () => _finishOnboarding(RoutePaths.register),
            onSecondaryPressed: () => _finishOnboarding(RoutePaths.login),
            showPrimaryArrow: true,
            footerCaption:
                'Terdaftar dan Diawasi oleh Otoritas Jasa Keuangan (OJK)',
          ),
        ],
      ),
    );
  }
}

class _OnboardingSlide extends StatelessWidget {
  const _OnboardingSlide({
    required this.index,
    required this.currentIndex,
    required this.floatAnimation,
    required this.header,
    required this.illustration,
    required this.title,
    required this.description,
    required this.primaryLabel,
    required this.secondaryLabel,
    required this.onPrimaryPressed,
    required this.onSecondaryPressed,
    this.infoCard,
    this.footerCaption,
    this.showPrimaryArrow = false,
  });

  final int index;
  final int currentIndex;
  final Animation<double> floatAnimation;
  final Widget header;
  final Widget illustration;
  final String title;
  final String description;
  final String primaryLabel;
  final String secondaryLabel;
  final VoidCallback onPrimaryPressed;
  final VoidCallback onSecondaryPressed;
  final Widget? infoCard;
  final String? footerCaption;
  final bool showPrimaryArrow;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Positioned.fill(child: _OnboardingBackground()),
        SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: _OnboardingTokens.maxWidth,
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(
                          _OnboardingTokens.marginMobile,
                          10,
                          _OnboardingTokens.marginMobile,
                          18,
                        ),
                        child: Column(
                          children: [
                            header,
                            const SizedBox(height: 18),
                            TweenAnimationBuilder<double>(
                              key: ValueKey('illustration-$index-$currentIndex'),
                              tween: Tween<double>(
                                begin: currentIndex == index ? 0 : 1,
                                end: 1,
                              ),
                              duration: const Duration(milliseconds: 650),
                              curve: Curves.easeOutCubic,
                              builder: (context, value, child) {
                                return Opacity(
                                  opacity: value,
                                  child: Transform.translate(
                                    offset: Offset(0, 24 * (1 - value)),
                                    child: child,
                                  ),
                                );
                              },
                              child: illustration,
                            ),
                            const SizedBox(height: 24),
                            _OnboardingTextContent(
                              title: title,
                              description: description,
                            ),
                            const SizedBox(height: 24),
                            _OnboardingIndicators(activeIndex: index),
                            const SizedBox(height: 28),
                            _OnboardingActions(
                              primaryLabel: primaryLabel,
                              secondaryLabel: secondaryLabel,
                              onPrimaryPressed: onPrimaryPressed,
                              onSecondaryPressed: onSecondaryPressed,
                              showPrimaryArrow: showPrimaryArrow,
                            ),
                            if (infoCard != null) ...[
                              const SizedBox(height: 18),
                              infoCard!,
                            ],
                            if (footerCaption != null) ...[
                              const SizedBox(height: 12),
                              Text(
                                footerCaption!,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'DMSans',
                                  fontSize: 10,
                                  height: 1.3,
                                  color: _OnboardingTokens.outline
                                      .withOpacity(0.72),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _OnboardingBackground extends StatelessWidget {
  const _OnboardingBackground();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const DecoratedBox(
          decoration: BoxDecoration(
            color: _OnboardingTokens.background,
          ),
          child: SizedBox.expand(),
        ),
        Positioned(
          top: -120,
          right: -110,
          child: _AmbientCircle(
            size: 320,
            color: _OnboardingTokens.secondaryContainer.withOpacity(0.15),
            blurRadius: 82,
          ),
        ),
        Positioned(
          bottom: -120,
          left: -110,
          child: _AmbientCircle(
            size: 300,
            color: _OnboardingTokens.primaryContainer.withOpacity(0.10),
            blurRadius: 92,
          ),
        ),
      ],
    );
  }
}

class _AmbientCircle extends StatelessWidget {
  const _AmbientCircle({
    required this.size,
    required this.color,
    required this.blurRadius,
  });

  final double size;
  final Color color;
  final double blurRadius;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: color,
            blurRadius: blurRadius,
            spreadRadius: 34,
          ),
        ],
      ),
      child: SizedBox.square(dimension: size),
    );
  }
}

class _CenteredBrandHeader extends StatelessWidget {
  const _CenteredBrandHeader();

  @override
  Widget build(BuildContext context) {
    return const Center(child: _BrandText());
  }
}

class _LanguageHeader extends StatelessWidget {
  const _LanguageHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        _BrandText(),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'ID',
              style: TextStyle(
                fontFamily: 'DMSans',
                fontSize: 14,
                height: 20 / 14,
                fontWeight: FontWeight.w600,
                color: _OnboardingTokens.onSurfaceVariant,
              ),
            ),
            SizedBox(width: 6),
            Icon(
              Icons.language_rounded,
              size: 20,
              color: _OnboardingTokens.onSurfaceVariant,
            ),
          ],
        ),
      ],
    );
  }
}

class _BrandText extends StatelessWidget {
  const _BrandText();

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: const TextSpan(
        style: TextStyle(
          fontFamily: 'PlusJakartaSans',
          fontSize: 22,
          height: 28 / 22,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.22,
          color: _OnboardingTokens.primary,
        ),
        children: [
          TextSpan(text: 'd2y'),
          TextSpan(
            text: 'bank',
            style: TextStyle(color: _OnboardingTokens.secondary),
          ),
        ],
      ),
    );
  }
}

class _PremiumBankingIllustration extends StatelessWidget {
  const _PremiumBankingIllustration({
    required this.floatAnimation,
  });

  final Animation<double> floatAnimation;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 310,
      child: AnimatedBuilder(
        animation: floatAnimation,
        builder: (context, child) {
          final floatDy = -5 *
              (1 - math.cos(floatAnimation.value * math.pi * 2));

          return Transform.translate(
            offset: Offset(0, floatDy),
            child: child,
          );
        },
        child: Stack(
          alignment: Alignment.center,
          children: const [
            _AmbientCircle(
              size: 220,
              color: Color(0x22FFC329),
              blurRadius: 50,
            ),
            _BankCardBack(),
            _GlassWalletCard(),
          ],
        ),
      ),
    );
  }
}

class _BankCardBack extends StatelessWidget {
  const _BankCardBack();

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: const Offset(-22, 4),
      child: Transform.rotate(
        angle: -0.22,
        child: Container(
          width: 260,
          height: 160,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _OnboardingTokens.primaryContainer,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: _OnboardingTokens.primary.withOpacity(0.25),
                blurRadius: 28,
                offset: const Offset(0, 14),
              ),
            ],
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.contactless_rounded,
                    color: _OnboardingTokens.secondaryFixedDim,
                    size: 28,
                  ),
                  Spacer(),
                  Text(
                    'PREMIUM',
                    style: TextStyle(
                      fontFamily: 'DMSans',
                      fontSize: 13,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w700,
                      color: _OnboardingTokens.primaryFixedDim,
                    ),
                  ),
                ],
              ),
              Spacer(),
              Text(
                'Balance',
                style: TextStyle(
                  fontFamily: 'DMSans',
                  fontSize: 12,
                  color: _OnboardingTokens.primaryFixedDim,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Rp 25.000.000',
                style: TextStyle(
                  fontFamily: 'PlusJakartaSans',
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: _OnboardingTokens.primaryFixedDim,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GlassWalletCard extends StatelessWidget {
  const _GlassWalletCard();

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: const Offset(24, -12),
      child: Transform.rotate(
        angle: 0.12,
        child: Container(
          width: 260,
          height: 160,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.72),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: Colors.white.withOpacity(0.7)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.13),
                blurRadius: 34,
                offset: const Offset(0, 18),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              Container(
                width: 44,
                height: 44,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: _OnboardingTokens.secondary,
                ),
                child: const Icon(
                  Icons.account_balance_wallet_rounded,
                  color: Colors.white,
                  size: 23,
                ),
              ),
              const SizedBox(height: 16),
              _SkeletonLine(width: 170, opacity: 0.18),
              const SizedBox(height: 8),
              _SkeletonLine(width: 118, opacity: 0.10),
            ],
          ),
        ),
      ),
    );
  }
}

class _SecureBankingIllustration extends StatelessWidget {
  const _SecureBankingIllustration({
    required this.floatAnimation,
  });

  final Animation<double> floatAnimation;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 310,
      child: Stack(
        alignment: Alignment.center,
        children: [
          _AmbientCircle(
            size: 260,
            color: _OnboardingTokens.primaryFixed.withOpacity(0.28),
            blurRadius: 84,
          ),
          Container(
            width: 264,
            height: 264,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _OnboardingTokens.surfaceLowest,
              boxShadow: [
                BoxShadow(
                  color: _OnboardingTokens.primary.withOpacity(0.08),
                  blurRadius: 44,
                  offset: const Offset(0, 18),
                ),
              ],
            ),
            child: Stack(
              alignment: Alignment.center,
              children: const [
                Icon(
                  Icons.security_rounded,
                  size: 126,
                  color: _OnboardingTokens.primaryContainer,
                ),
                Positioned(
                  bottom: 70,
                  right: 72,
                  child: Icon(
                    Icons.paid_rounded,
                    size: 42,
                    color: _OnboardingTokens.secondaryContainer,
                  ),
                ),
              ],
            ),
          ),
          AnimatedBuilder(
            animation: floatAnimation,
            builder: (context, child) {
              final floatDy = -5 *
                  (1 - math.cos(floatAnimation.value * math.pi * 2));

              return Positioned(
                right: 24,
                bottom: 16 + floatDy,
                child: child!,
              );
            },
            child: const _SecurityBadge(),
          ),
        ],
      ),
    );
  }
}

class _SecurityBadge extends StatelessWidget {
  const _SecurityBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.74),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.65)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.10),
            blurRadius: 22,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.verified_user_rounded,
            color: _OnboardingTokens.primary,
            size: 22,
          ),
          SizedBox(width: 8),
          Text(
            'E2E Encrypted',
            style: TextStyle(
              fontFamily: 'DMSans',
              fontSize: 14,
              fontWeight: FontWeight.w800,
              color: _OnboardingTokens.primary,
            ),
          ),
        ],
      ),
    );
  }
}

class _InstantRegistrationIllustration extends StatelessWidget {
  const _InstantRegistrationIllustration({
    required this.floatAnimation,
  });

  final Animation<double> floatAnimation;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 320,
      child: Stack(
        alignment: Alignment.center,
        children: [
          _AmbientCircle(
            size: 250,
            color: _OnboardingTokens.secondary.withOpacity(0.10),
            blurRadius: 70,
          ),
          Positioned(
            left: 8,
            top: 94,
            child: Transform.rotate(
              angle: -0.12,
              child: Container(
                width: 128,
                height: 78,
                decoration: BoxDecoration(
                  color: _OnboardingTokens.secondaryFixed,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: _OnboardingTokens.secondary.withOpacity(0.14),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: _OnboardingTokens.secondary.withOpacity(0.18),
                      blurRadius: 18,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.bolt_rounded,
                  size: 42,
                  color: _OnboardingTokens.onSecondaryFixed,
                ),
              ),
            ),
          ),
          Transform.rotate(
            angle: 0.05,
            child: Container(
              width: 232,
              height: 286,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(32),
                border: Border.all(
                  color: _OnboardingTokens.outlineVariant.withOpacity(0.36),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.14),
                    blurRadius: 32,
                    offset: const Offset(0, 18),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    width: 84,
                    height: 5,
                    decoration: BoxDecoration(
                      color: _OnboardingTokens.surfaceHigh,
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                  const SizedBox(height: 18),
                  const Icon(
                    Icons.check_circle_rounded,
                    color: _OnboardingTokens.primaryContainer,
                    size: 62,
                  ),
                  const SizedBox(height: 18),
                  _SkeletonLine(width: 150, opacity: 0.16),
                  const SizedBox(height: 10),
                  _SkeletonLine(width: 118, opacity: 0.10),
                  const Spacer(),
                  Container(
                    height: 44,
                    decoration: BoxDecoration(
                      color: _OnboardingTokens.primary,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      'Verifikasi Berhasil',
                      style: TextStyle(
                        fontFamily: 'DMSans',
                        fontWeight: FontWeight.w800,
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          AnimatedBuilder(
            animation: floatAnimation,
            builder: (context, child) {
              final floatDy = -5 *
                  (1 - math.cos(floatAnimation.value * math.pi * 2));

              return Positioned(
                left: 46,
                right: 46,
                bottom: 10 + floatDy,
                child: child!,
              );
            },
            child: const _KycBadge(),
          ),
        ],
      ),
    );
  }
}

class _KycBadge extends StatelessWidget {
  const _KycBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.74),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white.withOpacity(0.65)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 22,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: const Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: _OnboardingTokens.primary,
            child: Icon(
              Icons.verified_user_rounded,
              color: Colors.white,
              size: 20,
            ),
          ),
          SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Instan ',
                style: TextStyle(
                  fontFamily: 'DMSans',
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  color: _OnboardingTokens.primary,
                ),
              ),
              SizedBox(height: 2),
              Text(
                'KYC ',
                style: TextStyle(
                  fontFamily: 'DMSans',
                  fontSize: 10,
                  color: _OnboardingTokens.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SkeletonLine extends StatelessWidget {
  const _SkeletonLine({
    required this.width,
    required this.opacity,
  });

  final double width;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 8,
      decoration: BoxDecoration(
        color: _OnboardingTokens.onSurfaceVariant.withOpacity(opacity),
        borderRadius: BorderRadius.circular(999),
      ),
    );
  }
}

class _OnboardingTextContent extends StatelessWidget {
  const _OnboardingTextContent({
    required this.title,
    required this.description,
  });

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontFamily: 'PlusJakartaSans',
            fontSize: 24,
            height: 32 / 24,
            letterSpacing: -0.24,
            fontWeight: FontWeight.w800,
            color: _OnboardingTokens.primary,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          description,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontFamily: 'DMSans',
            fontSize: 16,
            height: 24 / 16,
            fontWeight: FontWeight.w400,
            color: _OnboardingTokens.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

class _OnboardingIndicators extends StatelessWidget {
  const _OnboardingIndicators({
    required this.activeIndex,
  });

  final int activeIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        final isActive = index == activeIndex;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 240),
          curve: Curves.easeOut,
          width: isActive ? 32 : 8,
          height: 8,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: isActive
                ? _OnboardingTokens.primary
                : _OnboardingTokens.outlineVariant,
            borderRadius: BorderRadius.circular(999),
          ),
        );
      }),
    );
  }
}

class _OnboardingActions extends StatelessWidget {
  const _OnboardingActions({
    required this.primaryLabel,
    required this.secondaryLabel,
    required this.onPrimaryPressed,
    required this.onSecondaryPressed,
    required this.showPrimaryArrow,
  });

  final String primaryLabel;
  final String secondaryLabel;
  final VoidCallback onPrimaryPressed;
  final VoidCallback onSecondaryPressed;
  final bool showPrimaryArrow;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _ScaleTapButton(
          onPressed: onPrimaryPressed,
          child: Container(
            width: double.infinity,
            height: 56,
            decoration: BoxDecoration(
              color: _OnboardingTokens.primary,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: _OnboardingTokens.primary.withOpacity(0.22),
                  blurRadius: 22,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  primaryLabel,
                  style: const TextStyle(
                    fontFamily: 'DMSans',
                    fontSize: 14,
                    height: 20 / 14,
                    letterSpacing: 0.14,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                if (showPrimaryArrow) ...[
                  const SizedBox(width: 8),
                  const Icon(
                    Icons.arrow_forward_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                ],
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        _ScaleTapButton(
          onPressed: onSecondaryPressed,
          child: Container(
            width: double.infinity,
            height: 56,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: _OnboardingTokens.primary.withOpacity(0.18),
                width: 1.5,
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              secondaryLabel,
              style: const TextStyle(
                fontFamily: 'DMSans',
                fontSize: 14,
                height: 20 / 14,
                letterSpacing: 0.14,
                fontWeight: FontWeight.w800,
                color: _OnboardingTokens.primary,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ScaleTapButton extends StatefulWidget {
  const _ScaleTapButton({
    required this.child,
    required this.onPressed,
  });

  final Widget child;
  final VoidCallback onPressed;

  @override
  State<_ScaleTapButton> createState() => _ScaleTapButtonState();
}

class _ScaleTapButtonState extends State<_ScaleTapButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: _pressed ? 0.98 : 1,
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeOut,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: widget.onPressed,
          onTapDown: (_) => setState(() => _pressed = true),
          onTapCancel: () => setState(() => _pressed = false),
          onTapUp: (_) => setState(() => _pressed = false),
          borderRadius: BorderRadius.circular(16),
          child: widget.child,
        ),
      ),
    );
  }
}

class _SecurityInfoCard extends StatelessWidget {
  const _SecurityInfoCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.74),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.65)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: _OnboardingTokens.secondaryContainer,
            child: Icon(
              Icons.security_rounded,
              color: _OnboardingTokens.onSecondaryContainer,
              size: 22,
            ),
          ),
          SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Standar Perbankan Dunia',
                  style: TextStyle(
                    fontFamily: 'DMSans',
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: _OnboardingTokens.onSurface,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Kami menggunakan enkripsi tingkat lanjut untuk melindungi setiap informasi Anda.',
                  style: TextStyle(
                    fontFamily: 'DMSans',
                    fontSize: 12,
                    height: 16 / 12,
                    color: _OnboardingTokens.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

abstract final class _OnboardingTokens {
  static const double maxWidth = 430;
  static const double marginMobile = 16;

  static const Color primary = Color(0xFF003527);
  static const Color primaryContainer = Color(0xFF064E3B);
  static const Color primaryFixed = Color(0xFFB0F0D6);
  static const Color primaryFixedDim = Color(0xFF95D3BA);

  static const Color secondary = Color(0xFF795900);
  static const Color secondaryContainer = Color(0xFFFFC329);
  static const Color secondaryFixed = Color(0xFFFFDF9F);
  static const Color secondaryFixedDim = Color(0xFFF9BD22);

  static const Color onSecondaryFixed = Color(0xFF261A00);
  static const Color onSecondaryContainer = Color(0xFF6F5100);

  static const Color background = Color(0xFFF8F9FA);
  static const Color surfaceLowest = Color(0xFFFFFFFF);
  static const Color surfaceHigh = Color(0xFFE7E8E9);

  static const Color onSurface = Color(0xFF191C1D);
  static const Color onSurfaceVariant = Color(0xFF404944);
  static const Color outline = Color(0xFF707974);
  static const Color outlineVariant = Color(0xFFBFC9C3);
}

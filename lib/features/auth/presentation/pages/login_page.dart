import 'dart:ui';

import 'package:d2ybank/app/navigation/route_paths.dart';
import 'package:d2ybank/shared/components/buttons/d2y_button.dart';
import 'package:d2ybank/shared/components/inputs/d2y_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:d2ybank/core/config/app_colors.dart';
import 'package:d2ybank/core/config/app_text_styles.dart';
import 'package:d2ybank/core/config/app_spacing.dart';
import 'package:d2ybank/core/config/app_radius.dart';
import 'package:go_router/go_router.dart';

import '../bloc/auth/auth_bloc.dart';
import '../bloc/auth/auth_event.dart';
import '../bloc/auth/auth_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    super.key,
    this.onForgotPassword,
    this.onOpenRegister,
    this.onHelp,
  });

  final VoidCallback? onForgotPassword;
  final VoidCallback? onOpenRegister;
  final VoidCallback? onHelp;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _passwordController = TextEditingController();
  final _passwordFocusNode = FocusNode();

  bool _obscurePassword = true;
  String? _errorText;

  @override
  void dispose() {
    _passwordController.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  void _onLogin() {
    FocusScope.of(context).unfocus();

    setState(() => _errorText = null);

    final password = _passwordController.text.trim();

    if (password.isEmpty) {
      setState(() => _errorText = 'Please enter your password');
      return;
    }

    context.read<AuthBloc>().add(LoginRequested(password: password));
  }

  void _onBiometricLogin() {
    // Sambungkan ke event biometric kamu kalau sudah tersedia.
    // Contoh:
    // context.read<AuthBloc>().add(const BiometricLoginRequested());

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Biometric login belum dihubungkan.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.isFailure && state.failure != null) {
            setState(() => _errorText = state.failure!.message);
          }

          if (state.isAuthenticated) {
            // TODO: Navigate to dashboard.
          }
        },
        child: Stack(
          children: [
            const _LoginBackgroundDecor(),
            const _DesktopPremiumSide(),

            SafeArea(
              child: Column(
                children: [
                  _LoginTopBar(onHelp: widget.onHelp),
                  Expanded(
                    child: Center(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.fromLTRB(
                          AppSpacing.md,
                          AppSpacing.xl,
                          AppSpacing.md,
                          AppSpacing.huge,
                        ),
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 420),
                          child: Column(
                            children: [
                              const _LoginGreeting(),
                              const SizedBox(height: AppSpacing.xxl),

                              _LoginGlassCard(
                                passwordController: _passwordController,
                                passwordFocusNode: _passwordFocusNode,
                                obscurePassword: _obscurePassword,
                                errorText: _errorText,
                                onTogglePasswordVisibility: () {
                                  setState(() {
                                    _obscurePassword = !_obscurePassword;
                                  });
                                },
                                onLogin: _onLogin,
                                onBiometricLogin: _onBiometricLogin,
                                onForgotPassword: widget.onForgotPassword,
                                onOpenRegister: widget.onOpenRegister,
                              ),

                              const SizedBox(height: AppSpacing.xxl),
                              const _LegalFooter(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LoginTopBar extends StatelessWidget {
  const _LoginTopBar({this.onHelp});

  final VoidCallback? onHelp;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'd2ybank',
              style: AppTextStyles.headlineLarge.copyWith(
                color: AppColors.primary,
                fontSize: 22,
                fontWeight: FontWeight.w900,
                letterSpacing: -0.6,
              ),
            ),
            Material(
              color: Colors.transparent,
              shape: const CircleBorder(),
              child: InkWell(
                onTap: onHelp,
                customBorder: const CircleBorder(),
                child: Container(
                  width: 44,
                  height: 44,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primary.withValues(alpha: 0.05),
                  ),
                  child: const Icon(
                    Icons.help_outline_rounded,
                    color: AppColors.primary,
                    size: 24,
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

class _LoginGreeting extends StatelessWidget {
  const _LoginGreeting();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Selamat Datang',
          textAlign: TextAlign.center,
          style: AppTextStyles.displayMedium.copyWith(
            color: AppColors.primary,
            fontSize: 32,
            fontWeight: FontWeight.w800,
            height: 1.15,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          'Silakan masuk ke akun Anda',
          textAlign: TextAlign.center,
          style: AppTextStyles.bodyLarge.copyWith(
            color: AppColors.onSurfaceVariant.withValues(alpha: 0.8),
          ),
        ),
      ],
    );
  }
}

class _LoginGlassCard extends StatelessWidget {
  const _LoginGlassCard({
    required this.passwordController,
    required this.passwordFocusNode,
    required this.obscurePassword,
    required this.errorText,
    required this.onTogglePasswordVisibility,
    required this.onLogin,
    required this.onBiometricLogin,
    this.onForgotPassword,
    this.onOpenRegister,
  });

  final TextEditingController passwordController;
  final FocusNode passwordFocusNode;
  final bool obscurePassword;
  final String? errorText;
  final VoidCallback onTogglePasswordVisibility;
  final VoidCallback onLogin;
  final VoidCallback onBiometricLogin;
  final VoidCallback? onForgotPassword;
  final VoidCallback? onOpenRegister;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(32),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(AppSpacing.xxl),
          decoration: BoxDecoration(
            color: AppColors.white.withValues(alpha: 0.88),
            borderRadius: BorderRadius.circular(32),
            border: Border.all(
              color: AppColors.white.withValues(alpha: 0.85),
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.10),
                blurRadius: 40,
                spreadRadius: -15,
                offset: const Offset(0, 20),
              ),
            ],
          ),
          child: Column(
            children: [
              _LoginPasswordInput(
                controller: passwordController,
                focusNode: passwordFocusNode,
                obscurePassword: obscurePassword,
                errorText: errorText,
                onToggleVisibility: onTogglePasswordVisibility,
                onSubmitted: (_) => onLogin(),
              ),

              const SizedBox(height: AppSpacing.xl),

              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  return _LoginPrimaryActions(
                    isLoading: state.isLoading,
                    onLogin: onLogin,
                    onBiometricLogin: onBiometricLogin,
                  );
                },
              ),

              const SizedBox(height: AppSpacing.xxxl),

              D2YButton.text(
                text: 'Lupa Password?',
                isFullWidth: false,
                foregroundColor: AppColors.primary.withValues(alpha: 0.82),
                onPressed: onForgotPassword,
              ),

              const SizedBox(height: AppSpacing.md),
              const _GradientDivider(),
              const SizedBox(height: AppSpacing.md),

              D2YButton.text(
                text: 'Buka Rekening Baru',
                isFullWidth: false,
                foregroundColor: AppColors.primary,
                prefixIcon: const Icon(
                  Icons.add_circle_rounded,
                  size: 18,
                  color: AppColors.primary,
                ),
                onPressed: () {
                  context.go(RoutePaths.register);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LoginPasswordInput extends StatelessWidget {
  const _LoginPasswordInput({
    required this.controller,
    required this.focusNode,
    required this.obscurePassword,
    required this.errorText,
    required this.onToggleVisibility,
    required this.onSubmitted,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final bool obscurePassword;
  final String? errorText;
  final VoidCallback onToggleVisibility;
  final ValueChanged<String> onSubmitted;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: AppSpacing.xs, bottom: AppSpacing.xs),
          child: Text(
            'PASSWORD',
            style: AppTextStyles.labelMedium.copyWith(
              color: AppColors.primary.withValues(alpha: 0.7),
              fontWeight: FontWeight.w800,
              letterSpacing: 1.4,
            ),
          ),
        ),

        D2YTextField(
          controller: controller,
          focusNode: focusNode,
          hintText: '••••••••',
          errorText: errorText,
          obscureText: obscurePassword,
          keyboardType: TextInputType.visiblePassword,
          textInputAction: TextInputAction.done,
          // onSubmitted: onSubmitted,
          prefixIcon: Icon(
            Icons.lock_rounded,
            color: AppColors.primary.withValues(alpha: 0.40),
          ),
          suffixIcon: IconButton(
            onPressed: onToggleVisibility,
            icon: Icon(
              obscurePassword
                  ? Icons.visibility_rounded
                  : Icons.visibility_off_rounded,
              color: AppColors.primary.withValues(alpha: 0.40),
            ),
          ),
          borderRadius: AppRadius.lg,
          style: AppTextStyles.bodyLarge.copyWith(
            color: AppColors.onSurface,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _LoginPrimaryActions extends StatelessWidget {
  const _LoginPrimaryActions({
    required this.isLoading,
    required this.onLogin,
    required this.onBiometricLogin,
  });

  final bool isLoading;
  final VoidCallback onLogin;
  final VoidCallback onBiometricLogin;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _GradientD2YButton(
            text: 'Masuk',
            isLoading: isLoading,
            onPressed: onLogin,
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        _D2YBiometricButton(onPressed: onBiometricLogin),
      ],
    );
  }
}

class _GradientD2YButton extends StatelessWidget {
  const _GradientD2YButton({
    required this.text,
    required this.onPressed,
    this.isLoading = false,
  });

  final String text;
  final VoidCallback onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.20),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: D2YButton(
        text: text,
        size: D2YButtonSize.large,
        isLoading: isLoading,
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.onPrimary,
        borderRadius: AppRadius.lg,
        suffixIcon: const Icon(
          Icons.arrow_forward_rounded,
          size: 18,
          color: AppColors.onPrimary,
        ),
        onPressed: onPressed,
      ),
    );
  }
}

class _D2YBiometricButton extends StatelessWidget {
  const _D2YBiometricButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(AppRadius.lg),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        child: Ink(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.secondaryFixed,
                AppColors.secondaryFixedDim,
              ],
            ),
            borderRadius: BorderRadius.circular(AppRadius.lg),
            boxShadow: [
              BoxShadow(
                color: AppColors.secondaryFixedDim.withValues(alpha: 0.30),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: const Icon(
            Icons.fingerprint_rounded,
            color: AppColors.onSecondaryFixed,
            size: 32,
          ),
        ),
      ),
    );
  }
}

class _GradientDivider extends StatelessWidget {
  const _GradientDivider();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.transparent,
            AppColors.outlineVariant.withValues(alpha: 0.35),
            Colors.transparent,
          ],
        ),
      ),
    );
  }
}

class _LegalFooter extends StatelessWidget {
  const _LegalFooter();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xxl),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: AppTextStyles.caption.copyWith(
            color: AppColors.onSurfaceVariant.withValues(alpha: 0.60),
            height: 1.55,
          ),
          children: [
            const TextSpan(text: 'Dengan masuk, Anda menyetujui '),
            TextSpan(
              text: 'Syarat & Ketentuan',
              style: AppTextStyles.caption.copyWith(
                color: AppColors.primary.withValues(alpha: 0.75),
                fontWeight: FontWeight.w800,
              ),
            ),
            const TextSpan(text: ' serta '),
            TextSpan(
              text: 'Kebijakan Privasi',
              style: AppTextStyles.caption.copyWith(
                color: AppColors.primary.withValues(alpha: 0.75),
                fontWeight: FontWeight.w800,
              ),
            ),
            const TextSpan(text: ' d2ybank.'),
          ],
        ),
      ),
    );
  }
}

class _LoginBackgroundDecor extends StatelessWidget {
  const _LoginBackgroundDecor();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: -180,
          right: -90,
          child: _BlurBlob(
            width: 360,
            height: 280,
            color: AppColors.primary.withValues(alpha: 0.06),
          ),
        ),
        Positioned(
          bottom: -120,
          left: -90,
          child: _BlurBlob(
            width: 300,
            height: 240,
            color: AppColors.secondaryFixed.withValues(alpha: 0.22),
          ),
        ),
      ],
    );
  }
}

class _BlurBlob extends StatelessWidget {
  const _BlurBlob({
    required this.width,
    required this.height,
    required this.color,
  });

  final double width;
  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ImageFiltered(
      imageFilter: ImageFilter.blur(sigmaX: 90, sigmaY: 90),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(999),
        ),
      ),
    );
  }
}

class _DesktopPremiumSide extends StatelessWidget {
  const _DesktopPremiumSide();

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.sizeOf(context).width >= 1024;

    if (!isDesktop) return const SizedBox.shrink();

    return Align(
      alignment: Alignment.centerRight,
      child: SizedBox(
        width: MediaQuery.sizeOf(context).width * 0.5,
        height: double.infinity,
        child: DecoratedBox(
          decoration: const BoxDecoration(color: AppColors.primary),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.network(
                'https://images.unsplash.com/photo-1563986768609-322da13575f3?q=80&w=1600&auto=format&fit=crop',
                fit: BoxFit.cover,
                color: AppColors.primary.withValues(alpha: 0.58),
                colorBlendMode: BlendMode.overlay,
                errorBuilder: (_, __, ___) {
                  return Container(color: AppColors.primary);
                },
              ),
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: [
                      AppColors.primary,
                      AppColors.primary.withValues(alpha: 0.55),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 64,
                right: 64,
                bottom: 64,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Kendalikan Masa Depan Finansial Anda.',
                      style: AppTextStyles.displayLarge.copyWith(
                        color: AppColors.white,
                        fontSize: 48,
                        height: 1.1,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -1.2,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    Text(
                      'Solusi perbankan cerdas, aman, dan elegan dalam satu genggaman.',
                      style: AppTextStyles.bodyLarge.copyWith(
                        color: AppColors.primaryFixedDim.withValues(alpha: 0.90),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xxxl),
                    const _DesktopTrustStats(),
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

class _DesktopTrustStats extends StatelessWidget {
  const _DesktopTrustStats();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _TrustStat(
          title: '256-bit',
          subtitle: 'Enkripsi Data',
        ),
        Container(
          height: 48,
          width: 1,
          margin: const EdgeInsets.symmetric(horizontal: AppSpacing.xxl),
          color: AppColors.white.withValues(alpha: 0.20),
        ),
        _TrustStat(
          title: '24/7',
          subtitle: 'Dukungan Prioritas',
        ),
      ],
    );
  }
}

class _TrustStat extends StatelessWidget {
  const _TrustStat({
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: AppTextStyles.headlineLarge.copyWith(
            color: AppColors.white,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          subtitle.toUpperCase(),
          style: AppTextStyles.labelSmall.copyWith(
            color: AppColors.primaryFixedDim.withValues(alpha: 0.72),
            fontWeight: FontWeight.w800,
            letterSpacing: 1.5,
          ),
        ),
      ],
    );
  }
}
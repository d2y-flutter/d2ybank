import 'package:d2ybank/app/navigation/route_paths.dart';
import 'package:d2ybank/core/config/app_colors.dart';
import 'package:d2ybank/shared/components/buttons/d2y_button.dart';
import 'package:d2ybank/shared/components/feedback/d2y_toast.dart';
import 'package:d2ybank/shared/components/inputs/d2y_country_phone_field.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/config/app_text_styles.dart';

class RegisterAccountPage extends StatefulWidget {
  final VoidCallback? onBack;
  final VoidCallback? onHelp;
  final ValueChanged<String>? onSendOtp;

  const RegisterAccountPage({
    super.key,
    this.onBack,
    this.onHelp,
    this.onSendOtp,
  });

  @override
  State<RegisterAccountPage> createState() => _RegisterAccountPageState();
}

class _RegisterAccountPageState extends State<RegisterAccountPage> {
  final TextEditingController _phoneController = TextEditingController();
  final FocusNode _phoneFocusNode = FocusNode();

  CountryCodeItem _country = const CountryCodeItem(
    countryName: 'Indonesia',
    flagEmoji: '🇮🇩',
    dialCode: '+62',
  );

  bool _acceptedTerms = false;
  String? _phoneError;
  bool _termsError = false;

  @override
  void dispose() {
    _phoneController.dispose();
    _phoneFocusNode.dispose();
    super.dispose();
  }

  String get _normalizedPhone {
    var phone = _phoneController.text.replaceAll(RegExp(r'\D'), '');

    if (phone.startsWith('0')) {
      phone = phone.substring(1);
    }

    return '${_country.dialCode}$phone';
  }

  void _submit() {
     D2YToast.info(
        context,
        title: 'OTP sent successfully',
        description: 'OTP dikirim ke $_normalizedPhone',
      );
    final digits = _phoneController.text.replaceAll(RegExp(r'\D'), '');

    setState(() {
      _phoneError = null;
      _termsError = false;

      if (digits.length < 9) {
        _phoneError = 'Nomor ponsel minimal 9 digit.';
      }

      if (!_acceptedTerms) {
        _termsError = true;
      }
    });

    if (_phoneError != null || !_acceptedTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            !_acceptedTerms
                ? 'Setujui Syarat & Ketentuan terlebih dahulu.'
                : 'Periksa kembali nomor ponsel Anda.',
          ),
        ),
      );
      return;
    }

    widget.onSendOtp?.call(_normalizedPhone);

    
    
    
    // context.go(RoutePaths.otp, extra: _normalizedPhone);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      body: SafeArea(
        child: Column(
          children: [
            _TopNavigation(
              onBack: widget.onBack ?? () => Navigator.maybePop(context),
              onHelp: widget.onHelp,
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 32),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 448),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const _HeaderSection(),
                        const SizedBox(height: 32),
                        _RegisterFormCard(
                          phoneController: _phoneController,
                          phoneFocusNode: _phoneFocusNode,
                          phoneError: _phoneError,
                          termsError: _termsError,
                          acceptedTerms: _acceptedTerms,
                          onCountryChanged: (country) {
                            setState(() => _country = country);
                          },
                          onPhoneChanged: (_) {
                            if (_phoneError != null) {
                              setState(() => _phoneError = null);
                            }
                          },
                          onTermsChanged: (value) {
                            setState(() {
                              _acceptedTerms = value;
                              _termsError = false;
                            });
                          },
                          onSubmit: _submit,
                        ),
                        const SizedBox(height: 24),
                        const _SecuritySection(),
                      ],
                    ),
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

class _TopNavigation extends StatelessWidget {
  final VoidCallback? onBack;
  final VoidCallback? onHelp;

  const _TopNavigation({
    this.onBack,
    this.onHelp,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      color: AppColors.white.withValues(alpha: 0.82),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              _CircleIconButton(
                icon: Icons.arrow_back_ios_new_rounded,
                onTap: onBack,
              ),
              const SizedBox(width: 16),
              Text(
                'd2ybank',
                style: AppTextStyles.titleMedium.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.4,
                ),
              ),
            ],
          ),
          _CircleIconButton(
            icon: Icons.help_outline_rounded,
            onTap: onHelp,
          ),
        ],
      ),
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;

  const _CircleIconButton({
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surfaceContainerLow,
      shape: CircleBorder(
        side: BorderSide(
          color: AppColors.outlineVariant.withValues(alpha: 0.3),
        ),
      ),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox(
          width: 44,
          height: 44,
          child: Icon(
            icon,
            color: AppColors.primary,
            size: 21,
          ),
        ),
      ),
    );
  }
}

class _HeaderSection extends StatelessWidget {
  const _HeaderSection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Daftar Rekening Baru',
            style: AppTextStyles.headlineMedium.copyWith(
              color: AppColors.primaryContainer,
              fontSize: 28,
              height: 36 / 28,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Silakan masukkan nomor ponsel aktif Anda untuk memulai proses verifikasi keamanan.',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.onSurfaceVariant.withValues(alpha: 0.8),
              height: 24 / 16,
            ),
          ),
        ],
      ),
    );
  }
}

class _RegisterFormCard extends StatelessWidget {
  final TextEditingController phoneController;
  final FocusNode phoneFocusNode;
  final String? phoneError;
  final bool termsError;
  final bool acceptedTerms;
  final ValueChanged<CountryCodeItem> onCountryChanged;
  final ValueChanged<String> onPhoneChanged;
  final ValueChanged<bool> onTermsChanged;
  final VoidCallback onSubmit;

  const _RegisterFormCard({
    required this.phoneController,
    required this.phoneFocusNode,
    required this.phoneError,
    required this.termsError,
    required this.acceptedTerms,
    required this.onCountryChanged,
    required this.onPhoneChanged,
    required this.onTermsChanged,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: AppColors.outlineVariant.withValues(alpha: 0.2),
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF002117).withValues(alpha: 0.08),
            blurRadius: 30,
            spreadRadius: -5,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          D2YCountryPhoneField(
            controller: phoneController,
            focusNode: phoneFocusNode,
            errorText: phoneError,
            onCountryChanged: onCountryChanged,
            onChanged: onPhoneChanged,
          ),
          const SizedBox(height: 32),
          _TermsCheckbox(
            value: acceptedTerms,
            hasError: termsError,
            onChanged: onTermsChanged,
          ),
          const SizedBox(height: 32),
          _PremiumOtpButton(onPressed: onSubmit),
        ],
      ),
    );
  }
}

class _TermsCheckbox extends StatelessWidget {
  final bool value;
  final bool hasError;
  final ValueChanged<bool> onChanged;

  const _TermsCheckbox({
    required this.value,
    required this.hasError,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final borderColor = hasError
        ? AppColors.error
        : AppColors.outlineVariant.withValues(alpha: 0.5);

    return InkWell(
      onTap: () => onChanged(!value),
      borderRadius: BorderRadius.circular(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            width: 24,
            height: 24,
            margin: const EdgeInsets.only(top: 2),
            decoration: BoxDecoration(
              color: value ? AppColors.primary : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: value ? AppColors.primary : borderColor,
                width: 2,
              ),
            ),
            child: value
                ? const Icon(
                    Icons.check_rounded,
                    color: AppColors.white,
                    size: 17,
                  )
                : null,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: AppTextStyles.labelMedium.copyWith(
                  color: AppColors.onSurfaceVariant,
                  height: 22 / 14,
                  fontWeight: FontWeight.w500,
                ),
                children: [
                  const TextSpan(text: 'Saya menyetujui '),
                  TextSpan(
                    text: 'Syarat & Ketentuan',
                    style: AppTextStyles.labelMedium.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w800,
                      decoration: TextDecoration.underline,
                      decorationColor: AppColors.primary.withValues(alpha: 0.3),
                    ),
                  ),
                  const TextSpan(text: ' serta '),
                  TextSpan(
                    text: 'Kebijakan Privasi',
                    style: AppTextStyles.labelMedium.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w800,
                      decoration: TextDecoration.underline,
                      decorationColor: AppColors.primary.withValues(alpha: 0.3),
                    ),
                  ),
                  const TextSpan(text: ' d2ybank.'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PremiumOtpButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _PremiumOtpButton({
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryContainer.withValues(alpha: 0.30),
            blurRadius: 20,
            spreadRadius: -4,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: D2YButton(
          text: 'Kirim Kode OTP',
          onPressed: onPressed,
          size: D2YButtonSize.large,
          backgroundColor: Colors.transparent,
          foregroundColor: AppColors.white,
          borderRadius: 18,
          suffixIcon: const Icon(
            Icons.arrow_forward_rounded,
            color: AppColors.white,
            size: 21,
          ),
        ),
      ),
    );
  }
}

class _SecuritySection extends StatelessWidget {
  const _SecuritySection();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        _SecurityBadge(),
        SizedBox(height: 24),
        _SecurityImageCard(),
      ],
    );
  }
}

class _SecurityBadge extends StatelessWidget {
  const _SecurityBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.securityBadgeBackground,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.10),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.verified_user_rounded,
            color: AppColors.primary,
            size: 18,
          ),
          const SizedBox(width: 12),
          Text(
            'Terdaftar & Diawasi oleh OJK',
            style: AppTextStyles.labelSmall.copyWith(
              color: AppColors.primary,
              fontSize: 10,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}

class _SecurityImageCard extends StatelessWidget {
  const _SecurityImageCard();

  static const String _imageUrl =
      'https://images.unsplash.com/photo-1563986768609-322da13575f3?q=80&w=1200&auto=format&fit=crop';

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              _imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) {
                return Container(
                  color: AppColors.primary,
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.security_rounded,
                    color: AppColors.white,
                    size: 56,
                  ),
                );
              },
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    AppColors.primary.withValues(alpha: 0.82),
                    AppColors.primary.withValues(alpha: 0.20),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
            Positioned(
              left: 24,
              right: 24,
              bottom: 24,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 32,
                        height: 2,
                        color: AppColors.secondaryContainer,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Prioritas Keamanan',
                        style: AppTextStyles.labelMedium.copyWith(
                          color: AppColors.white.withValues(alpha: 0.82),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Enkripsi Tingkat Tinggi',
                    style: AppTextStyles.titleLarge.copyWith(
                      color: AppColors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -0.4,
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
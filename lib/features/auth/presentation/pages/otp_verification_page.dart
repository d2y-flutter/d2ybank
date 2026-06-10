import 'dart:async';
import 'dart:ui';

import 'package:d2ybank/app/navigation/route_paths.dart';
import 'package:d2ybank/shared/components/buttons/d2y_button.dart';
import 'package:d2ybank/shared/components/otp/d2y_numeric_keypad.dart';
import 'package:d2ybank/shared/components/otp/d2y_otp_boxes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:d2ybank/core/config/app_colors.dart';
import 'package:d2ybank/core/config/app_icon_size.dart';
import 'package:d2ybank/core/config/app_radius.dart';
import 'package:d2ybank/core/config/app_shadow.dart';
import 'package:d2ybank/core/config/app_spacing.dart';
import 'package:d2ybank/core/config/app_text_styles.dart';


class OtpVerificationPage extends StatefulWidget {
  final String phoneNumber;

  const OtpVerificationPage({
    super.key,
    required this.phoneNumber,
  });

  @override
  State<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  static const int _otpLength = 6;
  static const int _initialSeconds = 57;

  Timer? _timer;
  String _otp = '';
  int _secondsLeft = _initialSeconds;
  bool _isVerifying = false;
  bool _isVerified = false;

  // bool get _canVerify => _otp.length == _otpLength && !_isVerifying;
  bool get _canResend => _secondsLeft <= 0 && !_isVerifying;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startCountdown() {
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;

      if (_secondsLeft <= 0) {
        timer.cancel();
        return;
      }

      setState(() => _secondsLeft--);
    });
  }

  void _addDigit(String digit) {
    if (_otp.length >= _otpLength || _isVerifying) return;

    final nextOtp = '$_otp$digit';

    setState(() {
      _otp = nextOtp;
      _isVerified = false;
    });

    if (nextOtp.length == _otpLength) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _verifyOtp();
        }
      });
    }
  }

  void _backspace() {
    if (_otp.isEmpty || _isVerifying) return;

    setState(() {
      _otp = _otp.substring(0, _otp.length - 1);
      _isVerified = false;
    });
  }

  void _resendOtp() {
    if (!_canResend) return;

    setState(() {
      _otp = '';
      _secondsLeft = _initialSeconds;
      _isVerified = false;
    });

    _startCountdown();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'OTP baru telah dikirim ke ${_maskedPhoneNumber(widget.phoneNumber)}',
        ),
      ),
    );

    // TODO: panggil event resend OTP kamu di sini.
    // context.read<AuthBloc>().add(ResendOtpRequested(phoneNumber: widget.phoneNumber));
  }

  Future<void> _verifyOtp() async {
    if (_otp.length != _otpLength || _isVerifying) return;

    setState(() {
      _isVerifying = true;
      _isVerified = false;
    });

    // TODO: ganti simulasi ini dengan AuthBloc event / usecase verify OTP.
    // context.read<AuthBloc>().add(VerifyOtpRequested(
    //   phoneNumber: widget.phoneNumber,
    //   otpCode: _otp,
    // ));

    await Future<void>.delayed(const Duration(milliseconds: 900));

    if (!mounted) return;

    setState(() {
      _isVerifying = false;
      _isVerified = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Verifikasi OTP berhasil')),
    );

    context.go(RoutePaths.identityVerification);

    // TODO: arahkan ke screen berikutnya setelah verify sukses.
    // context.go('/create-password');
  }

  String get _timerLabel {
    final minutes = (_secondsLeft ~/ 60).toString().padLeft(2, '0');
    final seconds = (_secondsLeft % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  String _maskedPhoneNumber(String phone) {
    if (phone.isEmpty) return '+62 8** **** 123';

    final digits = phone.replaceAll(RegExp(r'\D'), '');

    if (digits.length < 5) return phone;

    final suffix = digits.substring(digits.length - 3);
    return '+${digits.substring(0, 2)} 8** **** $suffix';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            _OtpTopAppBar(
              onBack: () => context.pop(),
              onHelp: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Bantuan OTP belum tersedia')),
                );
              },
            ),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.viewInsetsOf(context).bottom,
                    ),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: Center(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 420),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(
                              AppSpacing.md,
                              AppSpacing.xxl,
                              AppSpacing.md,
                              AppSpacing.xxl,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                _ShieldHeader(
                                  phoneNumber: _maskedPhoneNumber(widget.phoneNumber),
                                ),

                                const SizedBox(height: AppSpacing.xxl),

                                D2YOtpBoxes(
                                  value: _otp,
                                  length: _otpLength,
                                ),

                                const SizedBox(height: AppSpacing.xxl),

                                _OtpTimerSection(
                                  timerLabel: _timerLabel,
                                  canResend: _canResend,
                                  onResend: _resendOtp,
                                ),

                                const SizedBox(height: AppSpacing.xxxl),

                                D2YNumericKeypad(
                                  onDigitPressed: _addDigit,
                                  onBackspacePressed: _backspace,
                                ),

                                const SizedBox(height: AppSpacing.xl),
                                _OtpAutoSubmitStatus(
                                  isVerifying: _isVerifying,
                                  isVerified: _isVerified,
                                ),

                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OtpTopAppBar extends StatelessWidget {
  final VoidCallback onBack;
  final VoidCallback onHelp;

  const _OtpTopAppBar({
    required this.onBack,
    required this.onHelp,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
        child: Container(
          height: 64,
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          decoration: BoxDecoration(
            color: AppColors.surface.withValues(alpha: 0.80),
            border: Border(
              bottom: BorderSide(color: AppColors.cardBorder),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _OtpIconButton(
                icon: Icons.arrow_back_rounded,
                onTap: onBack,
              ),
              Text(
                'd2ybank',
                style: AppTextStyles.headlineMedium.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.4,
                ),
              ),
              _OtpIconButton(
                icon: Icons.help_outline_rounded,
                onTap: onHelp,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OtpIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _OtpIconButton({
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox(
          width: 42,
          height: 42,
          child: Icon(
            icon,
            color: AppColors.onSurface,
            size: AppIconSize.md,
          ),
        ),
      ),
    );
  }
}

class _ShieldHeader extends StatelessWidget {
  final String phoneNumber;

  const _ShieldHeader({
    required this.phoneNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 96,
          height: 96,
          child: Stack(
            alignment: Alignment.center,
            children: [
              ImageFiltered(
                imageFilter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: AppColors.primaryContainer.withValues(alpha: 0.30),
                    borderRadius: BorderRadius.circular(AppRadius.full),
                  ),
                ),
              ),
              Transform.rotate(
                angle: 0.05,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: AppColors.primaryContainer,
                    borderRadius: BorderRadius.circular(AppRadius.xxl),
                    boxShadow: [
                      ...AppShadow.colored(
                        AppColors.primaryContainer,
                        opacity: 0.15,
                      ),
                      BoxShadow(
                        color: AppColors.primaryContainer.withValues(alpha: 0.15),
                        blurRadius: 30,
                        spreadRadius: 10,
                      ),
                    ],
                  ),
                  child: const Stack(
                    alignment: Alignment.center,
                    children: [
                      Icon(
                        Icons.shield_rounded,
                        color: AppColors.primary,
                        size: 48,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 3),
                        child: Icon(
                          Icons.lock_rounded,
                          color: AppColors.primary,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        Text(
          'Verifikasi OTP',
          style: AppTextStyles.displaySmall.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.onSurfaceVariant,
                height: 1.55,
              ),
              children: [
                const TextSpan(text: 'Kode keamanan telah dikirim ke nomor '),
                TextSpan(
                  text: phoneNumber,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.onSurface,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _OtpTimerSection extends StatelessWidget {
  final String timerLabel;
  final bool canResend;
  final VoidCallback onResend;

  const _OtpTimerSection({
    required this.timerLabel,
    required this.canResend,
    required this.onResend,
  });

  @override
  Widget build(BuildContext context) {
    if (canResend) {
      return Center(
        child: D2YButton.text(
          text: 'Kirim Ulang',
          isFullWidth: false,
          foregroundColor: AppColors.secondary,
          prefixIcon: const Icon(
            Icons.refresh_rounded,
            color: AppColors.secondary,
            size: AppIconSize.sm,
          ),
          onPressed: onResend,
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
      child: Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: AppSpacing.xs,
        runSpacing: AppSpacing.xxs,
        children: [
          const Icon(
            Icons.schedule_rounded,
            color: AppColors.onSurfaceVariant,
            size: AppIconSize.sm,
          ),
          Text(
            'Tidak menerima kode?',
            textAlign: TextAlign.center,
            style: AppTextStyles.labelLarge.copyWith(
              color: AppColors.onSurfaceVariant,
            ),
          ),
          Text(
            'Kirim ulang dalam $timerLabel',
            textAlign: TextAlign.center,
            style: AppTextStyles.labelLarge.copyWith(
              color: AppColors.secondary,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

class _OtpAutoSubmitStatus extends StatelessWidget {
  final bool isVerifying;
  final bool isVerified;

  const _OtpAutoSubmitStatus({
    required this.isVerifying,
    required this.isVerified,
  });

  @override
  Widget build(BuildContext context) {
    if (isVerifying) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            width: 18,
            height: 18,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation(AppColors.primary),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Text(
            'Memverifikasi kode...',
            style: AppTextStyles.labelLarge.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      );
    }

    if (isVerified) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.task_alt_rounded,
            color: AppColors.primary,
            size: AppIconSize.sm,
          ),
          const SizedBox(width: AppSpacing.sm),
          Text(
            'Verifikasi berhasil',
            style: AppTextStyles.labelLarge.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      );
    }

    return Text(
      'Masukkan 6 digit kode OTP',
      textAlign: TextAlign.center,
      style: AppTextStyles.labelLarge.copyWith(
        color: AppColors.onSurfaceVariant.withValues(alpha: 0.72),
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
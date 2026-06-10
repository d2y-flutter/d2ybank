import 'package:d2ybank/app/navigation/route_paths.dart';
import 'package:d2ybank/core/config/app_colors.dart';
import 'package:d2ybank/core/config/app_icon_size.dart';
import 'package:d2ybank/core/config/app_radius.dart';
import 'package:d2ybank/core/config/app_spacing.dart';
import 'package:d2ybank/core/config/app_text_styles.dart';
import 'package:d2ybank/shared/components/buttons/d2y_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../bloc/identity_verification/identity_verification_bloc.dart';
import '../bloc/identity_verification/identity_verification_state.dart';
import '../widgets/identity_step_card.dart';

class IdentityVerificationPage extends StatelessWidget {
  const IdentityVerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Verifikasi Identitas'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => context.pop(),
        ),
      ),
      body: BlocConsumer<IdentityVerificationBloc, IdentityVerificationState>(
        listener: (context, state) {
          if (state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: AppColors.error,
                content: Text(state.errorMessage!),
              ),
            );
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.md,
                    AppSpacing.lg,
                    AppSpacing.md,
                    AppSpacing.xxl,
                  ),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 420),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const _IdentityHero(),
                          const SizedBox(height: AppSpacing.xl),

                          Text(
                            'Lengkapi dokumen berikut untuk melanjutkan pembukaan rekening Anda.',
                            style: AppTextStyles.bodyLarge.copyWith(
                              color: AppColors.onSurfaceVariant,
                              height: 1.55,
                            ),
                          ),

                          const SizedBox(height: AppSpacing.xl),

                          IdentityStepCard(
                            icon: Icons.photo_camera_rounded,
                            title: 'Foto KTP',
                            subtitle: 'Pastikan data terlihat jelas',
                            isCompleted: state.isKtpCompleted,
                            isActive: true,
                            onTap: () => context.push("${RoutePaths.identityVerification}${RoutePaths.identityKtp}"),
                          ),

                          const SizedBox(height: AppSpacing.md),

                          IdentityStepCard(
                            icon: Icons.face_rounded,
                            title: 'Verifikasi Wajah',
                            subtitle: 'Lakukan liveness detection',
                            isCompleted: state.isFaceCompleted,
                            isActive: state.isKtpCompleted,
                            onTap: () {
                              // if (!state.isKtpCompleted) {
                              //   ScaffoldMessenger.of(context).showSnackBar(
                              //     const SnackBar(
                              //       content: Text('Selesaikan Foto KTP terlebih dahulu.'),
                              //     ),
                              //   );
                              //   return;
                              // }

                              context.push("${RoutePaths.identityVerification}${RoutePaths.identityFace}");
                            },
                          ),

                          const SizedBox(height: AppSpacing.xl),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.verified_user_rounded,
                                color: AppColors.onSurfaceVariant.withValues(alpha: 0.5),
                                size: AppIconSize.sm,
                              ),
                              const SizedBox(width: AppSpacing.xs),
                              Text(
                                'Enkripsi AES-256 Standar Perbankan',
                                style: AppTextStyles.labelSmall.copyWith(
                                  color: AppColors.onSurfaceVariant.withValues(alpha: 0.55),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              _BottomAction(state: state),
            ],
          );
        },
      ),
    );
  }
}

class _IdentityHero extends StatelessWidget {
  const _IdentityHero();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 192,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.05),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            'https://images.unsplash.com/photo-1563986768609-322da13575f3?q=80&w=1200&auto=format&fit=crop',
            fit: BoxFit.cover,
            color: AppColors.primary.withValues(alpha: 0.15),
            colorBlendMode: BlendMode.overlay,
            errorBuilder: (_, __, ___) => Container(
              color: AppColors.primaryContainer,
              child: const Icon(
                Icons.verified_user_rounded,
                color: AppColors.white,
                size: 52,
              ),
            ),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  AppColors.primary.withValues(alpha: 0.68),
                  Colors.transparent,
                ],
              ),
            ),
          ),
          Positioned(
            left: AppSpacing.md,
            right: AppSpacing.md,
            bottom: AppSpacing.md,
            child: Text(
              'Keamanan data Anda adalah prioritas kami.',
              style: AppTextStyles.bodyLarge.copyWith(
                color: AppColors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomAction extends StatelessWidget {
  final IdentityVerificationState state;

  const _BottomAction({required this.state});

  @override
  Widget build(BuildContext context) {
    final isEnabled = state.isCompleted;

    return Container(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        AppSpacing.md,
        AppSpacing.md,
        AppSpacing.lg,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface.withValues(alpha: 0.88),
        border: Border(
          top: BorderSide(color: AppColors.cardBorder),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            D2YButton(
              text: 'Lanjutkan Verifikasi',
              onPressed: isEnabled
                  ? () {
                      context.go('/create-pin');
                    }
                  : null,
              backgroundColor: isEnabled
                  ? AppColors.primary
                  : AppColors.primaryContainer.withValues(alpha: 0.20),
              foregroundColor: isEnabled ? AppColors.onPrimary : AppColors.primary,
              suffixIcon: Icon(
                isEnabled ? Icons.arrow_forward_rounded : Icons.lock_rounded,
                color: isEnabled ? AppColors.onPrimary : AppColors.primary,
                size: AppIconSize.sm,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              isEnabled
                  ? 'Semua langkah berhasil diselesaikan.'
                  : 'Selesaikan semua langkah di atas untuk melanjutkan.',
              textAlign: TextAlign.center,
              style: AppTextStyles.labelSmall.copyWith(
                color: AppColors.onSurfaceVariant,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
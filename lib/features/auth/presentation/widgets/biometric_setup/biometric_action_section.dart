import 'package:d2ybank/core/config/app_colors.dart';
import 'package:d2ybank/core/config/app_icon_size.dart';
import 'package:d2ybank/core/config/app_spacing.dart';
import 'package:d2ybank/shared/components/buttons/d2y_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/biometric_setup/biometric_setup_bloc.dart';
import '../../bloc/biometric_setup/biometric_setup_event.dart';
import '../../bloc/biometric_setup/biometric_setup_state.dart';

class BiometricActionSection extends StatelessWidget {
  final BiometricSetupState state;

  const BiometricActionSection({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        D2YButton(
          text: state.isLoading
              ? 'Memeriksa...'
              : state.isAvailable
                  ? 'Aktifkan Sekarang'
                  : 'Biometrik Tidak Tersedia',
          isLoading: state.isLoading,
          backgroundColor: state.isAvailable
              ? AppColors.primary
              : AppColors.primary.withValues(alpha: 0.28),
          foregroundColor: AppColors.onPrimary,
          suffixIcon: const Icon(
            Icons.fingerprint_rounded,
            color: AppColors.onPrimary,
            size: AppIconSize.sm,
          ),
          onPressed: state.isAvailable && !state.isLoading
              ? () {
                  context.read<BiometricSetupBloc>().add(
                        const BiometricEnableRequested(
                          userId: 'current-user-id',
                          deviceId: 'current-device-id',
                        ),
                      );
                }
              : null,
        ),
        const SizedBox(height: AppSpacing.sm),
        D2YButton.text(
          text: 'Nanti Saja',
          foregroundColor: AppColors.primary,
          onPressed: state.isLoading
              ? null
              : () {
                  context.read<BiometricSetupBloc>().add(
                        const BiometricSkipRequested(),
                      );
                },
        ),
      ],
    );
  }
}
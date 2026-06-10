import 'package:d2ybank/core/config/app_colors.dart';
import 'package:d2ybank/core/config/app_icon_size.dart';
import 'package:d2ybank/core/config/app_radius.dart';
import 'package:d2ybank/core/config/app_spacing.dart';
import 'package:d2ybank/shared/components/buttons/d2y_button.dart';
import 'package:d2ybank/shared/components/inputs/d2y_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/setup_password/setup_password_bloc.dart';
import '../../bloc/setup_password/setup_password_event.dart';
import '../../bloc/setup_password/setup_password_state.dart';
import 'password_requirement_pills.dart';

class PasswordFormCard extends StatelessWidget {
  final SetupPasswordState state;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  const PasswordFormCard({
    super.key,
    required this.state,
    required this.passwordController,
    required this.confirmPasswordController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        D2YTextField(
          controller: passwordController,
          labelText: 'Password',
          hintText: 'Masukkan password baru',
          isRequired: true,
          obscureText: state.obscurePassword,
          errorText: state.passwordError,
          fillColor: AppColors.white,
          borderColor: state.passwordError != null
              ? AppColors.error
              : AppColors.outlineVariant.withValues(alpha: 0.35),
          focusedBorderColor: AppColors.primary,
          borderRadius: AppRadius.xl,
          suffixIcon: IconButton(
            onPressed: () {
              context.read<SetupPasswordBloc>().add(
                    const SetupPasswordVisibilityToggled(),
                  );
            },
            icon: Icon(
              state.obscurePassword
                  ? Icons.visibility_rounded
                  : Icons.visibility_off_rounded,
              color: AppColors.outlineVariant,
            ),
          ),
          onChanged: (value) {
            context.read<SetupPasswordBloc>().add(
                  SetupPasswordChanged(value),
                );
          },
        ),
        const SizedBox(height: AppSpacing.md),
        PasswordRequirementPills(requirement: state.requirement),
        const SizedBox(height: AppSpacing.lg),
        D2YTextField(
          controller: confirmPasswordController,
          labelText: 'Konfirmasi Password',
          hintText: 'Ulangi password baru',
          isRequired: true,
          obscureText: state.obscureConfirmPassword,
          errorText: state.confirmPasswordError,
          fillColor: AppColors.white,
          borderColor: state.confirmPasswordError != null
              ? AppColors.error
              : AppColors.outlineVariant.withValues(alpha: 0.35),
          focusedBorderColor: AppColors.primary,
          borderRadius: AppRadius.xl,
          suffixIcon: IconButton(
            onPressed: () {
              context.read<SetupPasswordBloc>().add(
                    const SetupConfirmPasswordVisibilityToggled(),
                  );
            },
            icon: Icon(
              state.obscureConfirmPassword
                  ? Icons.visibility_rounded
                  : Icons.visibility_off_rounded,
              color: AppColors.outlineVariant,
            ),
          ),
          onChanged: (value) {
            context.read<SetupPasswordBloc>().add(
                  SetupConfirmPasswordChanged(value),
                );
          },
        ),
        if (state.confirmPassword.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.sm),
          PasswordMatchPill(isMatch: state.requirement.isMatch),
        ],
        const SizedBox(height: AppSpacing.xl),
        D2YButton(
          text: state.isLoading ? 'Memproses...' : 'Lanjut ke Buat PIN',
          isLoading: state.isLoading,
          backgroundColor: state.canSubmit
              ? AppColors.primary
              : AppColors.primary.withValues(alpha: 0.30),
          foregroundColor: AppColors.onPrimary,
          suffixIcon: const Icon(
            Icons.arrow_forward_rounded,
            color: AppColors.onPrimary,
            size: AppIconSize.sm,
          ),
          onPressed: state.canSubmit
              ? () {
                  context.read<SetupPasswordBloc>().add(
                        const SetupPasswordSubmitted(),
                      );
                }
              : null,
        ),
      ],
    );
  }
}
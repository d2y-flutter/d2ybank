import 'package:d2ybank/core/config/app_spacing.dart';
import 'package:flutter/material.dart';

import '../../bloc/setup_password/setup_password_state.dart';
import 'password_banner.dart';
import 'password_form_card.dart';

class SetupPasswordContent extends StatelessWidget {
  final SetupPasswordState state;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  const SetupPasswordContent({
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
        const _Header(),
        const SizedBox(height: AppSpacing.xl),
        const PasswordBanner(),
        const SizedBox(height: AppSpacing.xl),
        PasswordFormCard(
          state: state,
          passwordController: passwordController,
          confirmPasswordController: confirmPasswordController,
        ),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return const _SetupPasswordHeader();
  }
}

class _SetupPasswordHeader extends StatelessWidget {
  const _SetupPasswordHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Buat Password Keamanan',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w800,
              ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          'Gunakan password yang kuat untuk melindungi akun d2ybank Anda.',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
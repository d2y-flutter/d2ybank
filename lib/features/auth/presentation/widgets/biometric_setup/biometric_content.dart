import 'package:d2ybank/core/config/app_spacing.dart';
import 'package:flutter/material.dart';

import '../../bloc/biometric_setup/biometric_setup_state.dart';
import 'biometric_action_section.dart';
import 'biometric_banner.dart';
import 'biometric_header.dart';
import 'biometric_security_card.dart';

class BiometricContent extends StatelessWidget {
  final BiometricSetupState state;

  const BiometricContent({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BiometricHeader(label: state.biometricLabel),
        const SizedBox(height: AppSpacing.xl),
        const BiometricBanner(),
        const SizedBox(height: AppSpacing.xl),
        const BiometricSecurityCard(),
        const SizedBox(height: AppSpacing.xl),
        BiometricActionSection(state: state),
        const SizedBox(height: AppSpacing.xl),
        const _FooterNote(),
      ],
    );
  }
}

class _FooterNote extends StatelessWidget {
  const _FooterNote();

  @override
  Widget build(BuildContext context) {
    return const Text(
      '© 2026 d2ybank. Berizin & Diawasi oleh OJK.',
      textAlign: TextAlign.center,
    );
  }
}
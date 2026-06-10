import 'package:flutter/material.dart';
import 'package:d2ybank/core/config/app_colors.dart';
import 'package:d2ybank/core/config/app_radius.dart';

/// Prominent biometric button from the HTML login reference.
/// Uses secondaryContainer bg with shadow.
class LoginBiometricButton extends StatelessWidget {
  final VoidCallback? onTap;

  const LoginBiometricButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () {
        // TODO: Trigger biometric authentication
      },
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: AppColors.secondaryContainer,
          borderRadius: BorderRadius.circular(AppRadius.xl),
          boxShadow: [
            BoxShadow(
              color: AppColors.secondary.withValues(alpha: 0.2),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Icon(
          Icons.fingerprint_rounded,
          size: 40,
          color: AppColors.onSecondaryContainer,
        ),
      ),
    );
  }
}
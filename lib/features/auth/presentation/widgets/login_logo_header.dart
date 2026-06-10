import 'package:flutter/material.dart';
import 'package:d2ybank/core/config/app_colors.dart';
import 'package:d2ybank/core/config/app_text_styles.dart';

/// Elegant logo placement from the HTML login reference.
/// Brand name in italic extrabold + "The Digital Private Vault" tagline.
class LoginLogoHeader extends StatelessWidget {
  const LoginLogoHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'd2ybank',
          style: AppTextStyles.displayLarge.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.w800,
            fontStyle: FontStyle.italic,
            letterSpacing: -1.5,
            fontSize: 38,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'THE DIGITAL PRIVATE VAULT',
          style: AppTextStyles.labelSmall.copyWith(
            fontFamily: 'Inter',
            color: AppColors.onSurfaceVariant.withValues(alpha: 0.6),
            fontWeight: FontWeight.w700,
            letterSpacing: 2.5,
            fontSize: 10,
          ),
        ),
      ],
    );
  }
}
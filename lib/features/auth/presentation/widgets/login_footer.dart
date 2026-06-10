import 'package:flutter/material.dart';
import 'package:d2ybank/core/config/app_colors.dart';
import 'package:d2ybank/core/config/app_text_styles.dart';
import 'package:d2ybank/core/config/app_spacing.dart';

class LoginFooter extends StatelessWidget {
  const LoginFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Registration link
        RichText(
          text: TextSpan(
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.onSurfaceVariant,
              fontWeight: FontWeight.w500,
            ),
            children: [
              const TextSpan(text: 'New to the private circle? '),
              WidgetSpan(
                child: GestureDetector(
                  onTap: () {
                    // TODO: Navigate to registration
                  },
                  child: Text(
                    'Apply for Access',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w700,
                      decoration: TextDecoration.underline,
                      decorationColor: AppColors.secondary.withValues(alpha: 0.5),
                      decorationStyle: TextDecorationStyle.solid,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: AppSpacing.xxl),

        // Security badges
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.verified_user_outlined, size: 18, color: AppColors.primary.withValues(alpha: 0.3)),
            const SizedBox(width: AppSpacing.xl),
            Icon(Icons.enhanced_encryption_outlined, size: 18, color: AppColors.primary.withValues(alpha: 0.3)),
            const SizedBox(width: AppSpacing.xl),
            Icon(Icons.shield_outlined, size: 18, color: AppColors.primary.withValues(alpha: 0.3)),
          ],
        ),
      ],
    );
  }
}
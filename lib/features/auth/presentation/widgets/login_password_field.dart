import 'package:flutter/material.dart';
import 'package:d2ybank/core/config/app_colors.dart';
import 'package:d2ybank/core/config/app_text_styles.dart';
import 'package:d2ybank/core/config/app_spacing.dart';
import 'package:d2ybank/core/config/app_radius.dart';

/// "Vault Key" password input from the HTML login reference.
/// Ghost border rule: use outlineVariant at 30% opacity.
/// On focus: bg transitions to white + ghost border appears.
class LoginPasswordField extends StatefulWidget {
  final TextEditingController controller;
  final String? errorText;
  final ValueChanged<String>? onSubmitted;

  const LoginPasswordField({
    super.key,
    required this.controller,
    this.errorText,
    this.onSubmitted,
  });

  @override
  State<LoginPasswordField> createState() => _LoginPasswordFieldState();
}

class _LoginPasswordFieldState extends State<LoginPasswordField> {
  bool _obscured = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label row: "VAULT KEY" + "RECOVERY?"
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'VAULT KEY',
                style: AppTextStyles.labelSmall.copyWith(
                  fontFamily: 'Inter',
                  color: AppColors.primary,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 2.5,
                  fontSize: 10,
                ),
              ),
              GestureDetector(
                onTap: () {
                  // TODO: Navigate to recovery
                },
                child: Text(
                  'RECOVERY?',
                  style: AppTextStyles.labelSmall.copyWith(
                    fontFamily: 'Inter',
                    color: AppColors.primary.withValues(alpha: 0.6),
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.5,
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.sm),

        // Input field
        TextFormField(
          controller: widget.controller,
          obscureText: _obscured,
          onFieldSubmitted: widget.onSubmitted,
          style: AppTextStyles.bodyLarge.copyWith(
            color: AppColors.onBackground,
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
            hintText: '••••••••',
            filled: true,
            fillColor: AppColors.surfaceContainerLow.withValues(alpha: 0.5),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: 18,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadius.lg),
              borderSide: BorderSide(
                color: AppColors.outlineVariant.withValues(alpha: 0.3),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadius.lg),
              borderSide: BorderSide(
                color: AppColors.outlineVariant.withValues(alpha: 0.3),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadius.lg),
              borderSide: BorderSide(
                color: AppColors.primary.withValues(alpha: 0.2),
                width: 1.5,
              ),
            ),
            errorText: widget.errorText,
            suffixIcon: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: GestureDetector(
                onTap: () => setState(() => _obscured = !_obscured),
                child: Icon(
                  _obscured ? Icons.key_rounded : Icons.visibility_outlined,
                  color: AppColors.outline.withValues(alpha: 0.4),
                  size: 20,
                ),
              ),
            ),
            suffixIconConstraints: const BoxConstraints(minWidth: 48, minHeight: 48),
          ),
        ),
      ],
    );
  }
}
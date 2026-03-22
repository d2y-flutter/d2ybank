import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/config/app_colors.dart';
import '../../../core/config/app_radius.dart';
import '../../../core/config/app_spacing.dart';
import '../../../core/config/app_text_styles.dart';

class D2YTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;
  final String? errorText;
  final bool enabled;
  final bool readOnly;
  final bool obscureText;
  final int? maxLines;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final VoidCallback? onTap;
  final FocusNode? focusNode;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final double? borderRadius;
  final TextStyle? style;

  const D2YTextField({super.key, this.controller, this.labelText, this.hintText, this.errorText,
    this.enabled = true, this.readOnly = false, this.obscureText = false, this.maxLines = 1,
    this.keyboardType, this.textInputAction, this.inputFormatters, this.onChanged,
    this.validator, this.onTap, this.focusNode, this.prefixIcon, this.suffixIcon,
    this.borderRadius, this.style});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final radius = borderRadius ?? AppRadius.md;
    return TextFormField(
      controller: controller, focusNode: focusNode, enabled: enabled, readOnly: readOnly,
      obscureText: obscureText, maxLines: maxLines, keyboardType: keyboardType,
      textInputAction: textInputAction, inputFormatters: inputFormatters,
      onChanged: onChanged, validator: validator, onTap: onTap,
      style: style ?? AppTextStyles.bodyMedium.copyWith(
        color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight),
      decoration: InputDecoration(
        labelText: labelText, hintText: hintText, errorText: errorText,
        prefixIcon: prefixIcon, suffixIcon: suffixIcon,
        filled: true,
        fillColor: isDark ? AppColors.surfaceVariantDark : AppColors.surfaceVariantLight,
        contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(radius), borderSide: BorderSide.none),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide(color: isDark ? AppColors.borderDark : AppColors.borderLight)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide(color: isDark ? AppColors.primaryLight : AppColors.primary, width: 1.5)),
        errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(radius),
          borderSide: const BorderSide(color: AppColors.error)),
      ),
    );
  }
}

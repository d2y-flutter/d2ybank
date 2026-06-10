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

  /// Tambahan agar bisa dipakai untuk custom input premium.
  final Color? fillColor;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final Color? hintColor;
  final EdgeInsetsGeometry? contentPadding;
  final bool showBorder;
  final bool dense;

  const D2YTextField({
    super.key,
    this.controller,
    this.labelText,
    this.hintText,
    this.errorText,
    this.enabled = true,
    this.readOnly = false,
    this.obscureText = false,
    this.maxLines = 1,
    this.keyboardType,
    this.textInputAction,
    this.inputFormatters,
    this.onChanged,
    this.validator,
    this.onTap,
    this.focusNode,
    this.prefixIcon,
    this.suffixIcon,
    this.borderRadius,
    this.style,
    this.fillColor,
    this.borderColor,
    this.focusedBorderColor,
    this.hintColor,
    this.contentPadding,
    this.showBorder = true,
    this.dense = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final radius = borderRadius ?? AppRadius.md;

    final effectiveTextColor = isDark ? AppColors.inverseOnSurface : AppColors.onSurface;
    final effectiveFillColor =
        fillColor ?? AppColors.surfaceContainerLow.withValues(alpha: 0.5);

    final effectiveBorderColor =
        borderColor ?? AppColors.outlineVariant.withValues(alpha: 0.25);

    final effectiveFocusedBorderColor =
        focusedBorderColor ?? AppColors.primary.withValues(alpha: 0.35);

    final borderSide = showBorder
        ? BorderSide(color: effectiveBorderColor)
        : BorderSide.none;

    final focusedBorderSide = showBorder
        ? BorderSide(color: effectiveFocusedBorderColor, width: 1.5)
        : BorderSide.none;

    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      enabled: enabled,
      readOnly: readOnly,
      obscureText: obscureText,
      maxLines: maxLines,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      inputFormatters: inputFormatters,
      onChanged: onChanged,
      validator: validator,
      onTap: onTap,
      style: style ??
          AppTextStyles.bodyMedium.copyWith(
            color: effectiveTextColor,
            fontWeight: FontWeight.w500,
          ),
      decoration: InputDecoration(
        isDense: dense,
        labelText: labelText,
        hintText: hintText,
        errorText: errorText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: effectiveFillColor,
        contentPadding: contentPadding ??
            const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: borderSide,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: borderSide,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: focusedBorderSide,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: const BorderSide(color: AppColors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: const BorderSide(color: AppColors.error, width: 1.5),
        ),
        hintStyle: AppTextStyles.bodyMedium.copyWith(
          color: hintColor ?? AppColors.outlineVariant.withValues(alpha: 0.7),
        ),
      ),
    );
  }
}
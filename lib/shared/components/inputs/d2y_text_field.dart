import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/config/app_colors.dart';
import '../../../core/config/app_radius.dart';
import '../../../core/config/app_spacing.dart';
import '../../../core/config/app_text_styles.dart';
import '../../validators/d2y_field_validator.dart';

enum D2YTextFieldLabelPosition {
  none,
  outside,
  floating,
}

class D2YTextField extends StatelessWidget {
  final TextEditingController? controller;

  /// Label utama.
  /// Default tampil di luar field agar konsisten dengan UI banking form.
  final String? labelText;

  final String? hintText;
  final String? helperText;
  final String? errorText;

  final bool enabled;
  final bool readOnly;
  final bool obscureText;
  final bool isRequired;

  final int? minLines;
  final int? maxLines;
  final int? maxLength;

  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final List<TextInputFormatter>? inputFormatters;

  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final FormFieldValidator<String>? validator;
  final D2YValidationRule? validationRule;

  final VoidCallback? onTap;
  final VoidCallback? onEditingComplete;
  final FocusNode? focusNode;

  final Widget? prefixIcon;
  final Widget? suffixIcon;

  final double? borderRadius;
  final double borderWidth;
  final double focusedBorderWidth;

  final TextStyle? style;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final TextStyle? helperStyle;
  final TextStyle? errorStyle;

  final Color? fillColor;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final Color? disabledFillColor;
  final Color? hintColor;
  final Color? cursorColor;

  final EdgeInsetsGeometry? contentPadding;

  final bool showBorder;
  final bool dense;
  final bool autofocus;
  final bool enableSuggestions;
  final bool autocorrect;
  final bool expands;
  final bool showCounter;

  final TextAlign textAlign;
  final AutovalidateMode? autovalidateMode;
  final D2YTextFieldLabelPosition labelPosition;

  const D2YTextField({
    super.key,
    this.controller,
    this.labelText,
    this.hintText,
    this.helperText,
    this.errorText,
    this.enabled = true,
    this.readOnly = false,
    this.obscureText = false,
    this.isRequired = false,
    this.minLines,
    this.maxLines = 1,
    this.maxLength,
    this.keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.inputFormatters,
    this.onChanged,
    this.onSubmitted,
    this.validator,
    this.validationRule,
    this.onTap,
    this.onEditingComplete,
    this.focusNode,
    this.prefixIcon,
    this.suffixIcon,
    this.borderRadius,
    this.borderWidth = 1,
    this.focusedBorderWidth = 1.5,
    this.style,
    this.labelStyle,
    this.hintStyle,
    this.helperStyle,
    this.errorStyle,
    this.fillColor,
    this.borderColor,
    this.focusedBorderColor,
    this.disabledFillColor,
    this.hintColor,
    this.cursorColor,
    this.contentPadding,
    this.showBorder = true,
    this.dense = false,
    this.autofocus = false,
    this.enableSuggestions = true,
    this.autocorrect = true,
    this.expands = false,
    this.showCounter = false,
    this.textAlign = TextAlign.start,
    this.autovalidateMode,
    this.labelPosition = D2YTextFieldLabelPosition.outside,
  });

  const D2YTextField.floatingLabel({
    super.key,
    this.controller,
    this.labelText,
    this.hintText,
    this.helperText,
    this.errorText,
    this.enabled = true,
    this.readOnly = false,
    this.obscureText = false,
    this.isRequired = false,
    this.minLines,
    this.maxLines = 1,
    this.maxLength,
    this.keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.inputFormatters,
    this.onChanged,
    this.onSubmitted,
    this.validator,
    this.validationRule,
    this.onTap,
    this.onEditingComplete,
    this.focusNode,
    this.prefixIcon,
    this.suffixIcon,
    this.borderRadius,
    this.borderWidth = 1,
    this.focusedBorderWidth = 1.5,
    this.style,
    this.labelStyle,
    this.hintStyle,
    this.helperStyle,
    this.errorStyle,
    this.fillColor,
    this.borderColor,
    this.focusedBorderColor,
    this.disabledFillColor,
    this.hintColor,
    this.cursorColor,
    this.contentPadding,
    this.showBorder = true,
    this.dense = false,
    this.autofocus = false,
    this.enableSuggestions = true,
    this.autocorrect = true,
    this.expands = false,
    this.showCounter = false,
    this.textAlign = TextAlign.start,
    this.autovalidateMode,
  }) : labelPosition = D2YTextFieldLabelPosition.floating;

  const D2YTextField.noLabel({
    super.key,
    this.controller,
    this.hintText,
    this.helperText,
    this.errorText,
    this.enabled = true,
    this.readOnly = false,
    this.obscureText = false,
    this.minLines,
    this.maxLines = 1,
    this.maxLength,
    this.keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.inputFormatters,
    this.onChanged,
    this.onSubmitted,
    this.validator,
    this.validationRule,
    this.onTap,
    this.onEditingComplete,
    this.focusNode,
    this.prefixIcon,
    this.suffixIcon,
    this.borderRadius,
    this.borderWidth = 1,
    this.focusedBorderWidth = 1.5,
    this.style,
    this.labelStyle,
    this.hintStyle,
    this.helperStyle,
    this.errorStyle,
    this.fillColor,
    this.borderColor,
    this.focusedBorderColor,
    this.disabledFillColor,
    this.hintColor,
    this.cursorColor,
    this.contentPadding,
    this.showBorder = true,
    this.dense = false,
    this.autofocus = false,
    this.enableSuggestions = true,
    this.autocorrect = true,
    this.expands = false,
    this.showCounter = false,
    this.textAlign = TextAlign.start,
    this.autovalidateMode,
  })  : labelText = null,
        isRequired = false,
        labelPosition = D2YTextFieldLabelPosition.none;

  @override
  Widget build(BuildContext context) {
    final textField = _buildTextFormField(context);

    if (labelPosition == D2YTextFieldLabelPosition.outside &&
        labelText != null &&
        labelText!.trim().isNotEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _OutsideLabel(
            label: labelText!,
            isRequired: isRequired,
            style: labelStyle,
          ),
          const SizedBox(height: AppSpacing.xs),
          textField,
        ],
      );
    }

    return textField;
  }

  Widget _buildTextFormField(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final radius = borderRadius ?? AppRadius.md;

    final effectiveTextColor =
        isDark ? AppColors.inverseOnSurface : AppColors.onSurface;

    final effectiveFillColor = enabled
        ? fillColor ?? AppColors.surfaceContainerLow.withValues(alpha: 0.5)
        : disabledFillColor ?? AppColors.surfaceContainerHigh.withValues(alpha: 0.6);

    final effectiveBorderColor =
        borderColor ?? AppColors.outlineVariant.withValues(alpha: 0.35);

    final effectiveFocusedBorderColor =
        focusedBorderColor ?? AppColors.primary;

    final effectiveErrorText = errorText;

    final borderSide = showBorder
        ? BorderSide(
            color: effectiveBorderColor,
            width: borderWidth,
          )
        : BorderSide.none;

    final focusedBorderSide = showBorder
        ? BorderSide(
            color: effectiveFocusedBorderColor,
            width: focusedBorderWidth,
          )
        : BorderSide.none;

    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      enabled: enabled,
      readOnly: readOnly,
      obscureText: obscureText,
      minLines: obscureText ? 1 : minLines,
      maxLines: obscureText ? 1 : maxLines,
      maxLength: maxLength,
      expands: expands,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      textCapitalization: textCapitalization,
      inputFormatters: inputFormatters,
      onChanged: onChanged,
      onFieldSubmitted: onSubmitted,
      onEditingComplete: onEditingComplete,
      validator: validator ??
          (validationRule == null
              ? null
              : (value) => D2YFieldValidator.validate(
                    value,
                    rule: validationRule!,
                  )),
      onTap: onTap,
      autofocus: autofocus,
      enableSuggestions: enableSuggestions,
      autocorrect: autocorrect,
      textAlign: textAlign,
      cursorColor: cursorColor ?? AppColors.primary,
      autovalidateMode: autovalidateMode,
      style: style ??
          AppTextStyles.bodyMedium.copyWith(
            color: effectiveTextColor,
            fontWeight: FontWeight.w600,
          ),
      decoration: InputDecoration(
        isDense: dense,
        labelText: labelPosition == D2YTextFieldLabelPosition.floating
            ? _labelWithRequired
            : null,
        hintText: hintText,
        helperText: helperText,
        errorText: effectiveErrorText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: effectiveFillColor,
        counterText: showCounter ? null : '',
        contentPadding: contentPadding ??
            EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: (maxLines ?? 1) > 1 ? AppSpacing.sm : AppSpacing.md,
            ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: borderSide,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: borderSide,
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide(
            color: AppColors.outlineVariant.withValues(alpha: 0.18),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: focusedBorderSide,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: const BorderSide(
            color: AppColors.error,
            width: 1,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: const BorderSide(
            color: AppColors.error,
            width: 1.5,
          ),
        ),
        labelStyle: labelStyle ??
            AppTextStyles.labelLarge.copyWith(
              color: AppColors.onSurfaceVariant,
              fontWeight: FontWeight.w700,
            ),
        hintStyle: hintStyle ??
            AppTextStyles.bodyMedium.copyWith(
              color: hintColor ?? AppColors.outlineVariant.withValues(alpha: 0.7),
              fontWeight: FontWeight.w500,
            ),
        helperStyle: helperStyle ??
            AppTextStyles.labelSmall.copyWith(
              color: AppColors.onSurfaceVariant.withValues(alpha: 0.75),
            ),
        errorStyle: errorStyle ??
            AppTextStyles.labelSmall.copyWith(
              color: AppColors.error,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }

  String? get _labelWithRequired {
    if (labelText == null) return null;
    if (!isRequired) return labelText;
    return '$labelText *';
  }
}

class _OutsideLabel extends StatelessWidget {
  final String label;
  final bool isRequired;
  final TextStyle? style;

  const _OutsideLabel({
    required this.label,
    required this.isRequired,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveStyle = style ??
        AppTextStyles.labelLarge.copyWith(
          color: AppColors.onSurfaceVariant,
          fontWeight: FontWeight.w700,
        );

    return Padding(
      padding: const EdgeInsets.only(left: AppSpacing.xs),
      child: RichText(
        text: TextSpan(
          style: effectiveStyle,
          children: [
            TextSpan(text: label),
            if (isRequired)
              const TextSpan(
                text: ' *',
                style: TextStyle(color: AppColors.error),
              ),
          ],
        ),
      ),
    );
  }
}
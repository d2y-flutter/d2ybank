import 'package:flutter/material.dart';
import '../../../core/config/app_colors.dart';
import '../../../core/config/app_radius.dart';
import '../../../core/config/app_spacing.dart';
import '../../../core/config/app_text_styles.dart';

enum D2YButtonVariant { filled, outlined, text, tonal }
enum D2YButtonSize { small, medium, large }

class D2YButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final D2YButtonVariant variant;
  final D2YButtonSize size;
  final bool isLoading;
  final bool isFullWidth;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? borderRadius;

  const D2YButton({super.key, required this.text, this.onPressed, this.variant = D2YButtonVariant.filled,
    this.size = D2YButtonSize.medium, this.isLoading = false, this.isFullWidth = true,
    this.prefixIcon, this.suffixIcon, this.backgroundColor, this.foregroundColor, this.borderRadius});

  const D2YButton.outlined({super.key, required this.text, this.onPressed, this.size = D2YButtonSize.medium,
    this.isLoading = false, this.isFullWidth = true, this.prefixIcon, this.suffixIcon,
    this.backgroundColor, this.foregroundColor, this.borderRadius}) : variant = D2YButtonVariant.outlined;

  const D2YButton.text({super.key, required this.text, this.onPressed, this.size = D2YButtonSize.medium,
    this.isLoading = false, this.isFullWidth = false, this.prefixIcon, this.suffixIcon,
    this.backgroundColor, this.foregroundColor, this.borderRadius}) : variant = D2YButtonVariant.text;

  double get _height => switch (size) { D2YButtonSize.small => 36, D2YButtonSize.medium => 48, D2YButtonSize.large => 56 };
  double get _loadingSize => switch (size) { D2YButtonSize.small => 14, D2YButtonSize.medium => 18, D2YButtonSize.large => 22 };

  @override
  Widget build(BuildContext context) {
    final radius = borderRadius ?? AppRadius.md;
    final bg = backgroundColor ?? AppColors.primary;
    final fg = foregroundColor ?? AppColors.white;

    return SizedBox(
      width: isFullWidth ? double.infinity : null,
      height: _height,
      child: switch (variant) {
        D2YButtonVariant.filled => ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: ElevatedButton.styleFrom(elevation: 0, backgroundColor: bg, foregroundColor: fg,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius))),
          child: _buildContent(fg)),
        D2YButtonVariant.outlined => OutlinedButton(
          onPressed: isLoading ? null : onPressed,
          style: OutlinedButton.styleFrom(foregroundColor: bg, side: BorderSide(color: bg),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius))),
          child: _buildContent(bg)),
        D2YButtonVariant.text => TextButton(
          onPressed: isLoading ? null : onPressed,
          child: _buildContent(fg)),
        D2YButtonVariant.tonal => ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: ElevatedButton.styleFrom(elevation: 0, backgroundColor: AppColors.primary, foregroundColor: AppColors.primary,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius))),
          child: _buildContent(AppColors.primary)),
      },
    );
  }

  Widget _buildContent(Color fg) {
    if (isLoading) return SizedBox(width: _loadingSize, height: _loadingSize,
      child: CircularProgressIndicator(strokeWidth: 2, valueColor: AlwaysStoppedAnimation(fg)));
    return Row(mainAxisSize: MainAxisSize.min, mainAxisAlignment: MainAxisAlignment.center, children: [
      if (prefixIcon != null) ...[prefixIcon!, const SizedBox(width: AppSpacing.xs)],
      Text(text),
      if (suffixIcon != null) ...[const SizedBox(width: AppSpacing.xs), suffixIcon!],
    ]);
  }
}

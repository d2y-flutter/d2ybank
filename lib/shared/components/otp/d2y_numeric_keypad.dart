import 'package:flutter/material.dart';

import 'package:d2ybank/core/config/app_colors.dart';
import 'package:d2ybank/core/config/app_duration.dart';
import 'package:d2ybank/core/config/app_icon_size.dart';
import 'package:d2ybank/core/config/app_radius.dart';
import 'package:d2ybank/core/config/app_spacing.dart';
import 'package:d2ybank/core/config/app_text_styles.dart';

class D2YNumericKeypad extends StatelessWidget {
  final ValueChanged<String> onDigitPressed;
  final VoidCallback onBackspacePressed;

  const D2YNumericKeypad({
    super.key,
    required this.onDigitPressed,
    required this.onBackspacePressed,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final keyHeight = screenHeight < 700 ? 50.0 : 56.0;

    final keys = <String?>[
      '1',
      '2',
      '3',
      '4',
      '5',
      '6',
      '7',
      '8',
      '9',
      null,
      '0',
      'backspace',
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: keys.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisExtent: keyHeight,
        crossAxisSpacing: AppSpacing.sm,
        mainAxisSpacing: AppSpacing.sm,
      ),
      itemBuilder: (context, index) {
        final key = keys[index];

        if (key == null) {
          return const SizedBox.shrink();
        }

        if (key == 'backspace') {
          return _KeypadButton(
            onTap: onBackspacePressed,
            backgroundColor: Colors.transparent,
            child: const Icon(
              Icons.backspace_rounded,
              color: AppColors.onSurface,
              size: AppIconSize.md,
            ),
          );
        }

        return _KeypadButton(
          onTap: () => onDigitPressed(key),
          child: Text(
            key,
            style: AppTextStyles.headlineMedium.copyWith(
              color: AppColors.onSurface,
              fontWeight: FontWeight.w700,
            ),
          ),
        );
      },
    );
  }
}

class _KeypadButton extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;
  final Color? backgroundColor;

  const _KeypadButton({
    required this.child,
    required this.onTap,
    this.backgroundColor,
  });

  @override
  State<_KeypadButton> createState() => _KeypadButtonState();
}

class _KeypadButtonState extends State<_KeypadButton> {
  bool _pressed = false;

  void _setPressed(bool value) {
    if (mounted) setState(() => _pressed = value);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: _pressed ? 0.95 : 1,
      duration: AppDuration.fast,
      curve: Curves.easeOut,
      child: Material(
        color: widget.backgroundColor ??
            AppColors.surfaceContainerHighest.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(AppRadius.md),
        child: InkWell(
          onTap: widget.onTap,
          onHighlightChanged: _setPressed,
          borderRadius: BorderRadius.circular(AppRadius.md),
          child: Center(child: widget.child),
        ),
      ),
    );
  }
}
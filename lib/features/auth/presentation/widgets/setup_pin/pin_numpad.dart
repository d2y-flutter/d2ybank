import 'package:d2ybank/core/config/app_colors.dart';
import 'package:d2ybank/core/config/app_icon_size.dart';
import 'package:d2ybank/core/config/app_spacing.dart';
import 'package:d2ybank/core/config/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/setup_pin/setup_pin_bloc.dart';
import '../../bloc/setup_pin/setup_pin_event.dart';

class PinNumpad extends StatelessWidget {
  final bool isEnabled;

  const PinNumpad({
    super.key,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final buttonSize = screenHeight < 720 ? 64.0 : 80.0;
    final verticalGap = screenHeight < 720 ? AppSpacing.md : AppSpacing.lg;

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
      itemCount: keys.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.only(bottom: AppSpacing.lg),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisExtent: buttonSize,
        crossAxisSpacing: AppSpacing.xl,
        mainAxisSpacing: verticalGap,
      ),
      itemBuilder: (context, index) {
        final key = keys[index];

        if (key == null) {
          return SizedBox(width: buttonSize, height: buttonSize);
        }

        if (key == 'backspace') {
          return _PinKeyButton(
            isEnabled: isEnabled,
            size: buttonSize,
            onTap: () {
              HapticFeedback.lightImpact();
              context.read<SetupPinBloc>().add(
                    const SetupPinBackspacePressed(),
                  );
            },
            child: const Icon(
              Icons.backspace_rounded,
              color: AppColors.onSurface,
              size: AppIconSize.lg,
            ),
          );
        }

        return _PinKeyButton(
          isEnabled: isEnabled,
          size: buttonSize,
          onTap: () {
            HapticFeedback.selectionClick();
            context.read<SetupPinBloc>().add(
                  SetupPinDigitPressed(key),
                );
          },
          child: Text(
            key,
            style: AppTextStyles.displaySmall.copyWith(
              color: AppColors.onSurface,
              fontWeight: FontWeight.w700,
            ),
          ),
        );
      },
    );
  }
}

class _PinKeyButton extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;
  final bool isEnabled;
  final double size;

  const _PinKeyButton({
    required this.child,
    required this.onTap,
    required this.isEnabled,
    required this.size,
  });

  @override
  State<_PinKeyButton> createState() => _PinKeyButtonState();
}

class _PinKeyButtonState extends State<_PinKeyButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTapDown: widget.isEnabled ? (_) => setState(() => _pressed = true) : null,
        onTapCancel: widget.isEnabled ? () => setState(() => _pressed = false) : null,
        onTapUp: widget.isEnabled
            ? (_) {
                setState(() => _pressed = false);
                widget.onTap();
              }
            : null,
        child: AnimatedScale(
          duration: const Duration(milliseconds: 120),
          scale: _pressed ? 0.92 : 1,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 120),
            width: widget.size,
            height: widget.size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _pressed ? AppColors.surfaceContainer : Colors.transparent,
            ),
            alignment: Alignment.center,
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
import 'package:d2ybank/core/config/app_spacing.dart';
import 'package:flutter/material.dart';

import '../../bloc/setup_pin/setup_pin_state.dart';
import 'pin_dot_indicator.dart';
import 'pin_header.dart';
import 'pin_numpad.dart';

class PinContent extends StatelessWidget {
  final SetupPinState state;

  const PinContent({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 430),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(
                      AppSpacing.md,
                      AppSpacing.xl,
                      AppSpacing.md,
                      AppSpacing.xxl,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        PinHeader(
                          title: state.title,
                          subtitle: state.subtitle,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: AppSpacing.xxl,
                          ),
                          child: PinDotIndicator(
                            length: 6,
                            activeLength: state.currentLength,
                          ),
                        ),
                        PinNumpad(isEnabled: !state.isLoading),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
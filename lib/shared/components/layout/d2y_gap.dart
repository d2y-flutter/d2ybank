import 'package:flutter/material.dart';
import '../../../core/config/app_spacing.dart';

class D2YGap extends StatelessWidget {
  final double width;
  final double height;
  const D2YGap({super.key, this.width = 0, this.height = 0});
  static const xs = D2YGap(height: AppSpacing.xs);
  static const sm = D2YGap(height: AppSpacing.sm);
  static const md = D2YGap(height: AppSpacing.md);
  static const lg = D2YGap(height: AppSpacing.lg);
  static const xl = D2YGap(height: AppSpacing.xl);
  static const xxl = D2YGap(height: AppSpacing.xxl);
  @override
  Widget build(BuildContext context) => SizedBox(width: width, height: height);
}

import 'package:flutter/material.dart';

/// Local presentation tokens converted from the Stitch/Tailwind HTML.
/// Keep this file small and dashboard-specific. Move to core/config only if reused.
abstract final class DashboardUiTokens {
  static const Color primary = Color(0xFF064E3B);
  static const Color primaryContainer = Color(0xFF064E3B);
  static const Color secondary = Color(0xFFFBBF24);
  static const Color secondaryContainer = Color(0xFFFFC329);
  static const Color secondaryFixed = Color(0xFFFFDF9F);
  static const Color onSecondaryContainer = Color(0xFF6F5100);
  static const Color background = Color(0xFFF8F9FA);
  static const Color surface = Color(0xFFF8F9FA);
  static const Color surfaceContainerHigh = Color(0xFFE7E8E9);
  static const Color onSurface = Color(0xFF191C1D);
  static const Color onSurfaceVariant = Color(0xFF404944);
  static const Color outlineVariant = Color(0xFFBFC9C3);
  static const Color success = Color(0xFF22C55E);

  static const double marginMobile = 16;
  static const double gapXs = 4;
  static const double gapSm = 8;
  static const double gapMd = 16;
  static const double gapLg = 24;
  static const double gapXl = 32;
  static const double maxContentWidth = 430;

  static const BorderRadius radiusSm = BorderRadius.all(Radius.circular(8));
  static const BorderRadius radiusMd = BorderRadius.all(Radius.circular(12));
  static const BorderRadius radiusLg = BorderRadius.all(Radius.circular(16));
  static const BorderRadius radiusXl = BorderRadius.all(Radius.circular(24));
}

import 'package:flutter/material.dart';

abstract final class AppTextStyles {
  static const String _fontFamily = 'PlusJakartaSans';

  static const TextStyle displayLarge = TextStyle(fontFamily: _fontFamily, fontSize: 36, fontWeight: FontWeight.w700, height: 1.2, letterSpacing: -0.5);
  static const TextStyle displayMedium = TextStyle(fontFamily: _fontFamily, fontSize: 30, fontWeight: FontWeight.w700, height: 1.25);
  static const TextStyle displaySmall = TextStyle(fontFamily: _fontFamily, fontSize: 24, fontWeight: FontWeight.w600, height: 1.3);
  static const TextStyle headlineLarge = TextStyle(fontFamily: _fontFamily, fontSize: 22, fontWeight: FontWeight.w600, height: 1.3);
  static const TextStyle headlineMedium = TextStyle(fontFamily: _fontFamily, fontSize: 20, fontWeight: FontWeight.w600, height: 1.35);
  static const TextStyle headlineSmall = TextStyle(fontFamily: _fontFamily, fontSize: 18, fontWeight: FontWeight.w600, height: 1.35);
  static const TextStyle titleLarge = TextStyle(fontFamily: _fontFamily, fontSize: 16, fontWeight: FontWeight.w600, height: 1.4);
  static const TextStyle titleMedium = TextStyle(fontFamily: _fontFamily, fontSize: 14, fontWeight: FontWeight.w600, height: 1.4);
  static const TextStyle titleSmall = TextStyle(fontFamily: _fontFamily, fontSize: 12, fontWeight: FontWeight.w600, height: 1.4);
  static const TextStyle bodyLarge = TextStyle(fontFamily: _fontFamily, fontSize: 16, fontWeight: FontWeight.w400, height: 1.5);
  static const TextStyle bodyMedium = TextStyle(fontFamily: _fontFamily, fontSize: 14, fontWeight: FontWeight.w400, height: 1.5);
  static const TextStyle bodySmall = TextStyle(fontFamily: _fontFamily, fontSize: 12, fontWeight: FontWeight.w400, height: 1.5);
  static const TextStyle labelLarge = TextStyle(fontFamily: _fontFamily, fontSize: 14, fontWeight: FontWeight.w500, height: 1.4);
  static const TextStyle labelMedium = TextStyle(fontFamily: _fontFamily, fontSize: 12, fontWeight: FontWeight.w500, height: 1.4);
  static const TextStyle labelSmall = TextStyle(fontFamily: _fontFamily, fontSize: 10, fontWeight: FontWeight.w500, height: 1.4);
  static const TextStyle caption = TextStyle(fontFamily: _fontFamily, fontSize: 11, fontWeight: FontWeight.w400, height: 1.4);
  static const TextStyle mono = TextStyle(fontFamily: 'DMSans', fontSize: 16, fontWeight: FontWeight.w600, height: 1.4, letterSpacing: 2.0);
}

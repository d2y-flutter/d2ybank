import 'package:flutter/material.dart';
import '../../core/config/app_colors.dart';
import '../../core/config/app_breakpoints.dart';

extension BuildContextX on BuildContext {
  ThemeData get theme => Theme.of(this);
  ColorScheme get colorScheme => theme.colorScheme;
  bool get isDarkMode => theme.brightness == Brightness.dark;
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  double get screenWidth => mediaQuery.size.width;
  double get screenHeight => mediaQuery.size.height;
  bool get isMobile => screenWidth < AppBreakpoints.tablet;
  bool get isTablet => screenWidth >= AppBreakpoints.tablet && screenWidth < AppBreakpoints.desktop;

  Color get textPrimaryColor => isDarkMode ? AppColors.primary : AppColors.primaryContainer;
  Color get textSecondaryColor => isDarkMode ? AppColors.secondary : AppColors.secondaryContainer;
  Color get surfaceColor => isDarkMode ? AppColors.surface : AppColors.surfaceTint;
  Color get borderColor => isDarkMode ? AppColors.ghostBorder : AppColors.ghostBorder;

  void unfocus() => FocusScope.of(this).unfocus();
}

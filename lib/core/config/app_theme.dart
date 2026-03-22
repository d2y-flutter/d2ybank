import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';
import 'app_radius.dart';
import 'app_spacing.dart';

abstract final class AppTheme {
  static ThemeData get light => ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    fontFamily: 'PlusJakartaSans',
    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      primaryContainer: AppColors.primarySurface,
      secondary: AppColors.secondary,
      error: AppColors.error,
      surface: AppColors.surfaceLight,
      onPrimary: AppColors.white,
      onSurface: AppColors.textPrimaryLight,
      outline: AppColors.borderLight,
    ),
    scaffoldBackgroundColor: AppColors.backgroundLight,
    appBarTheme: const AppBarTheme(
      elevation: 0, scrolledUnderElevation: 0.5,
      backgroundColor: AppColors.surfaceLight,
      foregroundColor: AppColors.textPrimaryLight,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      centerTitle: true,
      titleTextStyle: AppTextStyles.titleLarge,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true, fillColor: AppColors.surfaceVariantLight,
      contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
      border: OutlineInputBorder(borderRadius: AppRadius.borderRadiusMd, borderSide: BorderSide.none),
      enabledBorder: OutlineInputBorder(borderRadius: AppRadius.borderRadiusMd, borderSide: const BorderSide(color: AppColors.borderLight)),
      focusedBorder: OutlineInputBorder(borderRadius: AppRadius.borderRadiusMd, borderSide: const BorderSide(color: AppColors.primary, width: 1.5)),
      errorBorder: OutlineInputBorder(borderRadius: AppRadius.borderRadiusMd, borderSide: const BorderSide(color: AppColors.error)),
      hintStyle: AppTextStyles.bodyMedium.copyWith(color: AppColors.textTertiaryLight),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(style: ElevatedButton.styleFrom(
      elevation: 0, backgroundColor: AppColors.primary, foregroundColor: AppColors.white,
      disabledBackgroundColor: AppColors.neutral300, minimumSize: const Size(double.infinity, 52),
      shape: RoundedRectangleBorder(borderRadius: AppRadius.borderRadiusMd),
      textStyle: AppTextStyles.labelLarge,
    )),
    outlinedButtonTheme: OutlinedButtonThemeData(style: OutlinedButton.styleFrom(
      foregroundColor: AppColors.primary, minimumSize: const Size(double.infinity, 52),
      shape: RoundedRectangleBorder(borderRadius: AppRadius.borderRadiusMd),
      side: const BorderSide(color: AppColors.primary),
    )),
    textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(foregroundColor: AppColors.primary)),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: AppColors.surfaceLight,
      shape: RoundedRectangleBorder(borderRadius: AppRadius.topXl),
    ),
    dividerTheme: const DividerThemeData(color: AppColors.borderLight, thickness: 1, space: 1),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppColors.neutral900,
      contentTextStyle: AppTextStyles.bodyMedium.copyWith(color: AppColors.white),
      shape: RoundedRectangleBorder(borderRadius: AppRadius.borderRadiusSm),
      behavior: SnackBarBehavior.floating,
    ),
  );

  static ThemeData get dark => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    fontFamily: 'PlusJakartaSans',
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primaryLight,
      secondary: AppColors.secondaryLight,
      error: Color(0xFFEF5350),
      surface: AppColors.surfaceDark,
      onPrimary: AppColors.black,
      onSurface: AppColors.textPrimaryDark,
      outline: AppColors.borderDark,
    ),
    scaffoldBackgroundColor: AppColors.backgroundDark,
    appBarTheme: const AppBarTheme(
      elevation: 0, scrolledUnderElevation: 0.5,
      backgroundColor: AppColors.surfaceDark,
      foregroundColor: AppColors.textPrimaryDark,
      systemOverlayStyle: SystemUiOverlayStyle.light,
      centerTitle: true,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true, fillColor: AppColors.surfaceVariantDark,
      contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
      border: OutlineInputBorder(borderRadius: AppRadius.borderRadiusMd, borderSide: BorderSide.none),
      enabledBorder: OutlineInputBorder(borderRadius: AppRadius.borderRadiusMd, borderSide: const BorderSide(color: AppColors.borderDark)),
      focusedBorder: OutlineInputBorder(borderRadius: AppRadius.borderRadiusMd, borderSide: const BorderSide(color: AppColors.primaryLight, width: 1.5)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(style: ElevatedButton.styleFrom(
      elevation: 0, backgroundColor: AppColors.primaryLight, foregroundColor: AppColors.black,
      disabledBackgroundColor: AppColors.neutral800, minimumSize: const Size(double.infinity, 52),
      shape: RoundedRectangleBorder(borderRadius: AppRadius.borderRadiusMd),
    )),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: AppColors.surfaceDark,
      shape: RoundedRectangleBorder(borderRadius: AppRadius.topXl),
    ),
    dividerTheme: const DividerThemeData(color: AppColors.borderDark, thickness: 1, space: 1),
  );
}

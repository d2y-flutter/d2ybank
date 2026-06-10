import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';
import 'app_radius.dart';
import 'app_spacing.dart';

/// D2YBank Theme — "The Sovereign Fluidity"
///
/// RULES from Design Doc:
/// 1. NO standard 1px borders for sectioning — use tonal shifts
/// 2. NO pure black — use primary or onBackground
/// 3. NO standard Material shadows — use ambient primary-tinted
/// 4. Gradient CTAs with "metallic luster"
/// 5. Ghost borders on inputs (felt, not seen)
abstract final class AppTheme {
  static ThemeData get light => ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    fontFamily: 'PlusJakartaSans',
    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      primaryContainer: AppColors.primaryContainer,
      inversePrimary: AppColors.inversePrimary,
      secondary: AppColors.secondary,
      secondaryContainer: AppColors.secondaryContainer,
      tertiary: AppColors.tertiary,
      tertiaryContainer: AppColors.tertiaryContainer,
      error: AppColors.error,
      errorContainer: AppColors.errorContainer,
      surface: AppColors.surface,
      surfaceContainerLowest: AppColors.surfaceContainerLowest,
      surfaceContainerLow: AppColors.surfaceContainerLow,
      surfaceContainer: AppColors.surfaceContainer,
      surfaceContainerHigh: AppColors.surfaceContainerHigh,
      surfaceContainerHighest: AppColors.surfaceContainerHighest,
      onPrimary: AppColors.onPrimary,
      onSecondary: AppColors.onSecondary,
      onTertiary: AppColors.onTertiary,
      onSurface: AppColors.onSurface,
      onSurfaceVariant: AppColors.onSurfaceVariant,
      onError: AppColors.onError,
      outline: AppColors.outline,
      outlineVariant: AppColors.outlineVariant,
      inverseSurface: AppColors.inverseSurface,
      onInverseSurface: AppColors.inverseOnSurface,
      surfaceTint: AppColors.surfaceTint,
    ),
    scaffoldBackgroundColor: AppColors.surface,
    appBarTheme: AppBarTheme(
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: AppColors.white.withValues(alpha: 0.6),
      foregroundColor: AppColors.primary,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      centerTitle: false,
      titleTextStyle: AppTextStyles.titleLarge.copyWith(
        color: AppColors.primary,
        fontWeight: FontWeight.w800,
        letterSpacing: -0.5,
      ),
    ),
    // Cards: NO borders — tonal shift only
    cardTheme: CardThemeData(
      elevation: 0,
      color: AppColors.surfaceContainerLowest,
      shape: RoundedRectangleBorder(
        borderRadius: AppRadius.borderRadiusXl,
      ),
      margin: EdgeInsets.zero,
    ),
    // Input: Ghost border rule
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.surfaceContainerLow.withValues(alpha: 0.5),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.lg),
        borderSide: BorderSide(color: AppColors.ghostBorder),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.lg),
        borderSide: BorderSide(color: AppColors.ghostBorder),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.lg),
        borderSide: BorderSide(
          color: AppColors.primary.withValues(alpha: 0.2),
          width: 1.5,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.lg),
        borderSide: const BorderSide(color: AppColors.error),
      ),
      hintStyle: AppTextStyles.bodyMedium.copyWith(
        color: AppColors.outline.withValues(alpha: 0.5),
      ),
    ),
    // Primary button: gradient applied in component, theme provides shape
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.onPrimary,
        disabledBackgroundColor: AppColors.surfaceContainerHigh,
        disabledForegroundColor: AppColors.outline,
        minimumSize: const Size(double.infinity, 56),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
        ),
        textStyle: AppTextStyles.labelLarge,
      ),
    ),
    // Secondary button (Action Spark — money movement)
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primary,
        minimumSize: const Size(double.infinity, 56),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
        ),
        side: BorderSide(color: AppColors.primary.withValues(alpha: 0.1)),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primary,
        textStyle: AppTextStyles.labelLarge,
      ),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: AppColors.surfaceContainerLowest,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
    ),
    // Divider: Design doc says BANNED — but keep minimal for semantic use
    dividerTheme: DividerThemeData(
      color: AppColors.outlineVariant.withValues(alpha: 0.3),
      thickness: 0.5,
      space: 0.5,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.white,
      selectedItemColor: AppColors.secondary,
      unselectedItemColor: AppColors.outline,
      type: BottomNavigationBarType.fixed,
      elevation: 0,
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppColors.inverseSurface,
      contentTextStyle: AppTextStyles.bodyMedium.copyWith(
        color: AppColors.inverseOnSurface,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      behavior: SnackBarBehavior.floating,
    ),
    chipTheme: ChipThemeData(
      backgroundColor: AppColors.surfaceContainerLow,
      shape: const StadiumBorder(),
      side: BorderSide.none,
      labelStyle: AppTextStyles.labelSmall.copyWith(
        fontWeight: FontWeight.w800,
        letterSpacing: 1.5,
      ),
    ),
  );
}
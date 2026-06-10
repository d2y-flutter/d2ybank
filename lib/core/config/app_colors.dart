import 'package:flutter/material.dart';

/// D2YBank Color System — "The Sovereign Fluidity"
///
/// Mapped from Stitch/Tailwind HTML reference.
///
/// RULE: Never use pure black (#000000). Use [primary] or [onBackground].
/// RULE: No standard 1px borders — use tonal surface shifts instead.
abstract final class AppColors {
  // ═══════════════════════════════════════════════════════════
  // BRAND — Premium Green Banking
  // ═══════════════════════════════════════════════════════════

  /// Main brand green from HTML token: primary #003527
  static const Color primary = Color(0xFF003527);

  /// Premium green container from HTML token: primary-container #064E3B
  static const Color primaryContainer = Color(0xFF064E3B);

  /// Inverse primary / soft green highlight
  static const Color inversePrimary = Color(0xFF95D3BA);

  /// Light brand background
  static const Color primaryFixed = Color(0xFFB0F0D6);

  /// Dimmed light brand background
  static const Color primaryFixedDim = Color(0xFF95D3BA);

  /// Text/icons on primary surfaces
  static const Color onPrimary = Color(0xFFFFFFFF);

  /// Text on primary container
  static const Color onPrimaryContainer = Color(0xFF80BEA6);

  /// Deep text on primary fixed
  static const Color onPrimaryFixed = Color(0xFF002117);

  /// Variant text on primary fixed
  static const Color onPrimaryFixedVariant = Color(0xFF0B513D);

  /// Surface tint from HTML token: surface-tint #2B6954
  static const Color surfaceTint = Color(0xFF2B6954);

  // ═══════════════════════════════════════════════════════════
  // SECONDARY — Gold Accent / Premium Action Spark
  // ═══════════════════════════════════════════════════════════

  /// Gold/brown accent from HTML token: secondary #795900
  static const Color secondary = Color(0xFF795900);

  /// Gold highlight from HTML token: secondary-container #FFC329
  static const Color secondaryContainer = Color(0xFFFFC329);

  /// Light gold
  static const Color secondaryFixed = Color(0xFFFFDF9F);

  /// Dimmed gold
  static const Color secondaryFixedDim = Color(0xFFF9BD22);

  /// Text/icons on secondary surfaces
  static const Color onSecondary = Color(0xFFFFFFFF);

  /// Text on secondary container
  static const Color onSecondaryContainer = Color(0xFF6F5100);

  /// Deep text on secondary fixed
  static const Color onSecondaryFixed = Color(0xFF261A00);

  /// Variant text on secondary fixed
  static const Color onSecondaryFixedVariant = Color(0xFF5C4300);

  // ═══════════════════════════════════════════════════════════
  // TERTIARY — Dark Blue Grey Support Tone
  // ═══════════════════════════════════════════════════════════

  static const Color tertiary = Color(0xFF242F41);
  static const Color tertiaryContainer = Color(0xFF3A4558);
  static const Color tertiaryFixed = Color(0xFFD8E3FB);
  static const Color tertiaryFixedDim = Color(0xFFBCC7DE);
  static const Color onTertiary = Color(0xFFFFFFFF);
  static const Color onTertiaryContainer = Color(0xFFA7B2C9);
  static const Color onTertiaryFixed = Color(0xFF111C2D);
  static const Color onTertiaryFixedVariant = Color(0xFF3C475A);

  // ═══════════════════════════════════════════════════════════
  // SURFACE HIERARCHY
  // ═══════════════════════════════════════════════════════════

  /// Base layer from HTML token: surface #F8F9FA
  static const Color surface = Color(0xFFF8F9FA);

  /// Alias
  static const Color background = Color(0xFFF8F9FA);

  /// Bright surface
  static const Color surfaceBright = Color(0xFFF8F9FA);

  /// Dim surface
  static const Color surfaceDim = Color(0xFFD9DADB);

  /// Maximum pop surface
  static const Color surfaceContainerLowest = Color(0xFFFFFFFF);

  /// Low container from HTML token: surface-container-low #F3F4F5
  static const Color surfaceContainerLow = Color(0xFFF3F4F5);

  /// Standard container
  static const Color surfaceContainer = Color(0xFFEDEEEF);

  /// High container
  static const Color surfaceContainerHigh = Color(0xFFE7E8E9);

  /// Highest container / input surface
  static const Color surfaceContainerHighest = Color(0xFFE1E3E4);

  /// Surface variant / glass base
  static const Color surfaceVariant = Color(0xFFE1E3E4);

  /// Special page white from HTML body bg-[#FDFDFD]
  static const Color pageBackground = Color(0xFFFDFDFD);

  /// Premium input background from HTML bg-[#F8FAFB]
  static const Color inputBackground = Color(0xFFF8FAFB);

  /// Security badge background from HTML bg-[#F0F4F3]
  static const Color securityBadgeBackground = Color(0xFFF0F4F3);

  // ═══════════════════════════════════════════════════════════
  // TEXT / ON-SURFACE
  // ═══════════════════════════════════════════════════════════

  /// Primary text, not pure black
  static const Color onBackground = Color(0xFF191C1D);

  /// Alias
  static const Color onSurface = Color(0xFF191C1D);

  /// Secondary text
  static const Color onSurfaceVariant = Color(0xFF404944);

  /// Dark card surface
  static const Color inverseSurface = Color(0xFF2E3132);

  /// Text on dark card
  static const Color inverseOnSurface = Color(0xFFF0F1F2);

  // ═══════════════════════════════════════════════════════════
  // OUTLINE — Ghost Borders
  // ═══════════════════════════════════════════════════════════

  static const Color outline = Color(0xFF707974);
  static const Color outlineVariant = Color(0xFFBFC9C3);

  // ═══════════════════════════════════════════════════════════
  // ERROR
  // ═══════════════════════════════════════════════════════════

  static const Color error = Color(0xFFBA1A1A);
  static const Color errorContainer = Color(0xFFFFDAD6);
  static const Color onError = Color(0xFFFFFFFF);
  static const Color onErrorContainer = Color(0xFF93000A);

  // ═══════════════════════════════════════════════════════════
  // SEMANTIC ALIASES
  // ═══════════════════════════════════════════════════════════

  static const Color success = Color(0xFF003527);
  static const Color successLight = Color(0xFF95D3BA);
  static const Color warning = Color(0xFFF9BD22);
  static const Color warningLight = Color(0xFFFFDF9F);
  static const Color info = Color(0xFF2B6954);

  static const Color white = Color(0xFFFFFFFF);

  // ═══════════════════════════════════════════════════════════
  // SHIMMER
  // ═══════════════════════════════════════════════════════════

  static const Color shimmerBase = Color(0xFFE7E8E9);
  static const Color shimmerHighlight = Color(0xFFF3F4F5);

  // ═══════════════════════════════════════════════════════════
  // GRADIENT HELPERS
  // ═══════════════════════════════════════════════════════════

  /// Premium CTA gradient from HTML:
  /// linear-gradient(135deg, #064e3b 0%, #002117 100%)
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      primaryContainer,
      onPrimaryFixed,
    ],
  );

  /// Ambient shadow color — green-tinted, not grey
  static Color ambientShadow = onPrimaryFixed.withValues(alpha: 0.08);

  /// Premium CTA shadow from HTML rgba(6, 78, 59, 0.3)
  static Color ctaShadow = primaryContainer.withValues(alpha: 0.30);

  /// Focus ring from HTML rgba(6, 78, 59, 0.08)
  static Color focusRing = primaryContainer.withValues(alpha: 0.08);

  /// Glass background — 60% opacity + blur
  static Color glassBackground = surfaceVariant.withValues(alpha: 0.6);

  /// Glass inner stroke
  static Color glassStroke = surfaceContainerLowest.withValues(alpha: 0.3);

  /// Ghost border for inputs
  static Color ghostBorder = outlineVariant.withValues(alpha: 0.2);

  /// Soft card border
  static Color cardBorder = outlineVariant.withValues(alpha: 0.2);

  /// Input border from HTML outline-variant/40
  static Color inputBorder = outlineVariant.withValues(alpha: 0.4);

  /// Input divider from HTML outline-variant/30
  static Color inputDivider = outlineVariant.withValues(alpha: 0.3);
}
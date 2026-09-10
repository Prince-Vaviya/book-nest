import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_theme.dart';

class AppTypography {
  // Display & Headlines - Bricolage Grotesque
  static TextStyle displayLarge({Color color = AppColors.secondaryIndigo}) =>
      GoogleFonts.bricolageGrotesque(
        fontSize: 34,
        fontWeight: FontWeight.w800,
        letterSpacing: -0.8,
        height: 1.2,
        color: color,
      );

  static TextStyle displayMedium({Color color = AppColors.secondaryIndigo}) =>
      GoogleFonts.bricolageGrotesque(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.6,
        height: 1.25,
        color: color,
      );

  static TextStyle headlineLarge({Color color = AppColors.secondaryIndigo}) =>
      GoogleFonts.bricolageGrotesque(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.4,
        height: 1.3,
        color: color,
      );

  static TextStyle headlineMedium({Color color = AppColors.secondaryIndigo}) =>
      GoogleFonts.bricolageGrotesque(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.2,
        height: 1.35,
        color: color,
      );

  static TextStyle headlineSmall({Color color = AppColors.secondaryIndigo}) =>
      GoogleFonts.bricolageGrotesque(
        fontSize: 17,
        fontWeight: FontWeight.w600,
        letterSpacing: 0,
        height: 1.4,
        color: color,
      );

  // Body & Reading - Literata
  static TextStyle titleMedium({Color color = AppColors.textPrimary}) =>
      GoogleFonts.literata(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.2,
        height: 1.4,
        color: color,
      );

  static TextStyle bodyLarge({Color color = AppColors.textPrimary}) =>
      GoogleFonts.literata(
        fontSize: 17,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.1,
        height: 1.65,
        color: color,
      );

  static TextStyle bodyMedium({Color color = AppColors.textPrimary}) =>
      GoogleFonts.literata(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        height: 1.6,
        color: color,
      );

  static TextStyle bodySmall({Color color = AppColors.textSecondary}) =>
      GoogleFonts.literata(
        fontSize: 13,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.1,
        height: 1.5,
        color: color,
      );

  // Labels & Chips - Bricolage Grotesque
  static TextStyle labelLarge({Color color = AppColors.textPrimary}) =>
      GoogleFonts.bricolageGrotesque(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.2,
        color: color,
      );

  static TextStyle labelMedium({Color color = AppColors.textSecondary}) =>
      GoogleFonts.bricolageGrotesque(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.3,
        color: color,
      );

  static TextStyle labelSmall({Color color = AppColors.textMuted}) =>
      GoogleFonts.bricolageGrotesque(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.4,
        color: color,
      );

  static TextStyle quoteStyle({Color color = AppColors.tertiaryBrown}) =>
      GoogleFonts.literata(
        fontSize: 16,
        fontStyle: FontStyle.italic,
        fontWeight: FontWeight.w500,
        height: 1.55,
        color: color,
      );
}

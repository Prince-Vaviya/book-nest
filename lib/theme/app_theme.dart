import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  // Brand Archival Palette
  static const Color primaryAmber = Color(0xFFD97706);
  static const Color primaryDarkAmber = Color(0xFFB15F00);
  static const Color primaryLightAmber = Color(0xFFFFDCC3);
  static const Color primaryContainer = Color(0xFFB15F00);

  static const Color secondaryIndigo = Color(0xFF1E1B4B);
  static const Color secondaryLightIndigo = Color(0xFF5B598C);
  static const Color secondaryContainer = Color(0xFFC7C3FE);

  static const Color tertiaryBrown = Color(0xFF78350F);
  static const Color tertiaryLight = Color(0xFF904821);
  static const Color tertiaryContainer = Color(0xFFAF5F36);

  // Surface Tiers & Paper Spectrum
  static const Color canvasPaper = Color(0xFFFBF9F5);
  static const Color surfaceBackground = Color(0xFFF9F9FF);
  static const Color surfaceCard = Color(0xFFFFFFFF);
  static const Color surfaceRecessed = Color(0xFFF3EFE6);
  static const Color surfaceContainerLow = Color(0xFFF0F3FF);
  static const Color surfaceContainer = Color(0xFFE7EEFF);
  static const Color surfaceContainerHigh = Color(0xFFDEE8FF);
  static const Color surfaceContainerHighest = Color(0xFFD8E3FB);

  // Typography Tones
  static const Color textPrimary = Color(0xFF111C2D);
  static const Color textSecondary = Color(0xFF554336);
  static const Color textMuted = Color(0xFF887364);
  static const Color textInverse = Color(0xFFECF1FF);

  // Borders & Dividers
  static const Color borderSepia = Color(0xFFE7E0D2);
  static const Color borderLight = Color(0xFFEDE7DC);
  static const Color borderVariant = Color(0xFFDBC2B0);

  // Reader Modes
  static const Color readerCreamBg = Color(0xFFFBF9F5);
  static const Color readerCreamText = Color(0xFF1E293B);
  
  static const Color readerSepiaBg = Color(0xFFF4ECD8);
  static const Color readerSepiaText = Color(0xFF43302B);

  static const Color readerDarkBg = Color(0xFF1E1B4B);
  static const Color readerDarkText = Color(0xFFE2E8F0);

  static const Color readerAmoledBg = Color(0xFF0F172A);
  static const Color readerAmoledText = Color(0xFFE5E2E1);

  // Status & Accents
  static const Color ratingStar = Color(0xFFF59E0B);
  static const Color streakFlame = Color(0xFFEA580C);
  static const Color successGreen = Color(0xFF059669);
}

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.canvasPaper,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primaryAmber,
        primary: AppColors.primaryAmber,
        onPrimary: Colors.white,
        secondary: AppColors.secondaryIndigo,
        onSecondary: Colors.white,
        tertiary: AppColors.tertiaryBrown,
        surface: AppColors.surfaceCard,
        onSurface: AppColors.textPrimary,
        surfaceContainerLow: AppColors.surfaceContainerLow,
        surfaceContainer: AppColors.surfaceContainer,
        surfaceContainerHigh: AppColors.surfaceContainerHigh,
      ),
      fontFamily: GoogleFonts.bricolageGrotesque().fontFamily,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: AppColors.secondaryIndigo),
        titleTextStyle: TextStyle(
          color: AppColors.secondaryIndigo,
          fontSize: 22,
          fontWeight: FontWeight.w700,
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.surfaceCard,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppColors.borderLight, width: 1),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.surfaceRecessed,
        side: const BorderSide(color: AppColors.borderSepia, width: 1),
        labelStyle: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 13,
          fontWeight: FontWeight.w600,
          fontFamily: GoogleFonts.bricolageGrotesque().fontFamily,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        shape: const StadiumBorder(),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryAmber,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: const StadiumBorder(),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          textStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            fontFamily: GoogleFonts.bricolageGrotesque().fontFamily,
            letterSpacing: 0.5,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.secondaryIndigo,
          side: const BorderSide(color: AppColors.secondaryIndigo, width: 1.5),
          shape: const StadiumBorder(),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          textStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            fontFamily: GoogleFonts.bricolageGrotesque().fontFamily,
          ),
        ),
      ),
    );
  }
}

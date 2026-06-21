import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Exact colors from Stitch CSS
  static const Color primary = Color(0xFF075FAB);
  static const Color primaryContainer = Color(0xFF5D9CEC);
  static const Color onPrimaryContainer = Color(0xFF003260);
  
  static const Color secondary = Color(0xFF845400);
  static const Color secondaryContainer = Color(0xFFFEB246);
  static const Color onSecondaryContainer = Color(0xFF6F4600);
  static const Color onSecondaryFixedVariant = Color(0xFF643F00);
  
  static const Color tertiary = Color(0xFF3A6A00);
  static const Color onTertiary = Color(0xFFFFFFFF);
  static const Color tertiaryContainer = Color(0xFF61AC00);
  static const Color onTertiaryContainer = Color(0xFF1C3900);
  
  static const Color error = Color(0xFFBA1A1A);
  static const Color errorContainer = Color(0xFFFFDAD6);
  
  static const Color surface = Color(0xFFF7F9FC);
  static const Color surfaceContainerLowest = Color(0xFFFFFFFF);
  static const Color surfaceContainerLow = Color(0xFFF2F4F7);
  static const Color surfaceContainer = Color(0xFFECEEF1);
  static const Color surfaceContainerHigh = Color(0xFFE6E8EB);
  static const Color surfaceContainerHighest = Color(0xFFE3E5E8);
  static const Color surfaceVariant = Color(0xFFE0E3E6);
  static const Color background = Color(0xFFF7F9FC);
  static const Color outline = Color(0xFF727782);
  static const Color outlineVariant = Color(0xFFC2C7CE);
  
  static const Color onSurface = Color(0xFF191C1E);
  static const Color onSurfaceVariant = Color(0xFF414751);
  
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color primaryFixed = Color(0xFFD3E4FF);
  static const Color primaryFixedDim = Color(0xFFB4C5FF);
  static const Color onPrimaryFixedVariant = Color(0xFF004787);
  
  static const Color secondaryFixed = Color(0xFFFFDDB1);
  static const Color onSecondaryFixed = Color(0xFF2F1500);
  static const Color tertiaryFixed = Color(0xFFB5F377);
  static const Color onTertiaryFixedVariant = Color(0xFF325300);
  
  static const Color onErrorContainer = Color(0xFF410002);

  static ThemeData get lightTheme {
    final baseTextTheme = Typography.material2021().black;
    
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: surface,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primary,
        primary: primary,
        primaryContainer: primaryContainer,
        onPrimaryContainer: onPrimaryContainer,
        secondary: secondary,
        secondaryContainer: secondaryContainer,
        onSecondaryContainer: onSecondaryContainer,
        tertiary: tertiary,
        tertiaryContainer: tertiaryContainer,
        onTertiaryContainer: onTertiaryContainer,
        surface: surface,
        surfaceContainerLowest: surfaceContainerLowest,
        surfaceContainerLow: surfaceContainerLow,
        surfaceContainer: surfaceContainer,
        surfaceContainerHigh: surfaceContainerHigh,
        error: error,
        errorContainer: errorContainer,
        onSurface: onSurface,
        onSurfaceVariant: onSurfaceVariant,
        outline: outline,
        brightness: Brightness.light,
      ),
      textTheme: baseTextTheme.copyWith(
        headlineLarge: GoogleFonts.plusJakartaSans(
          fontSize: 32,
          fontWeight: FontWeight.w700,
          height: 40 / 32,
          letterSpacing: -0.02 * 32,
          color: onSurface,
        ),
        headlineMedium: GoogleFonts.plusJakartaSans(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          height: 30 / 24,
          color: onSurface,
        ),
        bodyLarge: GoogleFonts.beVietnamPro(
          fontSize: 18,
          fontWeight: FontWeight.w400,
          height: 28 / 18,
          color: onSurfaceVariant,
        ),
        bodyMedium: GoogleFonts.beVietnamPro(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          height: 24 / 16,
          color: onSurfaceVariant,
        ),
        labelMedium: GoogleFonts.plusJakartaSans(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          height: 20 / 14,
          letterSpacing: 0.01 * 14,
          color: onSurface,
        ),
        labelSmall: GoogleFonts.plusJakartaSans(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          height: 16 / 12,
          color: onSurfaceVariant,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(9999),
          ),
          elevation: 2,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';

class AppTheme {
  static ThemeData get lightTheme {
    final colors = AppColors.light;

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: colors.background,
      colorScheme: ColorScheme.fromSeed(
        seedColor: colors.primaryGreen,
        brightness: Brightness.light,
        primary: colors.primaryGreen,
        surface: colors.cardSurface,
        onSurface: colors.textPrimary,
        outline: colors.cardBorder,
      ),
      textTheme: GoogleFonts.plusJakartaSansTextTheme().apply(
        bodyColor: colors.textPrimary,
        displayColor: colors.textPrimary,
      ),
      cardTheme: CardThemeData(
        color: colors.cardSurface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: colors.cardBorder, width: 1),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: colors.divider,
        thickness: 1,
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: colors.cardSurface,
        surfaceTintColor: Colors.transparent,
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: colors.cardSurface,
        surfaceTintColor: Colors.transparent,
      ),
    );
  }

  static ThemeData get darkTheme {
    final colors = AppColors.dark;

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: colors.background,
      colorScheme: ColorScheme.fromSeed(
        seedColor: colors.primaryGreen,
        brightness: Brightness.dark,
        primary: colors.primaryGreen,
        surface: colors.cardSurface,
        onSurface: colors.textPrimary,
        outline: colors.cardBorder,
      ),
      textTheme: GoogleFonts.plusJakartaSansTextTheme(ThemeData.dark().textTheme).apply(
        bodyColor: colors.textPrimary,
        displayColor: colors.textPrimary,
      ),
      cardTheme: CardThemeData(
        color: colors.cardSurface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: colors.cardBorder, width: 1),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: colors.divider,
        thickness: 1,
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: colors.cardSurface,
        surfaceTintColor: Colors.transparent,
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: colors.cardSurface,
        surfaceTintColor: Colors.transparent,
      ),
    );
  }
}
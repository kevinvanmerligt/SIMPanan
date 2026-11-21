import 'package:flutter/material.dart';

class AppColorScheme {
  final bool isDark;

  final Color background;
  final Color cardSurface;
  final Color cardBorder;
  final Color cardElevated;

  final Color primaryGreen;
  final Color primaryPillBg;
  final Color primaryGreenSurface;

  final Color expenseBg;
  final Color expenseIcon;

  final Color incomeBg;
  final Color incomeIcon;

  final Color textPrimary;
  final Color textSecondary;
  final Color textMuted;

  final Color chartEmpty;
  final Color inputBg;
  final Color divider;

  final Color heroCardBg;
  final Color heroCardBorder;
  final Color heroCardPillBg;

  const AppColorScheme({
    required this.isDark,
    required this.background,
    required this.cardSurface,
    required this.cardBorder,
    required this.cardElevated,
    required this.primaryGreen,
    required this.primaryPillBg,
    required this.primaryGreenSurface,
    required this.expenseBg,
    required this.expenseIcon,
    required this.incomeBg,
    required this.incomeIcon,
    required this.textPrimary,
    required this.textSecondary,
    required this.textMuted,
    required this.chartEmpty,
    required this.inputBg,
    required this.divider,
    required this.heroCardBg,
    required this.heroCardBorder,
    required this.heroCardPillBg,
  });
}

class AppColors {
  static const light = AppColorScheme(
    isDark: false,
    background: Color(0xFFF8FAFC),
    cardSurface: Color(0xFFFFFFFF),
    cardBorder: Color(0xFFE2E8F0),
    cardElevated: Color(0xFFFFFFFF),
    primaryGreen: Color(0xFF047857),
    primaryPillBg: Color(0xFFECFDF5),
    primaryGreenSurface: Color(0xFFD1FAE5),
    expenseBg: Color(0xFFFEF2F2),
    expenseIcon: Color(0xFFDC2626),
    incomeBg: Color(0xFFECFDF5),
    incomeIcon: Color(0xFF059669),
    textPrimary: Color(0xFF0F172A),
    textSecondary: Color(0xFF475569),
    textMuted: Color(0xFF94A3B8),
    chartEmpty: Color(0xFFE2E8F0),
    inputBg: Color(0xFFF1F5F9),
    divider: Color(0xFFE2E8F0),
    heroCardBg: Color(0xFF047857),
    heroCardBorder: Colors.transparent,
    heroCardPillBg: Color(0x33FFFFFF),
  );

  static const dark = AppColorScheme(
    isDark: true,
    background: Color(0xFF0F1115),
    cardSurface: Color(0xFF181B20),
    cardBorder: Color(0xFF262A32),
    cardElevated: Color(0xFF1E2228),
    primaryGreen: Color(0xFF10B981),
    primaryPillBg: Color(0xFF064E3B),
    primaryGreenSurface: Color(0xFF064E3B),
    expenseBg: Color(0xFF3F191B),
    expenseIcon: Color(0xFFF87171),
    incomeBg: Color(0xFF064E3B),
    incomeIcon: Color(0xFF34D399),
    textPrimary: Color(0xFFF8FAFC),
    textSecondary: Color(0xFF94A3B8),
    textMuted: Color(0xFF64748B),
    chartEmpty: Color(0xFF262A32),
    inputBg: Color(0xFF121418),
    divider: Color(0xFF262A32),
    heroCardBg: Color(0xFF161E1A),
    heroCardBorder: Color(0xFF23322B),
    heroCardPillBg: Color(0xFF1E2A24),
  );

  static AppColorScheme of(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return isDarkMode ? dark : light;
  }

  static const Color background = Color(0xFFF8FAFC);
  static const Color cardSurface = Color(0xFFFFFFFF);
  static const Color cardBorder = Color(0xFFE2E8F0);
  static const Color primaryGreen = Color(0xFF047857);
  static const Color primaryPillBg = Color(0xFFECFDF5);
  static const Color expenseBg = Color(0xFFFEF2F2);
  static const Color expenseIcon = Color(0xFFDC2626);
  static const Color incomeBg = Color(0xFFECFDF5);
  static const Color incomeIcon = Color(0xFF059669);
  static const Color textPrimary = Color(0xFF0F172A);
  static const Color textSecondary = Color(0xFF475569);
  static const Color textMuted = Color(0xFF94A3B8);
  static const Color chartEmpty = Color(0xFFE2E8F0);
}

extension AppColorsExtension on BuildContext {
  AppColorScheme get colors => AppColors.of(this);
}

import 'package:flutter/material.dart';

/// Skema warna yang mendukung mode Terang (Light) dan Gelap (Dark).
/// - Pada tema Terang: Palet hijau dibuat LEBIH GELAP (kontras tinggi di background terang).
/// - Pada tema Gelap: Palet hijau dibuat LEBIH TERANG (vibrant & bercahaya di background gelap).
class AppColorScheme {
  final bool isDark;

  // Background & Kartu
  final Color background;
  final Color cardSurface;
  final Color cardBorder;
  final Color cardElevated;

  // Warna Utama (Hero Card & Navigasi Aktif)
  final Color primaryGreen;
  final Color primaryPillBg;
  final Color primaryGreenSurface;

  // Aksen Pengeluaran
  final Color expenseBg;
  final Color expenseIcon;

  // Aksen Pemasukan
  final Color incomeBg;
  final Color incomeIcon;

  // Tipografi / Teks
  final Color textPrimary;
  final Color textSecondary;
  final Color textMuted;

  // Indikator Grafik & Input
  final Color chartEmpty;
  final Color inputBg;
  final Color divider;

  // Hero Saldo Card Styling
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
  // ==========================================
  // PALET TEMA TERANG (LIGHT THEME)
  // Palet hijau dibuat LEBIH GELAP & deep
  // ==========================================
  static const light = AppColorScheme(
    isDark: false,
    background: Color(0xFFF5F7F5),
    cardSurface: Color(0xFFFFFFFF),
    cardBorder: Color(0xFFE2E7E3),
    cardElevated: Color(0xFFFFFFFF),
    // Hijau lebih gelap di tema terang:
    primaryGreen: Color(0xFF094A29),
    primaryPillBg: Color(0x1A094A29), // Hijau tua transparan 10%
    primaryGreenSurface: Color(0xFFE4F0E8),
    expenseBg: Color(0xFFFDECE5),
    expenseIcon: Color(0xFFB8451F),
    incomeBg: Color(0xFFDCF2E4),
    incomeIcon: Color(0xFF0D5E34),
    textPrimary: Color(0xFF101712),
    textSecondary: Color(0xFF5A675F),
    textMuted: Color(0xFF8B9990),
    chartEmpty: Color(0xFFE1E7E3),
    inputBg: Color(0xFFF0F3F1),
    divider: Color(0xFFE5EAE6),
    heroCardBg: Color(0xFF094A29),
    heroCardBorder: Colors.transparent,
    heroCardPillBg: Color(0x28FFFFFF),
  );

  // ==========================================
  // PALET TEMA GELAP (DARK THEME)
  // Palet hijau dibuat LEBIH TERANG & vibrant
  // ==========================================
  static const dark = AppColorScheme(
    isDark: true,
    background: Color(0xFF0F1411),
    cardSurface: Color(0xFF17201B),
    cardBorder: Color(0xFF243028),
    cardElevated: Color(0xFF1D2822),
    // Hijau lebih terang di tema gelap (emerald vibrant neon-mint):
    primaryGreen: Color(0xFF2BD980),
    primaryPillBg: Color(0x282BD980), // Hijau terang transparan 16%
    primaryGreenSurface: Color(0xFF123422),
    expenseBg: Color(0xFF381F19),
    expenseIcon: Color(0xFFFF7A59),
    incomeBg: Color(0xFF133624),
    incomeIcon: Color(0xFF2BD980),
    textPrimary: Color(0xFFF2F6F3),
    textSecondary: Color(0xFFA1AEA6),
    textMuted: Color(0xFF6B7B72),
    chartEmpty: Color(0xFF24332A),
    inputBg: Color(0xFF121814),
    divider: Color(0xFF233027),
    heroCardBg: Color(0xFF132D20),
    heroCardBorder: Color(0x452BD980),
    heroCardPillBg: Color(0x2E2BD980),
  );

  /// Helper untuk mendapatkan skema warna aktif berdasarkan Theme/Brightness saat ini
  static AppColorScheme of(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return isDarkMode ? dark : light;
  }

  // ==========================================
  // Backward compatibility static constants (default fallback)
  // ==========================================
  static const Color background = Color(0xFFF5F7F5);
  static const Color cardSurface = Color(0xFFFFFFFF);
  static const Color cardBorder = Color(0xFFE2E7E3);
  static const Color primaryGreen = Color(0xFF094A29);
  static const Color primaryPillBg = Color(0x1A094A29);
  static const Color expenseBg = Color(0xFFFDECE5);
  static const Color expenseIcon = Color(0xFFB8451F);
  static const Color incomeBg = Color(0xFFDCF2E4);
  static const Color incomeIcon = Color(0xFF0D5E34);
  static const Color textPrimary = Color(0xFF101712);
  static const Color textSecondary = Color(0xFF5A675F);
  static const Color textMuted = Color(0xFF8B9990);
  static const Color chartEmpty = Color(0xFFE1E7E3);
}

extension AppColorsExtension on BuildContext {
  AppColorScheme get colors => AppColors.of(this);
}
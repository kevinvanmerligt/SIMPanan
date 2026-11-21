import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/utils/currency_format.dart';
import '../../../core/utils/date_format_id.dart';
import '../../../data/models/daily_summary_model.dart';

class HeroSaldoCard extends StatelessWidget {
  final DailySummaryModel summary;
  final int totalSavings;

  const HeroSaldoCard({
    super.key,
    required this.summary,
    this.totalSavings = 0,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final tanggalHariIni = DateFormatId.formatHariTanggal(DateTime.now());
    final netTotalSavings = totalSavings - summary.totalDebt;
    final isNegative = netTotalSavings < 0;
    final isZero = netTotalSavings == 0;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isNegative ? null : (isZero ? colors.heroZeroBg : colors.heroCardBg),
        gradient: isNegative
            ? LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  colors.heroNegativeGradientStart,
                  colors.heroNegativeGradientEnd,
                ],
              )
            : null,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isNegative
              ? colors.heroNegativeBorder
              : (colors.isDark ? colors.heroCardBorder : Colors.transparent),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: isNegative
                ? (colors.isDark
                    ? Colors.black.withValues(alpha: 0.45)
                    : colors.heroNegativeGradientStart.withValues(alpha: 0.28))
                : (colors.isDark
                    ? Colors.black.withValues(alpha: 0.35)
                    : (isZero
                        ? colors.heroZeroBg.withValues(alpha: 0.18)
                        : colors.primaryGreen.withValues(alpha: 0.18))),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.calendar_today_outlined,
                    color: (isNegative || !colors.isDark)
                        ? Colors.white.withValues(alpha: 0.85)
                        : colors.textSecondary,
                    size: 15,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    tanggalHariIni,
                    style: TextStyle(
                      color: (isNegative || !colors.isDark)
                          ? Colors.white
                          : colors.textSecondary,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: isNegative
                      ? Colors.black.withValues(alpha: 0.25)
                      : colors.heroCardPillBg,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isNegative
                        ? Colors.white.withValues(alpha: 0.3)
                        : (colors.isDark ? colors.cardBorder : Colors.white.withValues(alpha: 0.25)),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      summary.remainingBalance >= 0
                          ? Icons.trending_up_rounded
                          : Icons.trending_down_rounded,
                      color: isNegative
                          ? Colors.white
                          : (colors.isDark
                              ? (summary.remainingBalance >= 0 ? colors.primaryGreen : colors.expenseIcon)
                              : (summary.remainingBalance >= 0 ? Colors.white : const Color(0xFFFECACA))),
                      size: 14,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Hari ini: ${summary.remainingBalance >= 0 ? '+' : ''}${CurrencyFormat.toRupiah(summary.remainingBalance)}',
                      style: TextStyle(
                        color: isNegative
                            ? Colors.white
                            : (colors.isDark
                                ? colors.textPrimary
                                : (summary.remainingBalance >= 0 ? Colors.white : const Color(0xFFFECACA))),
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),

          Row(
            children: [
              Text(
                isNegative ? 'Defisit Tabungan (Tanggungan Hutang)' : 'Total Saldo Tabungan',
                style: TextStyle(
                  color: (isNegative || !colors.isDark)
                      ? Colors.white.withValues(alpha: 0.95)
                      : colors.textSecondary,
                  fontSize: 13,
                  fontWeight: isNegative ? FontWeight.w700 : FontWeight.w600,
                ),
              ),
              if (isNegative) ...[
                const SizedBox(width: 6),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.35),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: Colors.white.withValues(alpha: 0.5)),
                  ),
                  child: const Text(
                    'MINUS',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 4),
          Text(
            CurrencyFormat.toRupiah(netTotalSavings),
            style: TextStyle(
              color: (isNegative || !colors.isDark) ? Colors.white : colors.textPrimary,
              fontSize: 34,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            summary.totalDebt > 0
                ? 'Dipotong total kewajiban hutang aktif (${CurrencyFormat.toRupiah(summary.totalDebt)})'
                : 'Akumulasi seluruh tabungan yang tersimpan selama ini',
            style: TextStyle(
              color: (isNegative || !colors.isDark)
                  ? Colors.white.withValues(alpha: 0.85)
                  : colors.textMuted,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 18),

          Divider(
            color: (isNegative || !colors.isDark)
                ? Colors.white.withValues(alpha: 0.25)
                : colors.divider,
            height: 1,
          ),
          const SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.pemasukan,
                      style: TextStyle(
                        color: isNegative
                            ? Colors.white.withValues(alpha: 0.85)
                            : (colors.isDark ? colors.primaryGreen : const Color(0xFFA7F3D0)),
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      CurrencyFormat.toRupiah(summary.totalIncome),
                      style: TextStyle(
                        color: (isNegative || !colors.isDark) ? Colors.white : colors.textPrimary,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.pengeluaran,
                      style: TextStyle(
                        color: isNegative
                            ? Colors.white.withValues(alpha: 0.85)
                            : (colors.isDark ? colors.expenseIcon : const Color(0xFFFECACA)),
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      CurrencyFormat.toRupiah(summary.totalExpense),
                      style: TextStyle(
                        color: (isNegative || !colors.isDark) ? Colors.white : colors.textPrimary,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              if (summary.totalDebt > 0)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hutang',
                        style: TextStyle(
                          color: isNegative
                              ? Colors.white.withValues(alpha: 0.85)
                              : (colors.isDark ? colors.expenseIcon : const Color(0xFFFECACA)),
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        CurrencyFormat.toRupiah(summary.totalDebt),
                        style: TextStyle(
                          color: isNegative
                              ? Colors.white
                              : (colors.isDark ? colors.expenseIcon : const Color(0xFFFECACA)),
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

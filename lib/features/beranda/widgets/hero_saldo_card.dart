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

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colors.heroCardBg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: colors.heroCardBorder,
          width: colors.isDark ? 1.5 : 0,
        ),
        boxShadow: [
          BoxShadow(
            color: colors.isDark
                ? colors.primaryGreen.withValues(alpha: 0.12)
                : colors.primaryGreen.withValues(alpha: 0.2),
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
                    color: colors.isDark ? colors.textSecondary : Colors.white70,
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    tanggalHariIni,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: colors.heroCardPillBg,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.savings_rounded,
                      color: colors.isDark ? colors.primaryGreen : Colors.white,
                      size: 13,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Total: ${CurrencyFormat.toRupiah(totalSavings)}',
                      style: TextStyle(
                        color: colors.isDark ? colors.primaryGreen : Colors.white,
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

          Text(
            AppStrings.sisaSaldoHariIni,
            style: TextStyle(
              color: colors.isDark ? colors.textSecondary : Colors.white70,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            CurrencyFormat.toRupiah(summary.remainingBalance),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 34,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Total ${summary.transactionCount} transaksi tercatat hari ini',
            style: TextStyle(
              color: colors.isDark ? colors.textSecondary : Colors.white70,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 18),

          Divider(
            color: colors.isDark
                ? colors.primaryGreen.withValues(alpha: 0.2)
                : Colors.white.withValues(alpha: 0.15),
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
                        color: colors.isDark ? colors.primaryGreen : Colors.white70,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      CurrencyFormat.toRupiah(summary.totalIncome),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
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
                        color: colors.isDark ? const Color(0xFFFF9478) : Colors.white70,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      CurrencyFormat.toRupiah(summary.totalExpense),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
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

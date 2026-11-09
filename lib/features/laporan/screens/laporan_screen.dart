import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/currency_format.dart';
import '../../../core/widgets/app_header.dart';
import '../../../core/widgets/fade_slide_entrance.dart';
import '../../../providers/finance_provider.dart';
import '../../beranda/widgets/tabungan_detail_modal.dart';

class LaporanScreen extends StatelessWidget {
  const LaporanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Consumer<FinanceProvider>(
      builder: (context, provider, _) {
        final Map<String, int> categoryTotals = {};
        int totalExpense = 0;

        for (final tx in provider.allTransactions) {
          if (tx.type == 'EXPENSE') {
            categoryTotals[tx.category] = (categoryTotals[tx.category] ?? 0) + tx.amount;
            totalExpense += tx.amount;
          }
        }

        final tabunganList = provider.allTabungan;
        final totalSavings = provider.totalSavingsBalance;

        return ListView(
          padding: const EdgeInsets.all(16),
          physics: const BouncingScrollPhysics(),
          children: [
            const FadeSlideEntrance(
              delayMs: 0,
              child: SimpananAppHeader(),
            ),
            const SizedBox(height: 18),
            FadeSlideEntrance(
              delayMs: 40,
              child: Text(
                'Laporan Keuangan',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: colors.textPrimary,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // 1. Distribusi Saldo Tabungan
            FadeSlideEntrance(
              delayMs: 80,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: colors.cardSurface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: colors.cardBorder),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Seluruh Tabungan',
                          style: TextStyle(color: colors.textSecondary, fontSize: 13),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: colors.primaryPillBg,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            '${tabunganList.length} Kantong',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: colors.primaryGreen,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      CurrencyFormat.toRupiah(totalSavings),
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        color: colors.primaryGreen,
                      ),
                    ),
                    const SizedBox(height: 18),
                    Text(
                      'Distribusi Kantong Tabungan',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                        color: colors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ...tabunganList.map((tab) {
                      final ratio = totalSavings > 0 ? (tab.currentBalance / totalSavings).clamp(0.0, 1.0) : 0.0;
                      return InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (_) => TabunganDetailModal(tabunganId: tab.id ?? 1),
                          );
                        },
                        borderRadius: BorderRadius.circular(10),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(tab.iconData, size: 16, color: tab.color),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      tab.name,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 13,
                                        color: colors.textPrimary,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    CurrencyFormat.toRupiah(tab.currentBalance),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 13,
                                      color: tab.color,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: TweenAnimationBuilder<double>(
                                  tween: Tween<double>(begin: 0.0, end: ratio),
                                  duration: const Duration(milliseconds: 600),
                                  curve: Curves.easeOutCubic,
                                  builder: (context, val, _) {
                                    return LinearProgressIndicator(
                                      value: val,
                                      minHeight: 6,
                                      backgroundColor: colors.inputBg,
                                      color: tab.color,
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 18),

            // 2. Laporan Pengeluaran
            FadeSlideEntrance(
              delayMs: 120,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: colors.cardSurface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: colors.cardBorder),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Seluruh Pengeluaran',
                      style: TextStyle(color: colors.textSecondary, fontSize: 13),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      CurrencyFormat.toRupiah(totalExpense),
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        color: colors.expenseIcon,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Rincian Pengeluaran per Kategori',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                        color: colors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 12),
                    if (categoryTotals.isEmpty)
                      Text(
                        'Belum ada data pengeluaran.',
                        style: TextStyle(color: colors.textSecondary),
                      )
                    else
                      ...categoryTotals.entries.map((entry) {
                        final percent = totalExpense > 0 ? entry.value / totalExpense : 0.0;
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 14),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    entry.key,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: colors.textPrimary,
                                    ),
                                  ),
                                  Text(
                                    CurrencyFormat.toRupiah(entry.value),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: colors.textPrimary,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: TweenAnimationBuilder<double>(
                                  tween: Tween<double>(begin: 0.0, end: percent),
                                  duration: const Duration(milliseconds: 600),
                                  curve: Curves.easeOutCubic,
                                  builder: (context, val, _) {
                                    return LinearProgressIndicator(
                                      value: val,
                                      minHeight: 8,
                                      backgroundColor: colors.chartEmpty,
                                      color: colors.primaryGreen,
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

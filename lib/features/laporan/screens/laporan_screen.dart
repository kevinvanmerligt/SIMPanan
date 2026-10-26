import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/currency_format.dart';
import '../../../core/widgets/app_header.dart';
import '../../../core/widgets/fade_slide_entrance.dart';
import '../../../providers/finance_provider.dart';

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

        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const FadeSlideEntrance(
              delayMs: 0,
              child: SimpananAppHeader(),
            ),
            const SizedBox(height: 18),
            FadeSlideEntrance(
              delayMs: 40,
              child: Text(
                'Laporan Pengeluaran',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: colors.textPrimary,
                ),
              ),
            ),
            const SizedBox(height: 16),
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
                      'Rincian per Kategori',
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
                                child: LinearProgressIndicator(
                                  value: percent,
                                  minHeight: 8,
                                  backgroundColor: colors.chartEmpty,
                                  color: colors.primaryGreen,
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
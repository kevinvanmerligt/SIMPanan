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
            const FadeSlideEntrance(
              delayMs: 40,
              child: Text(
                'Laporan Pengeluaran',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
              ),
            ),
            const SizedBox(height: 16),
            FadeSlideEntrance(
              delayMs: 80,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.cardBorder),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  const Text(
                    'Total Seluruh Pengeluaran',
                    style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    CurrencyFormat.toRupiah(totalExpense),
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      color: AppColors.expenseIcon,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Rincian per Kategori',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                  ),
                  const SizedBox(height: 12),
                  if (categoryTotals.isEmpty)
                    const Text('Belum ada data pengeluaran.')
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
                                  style: const TextStyle(fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  CurrencyFormat.toRupiah(entry.value),
                                  style: const TextStyle(fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: LinearProgressIndicator(
                                value: percent,
                                minHeight: 8,
                                backgroundColor: AppColors.chartEmpty,
                                color: AppColors.primaryGreen,
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
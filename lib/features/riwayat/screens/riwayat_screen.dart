import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/currency_format.dart';
import '../../../core/utils/date_format_id.dart';
import '../../../core/widgets/app_header.dart';
import '../../../core/widgets/fade_slide_entrance.dart';
import '../../../providers/finance_provider.dart';

class RiwayatScreen extends StatefulWidget {
  const RiwayatScreen({super.key});

  @override
  State<RiwayatScreen> createState() => _RiwayatScreenState();
}

class _RiwayatScreenState extends State<RiwayatScreen> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Consumer<FinanceProvider>(
      builder: (context, provider, _) {
        final filtered = provider.allTransactions.where((tx) {
          final q = _searchQuery.toLowerCase();
          return tx.title.toLowerCase().contains(q) ||
              tx.category.toLowerCase().contains(q);
        }).toList();

        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const FadeSlideEntrance(
                delayMs: 0,
                child: SimpananAppHeader(),
              ),
              const SizedBox(height: 18),
              FadeSlideEntrance(
                delayMs: 40,
                child: Text(
                  'Riwayat Transaksi',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: colors.textPrimary,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              FadeSlideEntrance(
                delayMs: 80,
                child: TextField(
                  onChanged: (val) => setState(() => _searchQuery = val),
                  style: TextStyle(color: colors.textPrimary),
                  decoration: InputDecoration(
                    hintText: 'Cari catatan transaksi...',
                    hintStyle: TextStyle(color: colors.textMuted),
                    prefixIcon: Icon(Icons.search, color: colors.textSecondary),
                    filled: true,
                    fillColor: colors.cardSurface,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide(color: colors.cardBorder),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide(color: colors.cardBorder),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide(color: colors.primaryGreen, width: 1.5),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: filtered.isEmpty
                    ? Center(
                        child: Text(
                          _searchQuery.isEmpty
                              ? 'Belum ada transaksi tercatat'
                              : 'Tidak ada transaksi yang cocok',
                          style: TextStyle(color: colors.textSecondary),
                        ),
                      )
                    : ListView.separated(
                        itemCount: filtered.length,
                        separatorBuilder: (_, _) => const SizedBox(height: 8),
                        itemBuilder: (context, index) {
                          final tx = filtered[index];
                          final isExpense = tx.type == 'EXPENSE';
                          return Container(
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: colors.cardSurface,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: colors.cardBorder),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: colors.isDark ? 0.2 : 0.02),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: isExpense ? colors.expenseBg : colors.incomeBg,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Icon(
                                    isExpense ? Icons.remove : Icons.arrow_upward,
                                    color: isExpense ? colors.expenseIcon : colors.incomeIcon,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        tx.title,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: colors.textPrimary,
                                        ),
                                      ),
                                      Text(
                                        '${tx.category} · ${DateFormatId.formatHariTanggal(tx.date)}',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: colors.textSecondary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  '${isExpense ? '-' : '+'}${CurrencyFormat.toRupiah(tx.amount)}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: isExpense ? colors.expenseIcon : colors.incomeIcon,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}
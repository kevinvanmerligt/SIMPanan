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
  int? _filterTabunganId;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Consumer<FinanceProvider>(
      builder: (context, provider, _) {
        final allTabungan = provider.allTabungan;

        final filtered = provider.allTransactions.where((tx) {
          if (_filterTabunganId != null && tx.tabunganId != _filterTabunganId) {
            return false;
          }
          final q = _searchQuery.toLowerCase();
          return tx.title.toLowerCase().contains(q) ||
              tx.category.toLowerCase().contains(q) ||
              tx.tabunganName.toLowerCase().contains(q);
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
                delayMs: 60,
                child: TextField(
                  onChanged: (val) => setState(() => _searchQuery = val),
                  style: TextStyle(color: colors.textPrimary),
                  decoration: InputDecoration(
                    hintText: 'Cari judul, kategori, atau tabungan...',
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
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: colors.primaryGreen, width: 1.5),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              FadeSlideEntrance(
                delayMs: 80,
                child: SizedBox(
                  height: 38,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemCount: allTabungan.length + 1,
                    separatorBuilder: (_, _) => const SizedBox(width: 8),
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        final isSelected = _filterTabunganId == null;
                        return ChoiceChip(
                          label: const Text('Semua'),
                          selected: isSelected,
                          selectedColor: colors.primaryGreen,
                          backgroundColor: colors.inputBg,
                          checkmarkColor: colors.isDark ? const Color(0xFF0F1411) : Colors.white,
                          side: BorderSide(
                            color: isSelected ? colors.primaryGreen : colors.cardBorder,
                          ),
                          labelStyle: TextStyle(
                            color: isSelected
                                ? (colors.isDark ? const Color(0xFF0F1411) : Colors.white)
                                : colors.textPrimary,
                            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                            fontSize: 12,
                          ),
                          onSelected: (_) => setState(() => _filterTabunganId = null),
                        );
                      }
                      final t = allTabungan[index - 1];
                      final isSelected = _filterTabunganId == t.id;
                      return ChoiceChip(
                        avatar: Icon(
                          t.iconData,
                          size: 14,
                          color: isSelected
                              ? (colors.isDark ? const Color(0xFF0F1411) : Colors.white)
                              : t.color,
                        ),
                        label: Text(t.name),
                        selected: isSelected,
                        selectedColor: colors.primaryGreen,
                        backgroundColor: colors.inputBg,
                        checkmarkColor: colors.isDark ? const Color(0xFF0F1411) : Colors.white,
                        side: BorderSide(
                          color: isSelected ? colors.primaryGreen : colors.cardBorder,
                        ),
                        labelStyle: TextStyle(
                          color: isSelected
                              ? (colors.isDark ? const Color(0xFF0F1411) : Colors.white)
                              : colors.textPrimary,
                          fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                          fontSize: 12,
                        ),
                        onSelected: (_) => setState(() => _filterTabunganId = t.id),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 14),
              Expanded(
                child: filtered.isEmpty
                    ? Center(
                        child: Text(
                          _searchQuery.isEmpty && _filterTabunganId == null
                              ? 'Belum ada transaksi tercatat'
                              : 'Tidak ada transaksi yang cocok',
                          style: TextStyle(color: colors.textSecondary),
                        ),
                      )
                    : ListView.separated(
                        physics: const BouncingScrollPhysics(),
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
                                      const SizedBox(height: 3),
                                      Row(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1.5),
                                            decoration: BoxDecoration(
                                              color: colors.inputBg,
                                              borderRadius: BorderRadius.circular(4),
                                            ),
                                            child: Text(
                                              tx.tabunganName,
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w600,
                                                color: colors.primaryGreen,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 6),
                                          Expanded(
                                            child: Text(
                                              '${tx.category} · ${DateFormatId.formatHariTanggal(tx.date)}',
                                              style: TextStyle(
                                                fontSize: 11,
                                                color: colors.textSecondary,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
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

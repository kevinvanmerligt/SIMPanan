import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/utils/currency_format.dart';
import '../../../data/models/transaction_model.dart';

class TransaksiHariIniList extends StatelessWidget {
  final int totalCount;
  final String selectedFilter;
  final ValueChanged<String> onFilterChanged;
  final List<TransactionModel> transactions;
  final ValueChanged<int> onDelete;

  const TransaksiHariIniList({
    super.key,
    required this.totalCount,
    required this.selectedFilter,
    required this.onFilterChanged,
    required this.transactions,
    required this.onDelete,
  });

  static const List<String> _tabs = ['Semua', 'Pemasukan', 'Pengeluaran'];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header Transaksi Hari Ini
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              AppStrings.transaksiHariIni,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            Text(
              '$totalCount catatan',
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),

        // Segmented Control dengan Animasi Sliding Pill Halus
        LayoutBuilder(
          builder: (context, constraints) {
            final double availableWidth = constraints.maxWidth - 8;
            final double tabWidth = availableWidth / _tabs.length;
            final int activeIndex = _tabs.indexOf(selectedFilter).clamp(0, _tabs.length - 1);

            return Container(
              height: 48,
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: const Color(0xFFF0F2F1),
                borderRadius: BorderRadius.circular(28),
                border: Border.all(color: AppColors.cardBorder.withValues(alpha: 0.6)),
              ),
              child: Stack(
                children: [
                  // Pill Putih Aktif yang Meluncur Halus (Curves.easeOutCubic)
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 260),
                    curve: Curves.easeOutCubic,
                    left: activeIndex * tabWidth,
                    top: 0,
                    width: tabWidth,
                    bottom: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.08),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Tab Items Tetap Proporsional (Tidak Mengecil / Memaksa Scroll)
                  Row(
                    children: _tabs.map((tab) {
                      final isSelected = selectedFilter == tab;
                      return Expanded(
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () => onFilterChanged(tab),
                          child: Center(
                            child: AnimatedDefaultTextStyle(
                              duration: const Duration(milliseconds: 200),
                              curve: Curves.easeOutCubic,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                                color: isSelected ? AppColors.textPrimary : AppColors.textSecondary,
                                letterSpacing: -0.1,
                              ),
                              child: Text(tab),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            );
          },
        ),
        const SizedBox(height: 16),

        // Kontainer Transaksi dengan Animasi Transisi Halus (Tidak Menjepret Layar)
        AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
          alignment: Alignment.topCenter,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            switchInCurve: Curves.easeOutCubic,
            switchOutCurve: Curves.easeInCubic,
            transitionBuilder: (child, animation) {
              return FadeTransition(
                opacity: animation,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0.0, 0.03),
                    end: Offset.zero,
                  ).animate(animation),
                  child: child,
                ),
              );
            },
            child: transactions.isEmpty
                ? Container(
                    key: ValueKey('empty_$selectedFilter'),
                    width: double.infinity,
                    constraints: const BoxConstraints(minHeight: 140),
                    padding: const EdgeInsets.all(28),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.cardBorder),
                    ),
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.receipt_long_outlined,
                          size: 36,
                          color: AppColors.textSecondary.withValues(alpha: 0.4),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Belum ada catatan $selectedFilter hari ini',
                          style: const TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.separated(
                    key: ValueKey('list_${selectedFilter}_${transactions.length}'),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: transactions.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      final tx = transactions[index];
                      final isExpense = tx.type == 'EXPENSE';

                      return Dismissible(
                        key: ValueKey('tx_${tx.id}_$index'),
                        direction: DismissDirection.endToStart,
                        onDismissed: (_) {
                          if (tx.id != null) onDelete(tx.id!);
                        },
                        background: Container(
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 20),
                          decoration: BoxDecoration(
                            color: AppColors.expenseIcon,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Icon(Icons.delete_outline, color: Colors.white),
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: AppColors.cardBorder),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.02),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 42,
                                height: 42,
                                decoration: BoxDecoration(
                                  color: isExpense ? AppColors.expenseBg : AppColors.incomeBg,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(
                                  isExpense ? Icons.remove : Icons.arrow_upward,
                                  color: isExpense ? AppColors.expenseIcon : AppColors.incomeIcon,
                                  size: 20,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      tx.title,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.textPrimary,
                                      ),
                                    ),
                                    const SizedBox(height: 3),
                                    Text(
                                      tx.category,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                '${isExpense ? '-' : '+'}${CurrencyFormat.toRupiah(tx.amount)}',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: isExpense ? AppColors.expenseIcon : AppColors.incomeIcon,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ),
      ],
    );
  }
}
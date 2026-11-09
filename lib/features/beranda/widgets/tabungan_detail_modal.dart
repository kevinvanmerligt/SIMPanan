import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/currency_format.dart';
import '../../../core/utils/date_format_id.dart';
import '../../../providers/finance_provider.dart';
import '../../catat_transaksi/screens/catat_modal_sheet.dart';
import 'tambah_tabungan_modal.dart';
import 'transfer_tabungan_modal.dart';

class TabunganDetailModal extends StatelessWidget {
  final int tabunganId;

  const TabunganDetailModal({super.key, required this.tabunganId});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final provider = context.watch<FinanceProvider>();

    final tabungan = provider.allTabungan.firstWhere(
      (t) => t.id == tabunganId,
      orElse: () => provider.primaryTabungan,
    );

    final transactions = provider.allTransactions
        .where((tx) => tx.tabunganId == tabungan.id || (tabungan.isPrimary && tx.tabunganId == 1))
        .take(10)
        .toList();

    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.88,
      ),
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
        top: 16,
        bottom: 24,
      ),
      decoration: BoxDecoration(
        color: colors.cardSurface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        border: Border.all(color: colors.cardBorder),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: colors.cardBorder,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: tabungan.color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: tabungan.color.withValues(alpha: 0.3)),
                ),
                child: Icon(
                  tabungan.iconData,
                  color: tabungan.color,
                  size: 26,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            tabungan.name,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: colors.textPrimary,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (tabungan.isPrimary) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: colors.primaryPillBg,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              'Utama',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                color: colors.primaryGreen,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Terkumpul: ${CurrencyFormat.toRupiah(tabungan.currentBalance)}',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: colors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (_) => TambahTabunganModal(existingTabungan: tabungan),
                  );
                },
                icon: Icon(Icons.edit_outlined, size: 20, color: colors.textSecondary),
                tooltip: 'Edit Tabungan',
              ),
              if (!tabungan.isPrimary)
                IconButton(
                  onPressed: () async {
                    final confirm = await showDialog<bool>(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        backgroundColor: colors.cardSurface,
                        title: Text('Hapus Tabungan?', style: TextStyle(color: colors.textPrimary)),
                        content: Text(
                          'Tabungan "${tabungan.name}" akan dihapus. Semua transaksinya akan dialihkan otomatis ke Tabungan Utama.',
                          style: TextStyle(color: colors.textSecondary, fontSize: 13),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(ctx, false),
                            child: Text('Batal', style: TextStyle(color: colors.textSecondary)),
                          ),
                          ElevatedButton(
                            onPressed: () => Navigator.pop(ctx, true),
                            style: ElevatedButton.styleFrom(backgroundColor: colors.expenseIcon),
                            child: const Text('Hapus', style: TextStyle(color: Colors.white)),
                          ),
                        ],
                      ),
                    );

                    if (confirm == true && context.mounted) {
                      await context.read<FinanceProvider>().deleteTabungan(tabungan.id!);
                      if (context.mounted) Navigator.pop(context);
                    }
                  },
                  icon: Icon(Icons.delete_outline, size: 20, color: colors.expenseIcon),
                  tooltip: 'Hapus Tabungan',
                ),
            ],
          ),
          if (tabungan.targetAmount > 0) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: colors.inputBg,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: colors.cardBorder),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Target Tabungan',
                        style: TextStyle(fontSize: 12, color: colors.textSecondary),
                      ),
                      Text(
                        '${(tabungan.progress * 100).toStringAsFixed(1)}%',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: tabungan.isTargetAchieved ? colors.primaryGreen : tabungan.color,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: TweenAnimationBuilder<double>(
                      tween: Tween<double>(begin: 0.0, end: tabungan.progress),
                      duration: const Duration(milliseconds: 650),
                      curve: Curves.easeOutCubic,
                      builder: (context, value, _) {
                        return LinearProgressIndicator(
                          value: value,
                          minHeight: 8,
                          backgroundColor: colors.cardBorder,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            tabungan.isTargetAchieved ? colors.primaryGreen : tabungan.color,
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Target: ${CurrencyFormat.toRupiah(tabungan.targetAmount)}',
                        style: TextStyle(fontSize: 11, color: colors.textSecondary),
                      ),
                      Text(
                        tabungan.isTargetAchieved
                            ? '🎉 Target Tercapai!'
                            : 'Kurang ${CurrencyFormat.toRupiah(tabungan.remainingToTarget)} lagi',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: tabungan.isTargetAchieved ? colors.primaryGreen : colors.textMuted,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (_) => CatatModalSheet(
                        initialType: 'INCOME',
                        preselectedTabunganId: tabungan.id,
                      ),
                    );
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: colors.incomeBg,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: colors.incomeIcon.withValues(alpha: 0.2)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.arrow_upward_rounded, size: 16, color: colors.incomeIcon),
                        const SizedBox(width: 6),
                        Text(
                          'Nabung',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: colors.incomeIcon,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (_) => CatatModalSheet(
                        initialType: 'EXPENSE',
                        preselectedTabunganId: tabungan.id,
                      ),
                    );
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: colors.expenseBg,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: colors.expenseIcon.withValues(alpha: 0.2)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.arrow_downward_rounded, size: 16, color: colors.expenseIcon),
                        const SizedBox(width: 6),
                        Text(
                          'Pakai / Tarik',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: colors.expenseIcon,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (_) => TransferTabunganModal(
                      preselectedFromId: tabungan.id,
                    ),
                  );
                },
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: colors.inputBg,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: colors.cardBorder),
                  ),
                  child: Icon(Icons.swap_horiz_rounded, size: 20, color: colors.primaryGreen),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            'Catatan Tabungan Ini',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: colors.textPrimary,
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: transactions.isEmpty
                ? Center(
                    child: Text(
                      'Belum ada transaksi di tabungan ini',
                      style: TextStyle(fontSize: 12, color: colors.textSecondary),
                    ),
                  )
                : ListView.separated(
                    itemCount: transactions.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      final tx = transactions[index];
                      final isExpense = tx.type == 'EXPENSE';
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        decoration: BoxDecoration(
                          color: colors.inputBg,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: colors.cardBorder),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: isExpense ? colors.expenseBg : colors.incomeBg,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(
                                isExpense ? Icons.remove : Icons.add,
                                color: isExpense ? colors.expenseIcon : colors.incomeIcon,
                                size: 16,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    tx.title,
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700,
                                      color: colors.textPrimary,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    '${tx.category} · ${DateFormatId.formatHariTanggal(tx.date)}',
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: colors.textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              '${isExpense ? '-' : '+'}${CurrencyFormat.toRupiah(tx.amount)}',
                              style: TextStyle(
                                fontSize: 13,
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
  }
}


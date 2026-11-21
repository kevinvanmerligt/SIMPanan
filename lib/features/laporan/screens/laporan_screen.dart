import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/currency_format.dart';
import '../../../core/widgets/app_header.dart';
import '../../../core/widgets/fade_slide_entrance.dart';
import '../../../providers/finance_provider.dart';
import '../../beranda/widgets/bayar_hutang_modal.dart';
import '../../beranda/widgets/tabungan_detail_modal.dart';
import '../../beranda/widgets/tambah_hutang_modal.dart';
import '../../beranda/widgets/tambah_tabungan_modal.dart';

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
        final activeDebts = provider.activeDebts;
        final totalDebt = provider.totalActiveDebt;

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
              delayMs: 30,
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

            FadeSlideEntrance(
              delayMs: 60,
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
                          'Total Seluruh Pengeluaran',
                          style: TextStyle(color: colors.textSecondary, fontSize: 13),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: const Color(0xFFEF4444).withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Text(
                            'Arus Keluar',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFFEF4444),
                            ),
                          ),
                        ),
                      ],
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
                    const SizedBox(height: 18),
                    Text(
                      'Rincian Pengeluaran per Kategori',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: colors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 12),
                    if (categoryTotals.isEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          'Belum ada data pengeluaran yang tercatat.',
                          style: TextStyle(color: colors.textSecondary, fontSize: 12),
                        ),
                      )
                    else
                      ...categoryTotals.entries.map((entry) {
                        final percent = totalExpense > 0 ? entry.value / totalExpense : 0.0;
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
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
                                      fontSize: 13,
                                      color: colors.textPrimary,
                                    ),
                                  ),
                                  Text(
                                    CurrencyFormat.toRupiah(entry.value),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 13,
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
                                      minHeight: 7,
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
            const SizedBox(height: 20),

            FadeSlideEntrance(
              delayMs: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Kelola Kantong Tabungan',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: colors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Total Simpanan: ${CurrencyFormat.toRupiah(totalSavings)}',
                        style: TextStyle(
                          fontSize: 12,
                          color: colors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (_) => const TambahTabunganModal(),
                      );
                    },
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: colors.primaryPillBg,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.add_rounded, size: 14, color: colors.primaryGreen),
                          const SizedBox(width: 4),
                          Text(
                            'Tambah',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: colors.primaryGreen,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            ...tabunganList.asMap().entries.map((entry) {
              final index = entry.key + 1;
              final tab = entry.value;
              final ratio = totalSavings > 0 ? (tab.currentBalance / totalSavings).clamp(0.0, 1.0) : 0.0;
              final hasTarget = tab.targetAmount > 0;
              final targetRatio = hasTarget ? (tab.currentBalance / tab.targetAmount).clamp(0.0, 1.0) : 0.0;

              return FadeSlideEntrance(
                delayMs: 120 + (entry.key * 30),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: colors.cardSurface,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: colors.cardBorder),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 82,
                        child: Column(
                          children: [
                            Container(
                              width: 52,
                              height: 52,
                              decoration: BoxDecoration(
                                color: tab.color.withValues(alpha: 0.16),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: tab.color.withValues(alpha: 0.35),
                                  width: 1.5,
                                ),
                              ),
                              child: Icon(
                                tab.iconData,
                                size: 28,
                                color: tab.color,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              tab.name,
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                                color: colors.textPrimary,
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: tab.isPrimary
                                    ? tab.color.withValues(alpha: 0.15)
                                    : colors.inputBg,
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                  color: tab.isPrimary
                                      ? tab.color.withValues(alpha: 0.3)
                                      : colors.cardBorder,
                                ),
                              ),
                              child: Text(
                                tab.isPrimary ? 'Utama' : 'Baris $index',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  color: tab.isPrimary ? tab.color : colors.textSecondary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Saldo Terkumpul',
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: colors.textSecondary,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        CurrencyFormat.toRupiah(tab.currentBalance),
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w800,
                                          color: tab.color,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: true,
                                      backgroundColor: Colors.transparent,
                                      builder: (_) => TabunganDetailModal(tabunganId: tab.id ?? 1),
                                    );
                                  },
                                  borderRadius: BorderRadius.circular(8),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: tab.color.withValues(alpha: 0.12),
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(color: tab.color.withValues(alpha: 0.25)),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(Icons.tune_rounded, size: 12, color: tab.color),
                                        const SizedBox(width: 4),
                                        Text(
                                          'Kelola',
                                          style: TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w700,
                                            color: tab.color,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            if (hasTarget) ...[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Target: ${CurrencyFormat.toRupiah(tab.targetAmount)}',
                                    style: TextStyle(fontSize: 11, color: colors.textSecondary),
                                  ),
                                  Text(
                                    '${(targetRatio * 100).toInt()}% Tercapai',
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w700,
                                      color: tab.color,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: TweenAnimationBuilder<double>(
                                  tween: Tween<double>(begin: 0.0, end: targetRatio),
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
                              const SizedBox(height: 6),
                              Text(
                                '${(ratio * 100).toStringAsFixed(1)}% dari total simpanan',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: colors.textSecondary,
                                ),
                              ),
                            ] else ...[
                              Text(
                                'Porsi Simpanan',
                                style: TextStyle(fontSize: 11, color: colors.textSecondary),
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
                              const SizedBox(height: 6),
                              Text(
                                '${(ratio * 100).toStringAsFixed(1)}% dari total simpanan',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: tab.color,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
            const SizedBox(height: 10),

            FadeSlideEntrance(
              delayMs: 180,
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
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: const Color(0xFFEF4444).withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(
                                Icons.account_balance_wallet_outlined,
                                color: Color(0xFFEF4444),
                                size: 16,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Kewajiban Hutang',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: colors.textPrimary,
                              ),
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              builder: (_) => const TambahHutangModal(),
                            );
                          },
                          borderRadius: BorderRadius.circular(6),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: colors.primaryPillBg,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              '+ Hutang',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                color: colors.primaryGreen,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Tanggungan Belum Lunas',
                          style: TextStyle(color: colors.textSecondary, fontSize: 12),
                        ),
                        Text(
                          CurrencyFormat.toRupiah(totalDebt),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: totalDebt > 0 ? const Color(0xFFEF4444) : colors.primaryGreen,
                          ),
                        ),
                      ],
                    ),
                    if (activeDebts.isNotEmpty) ...[
                      const SizedBox(height: 12),
                      ...activeDebts.map((debt) {
                        return Container(
                          margin: const EdgeInsets.only(top: 8),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: colors.inputBg,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  debt.title,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: colors.textPrimary,
                                  ),
                                ),
                              ),
                              Text(
                                CurrencyFormat.toRupiah(debt.remainingAmount),
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFFEF4444),
                                ),
                              ),
                              const SizedBox(width: 8),
                              InkWell(
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
                                    builder: (_) => BayarHutangModal(debt: debt),
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: colors.primaryGreen,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    'Bayar',
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ],
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        );
      },
    );
  }
}

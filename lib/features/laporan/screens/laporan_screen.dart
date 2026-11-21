import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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

enum LaporanPeriode {
  bulanIni,
  bulanLalu,
  tujuhHariTerakhir,
  tigaPuluhHariTerakhir,
  semua,
  custom,
}

class LaporanScreen extends StatefulWidget {
  const LaporanScreen({super.key});

  @override
  State<LaporanScreen> createState() => _LaporanScreenState();
}

class _LaporanScreenState extends State<LaporanScreen> {
  LaporanPeriode _selectedPeriod = LaporanPeriode.bulanIni;
  DateTimeRange? _customRange;

  Future<void> _pickCustomRange(BuildContext context) async {
    final now = DateTime.now();
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(now.year + 2),
      initialDateRange: _customRange ??
          DateTimeRange(
            start: DateTime(now.year, now.month, 1),
            end: now,
          ),
      builder: (context, child) {
        final colors = context.colors;
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: colors.primaryGreen,
              onPrimary: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _selectedPeriod = LaporanPeriode.custom;
        _customRange = picked;
      });
    }
  }

  Widget _buildPeriodChip(LaporanPeriode period, String label, AppColorScheme colors) {
    final isSelected = _selectedPeriod == period;
    return InkWell(
      onTap: () {
        setState(() => _selectedPeriod = period);
      },
      borderRadius: BorderRadius.circular(20),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? colors.primaryGreen : colors.cardSurface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? colors.primaryGreen : colors.cardBorder,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            color: isSelected ? Colors.white : colors.textSecondary,
          ),
        ),
      ),
    );
  }

  Widget _buildCustomChip(AppColorScheme colors) {
    final isSelected = _selectedPeriod == LaporanPeriode.custom;
    return InkWell(
      onTap: () => _pickCustomRange(context),
      borderRadius: BorderRadius.circular(20),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? colors.primaryGreen : colors.cardSurface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? colors.primaryGreen : colors.cardBorder,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.date_range_rounded,
              size: 14,
              color: isSelected ? Colors.white : colors.textSecondary,
            ),
            const SizedBox(width: 5),
            Text(
              'Pilih Tanggal',
              style: TextStyle(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: isSelected ? Colors.white : colors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Consumer<FinanceProvider>(
      builder: (context, provider, _) {
        final now = DateTime.now();
        DateTime? startDate;
        DateTime? endDate;
        String activePeriodLabel = 'Bulan Ini';

        switch (_selectedPeriod) {
          case LaporanPeriode.bulanIni:
            startDate = DateTime(now.year, now.month, 1);
            endDate = DateTime(now.year, now.month, now.day, 23, 59, 59, 999);
            activePeriodLabel = '${DateFormat('d MMM yyyy', 'id_ID').format(startDate)} - ${DateFormat('d MMM yyyy', 'id_ID').format(now)}';
            break;
          case LaporanPeriode.bulanLalu:
            startDate = DateTime(now.year, now.month - 1, 1);
            final lastDayOfPrevMonth = DateTime(now.year, now.month, 0);
            endDate = DateTime(now.year, now.month, 0, 23, 59, 59, 999);
            activePeriodLabel = '${DateFormat('d MMM yyyy', 'id_ID').format(startDate)} - ${DateFormat('d MMM yyyy', 'id_ID').format(lastDayOfPrevMonth)}';
            break;
          case LaporanPeriode.tujuhHariTerakhir:
            startDate = DateTime(now.year, now.month, now.day).subtract(const Duration(days: 6));
            endDate = DateTime(now.year, now.month, now.day, 23, 59, 59, 999);
            activePeriodLabel = '${DateFormat('d MMM yyyy', 'id_ID').format(startDate)} - ${DateFormat('d MMM yyyy', 'id_ID').format(now)}';
            break;
          case LaporanPeriode.tigaPuluhHariTerakhir:
            startDate = DateTime(now.year, now.month, now.day).subtract(const Duration(days: 29));
            endDate = DateTime(now.year, now.month, now.day, 23, 59, 59, 999);
            activePeriodLabel = '${DateFormat('d MMM yyyy', 'id_ID').format(startDate)} - ${DateFormat('d MMM yyyy', 'id_ID').format(now)}';
            break;
          case LaporanPeriode.semua:
            startDate = null;
            endDate = null;
            activePeriodLabel = 'Semua Periode';
            break;
          case LaporanPeriode.custom:
            if (_customRange != null) {
              startDate = DateTime(_customRange!.start.year, _customRange!.start.month, _customRange!.start.day);
              endDate = DateTime(_customRange!.end.year, _customRange!.end.month, _customRange!.end.day, 23, 59, 59, 999);
              activePeriodLabel = '${DateFormat('d MMM yyyy', 'id_ID').format(_customRange!.start)} - ${DateFormat('d MMM yyyy', 'id_ID').format(_customRange!.end)}';
            } else {
              startDate = DateTime(now.year, now.month, 1);
              endDate = DateTime(now.year, now.month, now.day, 23, 59, 59, 999);
              activePeriodLabel = '${DateFormat('d MMM yyyy', 'id_ID').format(startDate)} - ${DateFormat('d MMM yyyy', 'id_ID').format(now)}';
            }
            break;
        }

        final filteredTransactions = provider.allTransactions.where((tx) {
          if (tx.type != 'EXPENSE') return false;
          if (startDate != null && tx.date.isBefore(startDate)) return false;
          if (endDate != null && tx.date.isAfter(endDate)) return false;
          return true;
        }).toList();

        final Map<String, int> categoryTotals = {};
        int totalExpense = 0;

        for (final tx in filteredTransactions) {
          categoryTotals[tx.category] = (categoryTotals[tx.category] ?? 0) + tx.amount;
          totalExpense += tx.amount;
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
            const SizedBox(height: 12),

            FadeSlideEntrance(
              delayMs: 45,
              child: SizedBox(
                height: 38,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  children: [
                    _buildPeriodChip(LaporanPeriode.bulanIni, 'Bulan Ini', colors),
                    const SizedBox(width: 8),
                    _buildPeriodChip(LaporanPeriode.bulanLalu, 'Bulan Lalu', colors),
                    const SizedBox(width: 8),
                    _buildPeriodChip(LaporanPeriode.tujuhHariTerakhir, '7 Hari Terakhir', colors),
                    const SizedBox(width: 8),
                    _buildPeriodChip(LaporanPeriode.tigaPuluhHariTerakhir, '30 Hari Terakhir', colors),
                    const SizedBox(width: 8),
                    _buildPeriodChip(LaporanPeriode.semua, 'Semua', colors),
                    const SizedBox(width: 8),
                    _buildCustomChip(colors),
                  ],
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Total Seluruh Pengeluaran',
                                style: TextStyle(color: colors.textSecondary, fontSize: 13),
                              ),
                              const SizedBox(height: 3),
                              Row(
                                children: [
                                  Icon(
                                    Icons.calendar_today_rounded,
                                    size: 12,
                                    color: colors.primaryGreen,
                                  ),
                                  const SizedBox(width: 5),
                                  Expanded(
                                    child: Text(
                                      activePeriodLabel,
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w700,
                                        color: colors.primaryGreen,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
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
                    const SizedBox(height: 8),
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
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 24),
                        child: Column(
                          children: [
                            Icon(
                              Icons.receipt_long_outlined,
                              size: 40,
                              color: colors.textMuted.withValues(alpha: 0.5),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Belum ada pengeluaran pada periode ini',
                              style: TextStyle(
                                color: colors.textSecondary,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
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
                                    ? colors.badgeNeutralBg
                                    : colors.inputBg,
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                  color: tab.isPrimary
                                      ? colors.badgeNeutralText.withValues(alpha: 0.3)
                                      : colors.cardBorder,
                                ),
                              ),
                              child: Text(
                                tab.isPrimary ? 'Utama' : 'Baris $index',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  color: tab.isPrimary ? colors.badgeNeutralText : colors.textSecondary,
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

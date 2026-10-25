import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../providers/finance_provider.dart';
import '../../catat_transaksi/screens/catat_modal_sheet.dart';
import '../widgets/catat_cepat_section.dart';
import '../widgets/grafik_enam_hari_card.dart';
import '../widgets/hero_saldo_card.dart';
import '../widgets/transaksi_hari_ini_list.dart';

class BerandaScreen extends StatelessWidget {
  final VoidCallback? onNavigateToLaporan;

  const BerandaScreen({super.key, this.onNavigateToLaporan});

  void _openCatatModal(BuildContext context, String type) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => CatatModalSheet(initialType: type),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FinanceProvider>(
      builder: (context, provider, _) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Aplikasi: Logo & "SIMPanan"
              Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primaryGreen.withValues(alpha: 0.15),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        'assets/images/logo.png',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          color: AppColors.primaryGreen,
                          child: const Icon(
                            Icons.savings_rounded,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'SIMPanan',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textPrimary,
                          letterSpacing: -0.3,
                        ),
                      ),
                      Text(
                        'Kelola Keuangan Pribadi',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.cardBorder),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.shield_outlined, size: 14, color: AppColors.primaryGreen),
                        SizedBox(width: 4),
                        Text(
                          'Offline Safe',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primaryGreen,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),

              // 1. Hero Card Hijau Tua
              HeroSaldoCard(summary: provider.todaySummary),
              const SizedBox(height: 22),

              // 2. Catat Transaksi (Pengeluaran & Pemasukan)
              CatatCepatSection(
                onTapPengeluaran: () => _openCatatModal(context, 'EXPENSE'),
                onTapPemasukan: () => _openCatatModal(context, 'INCOME'),
              ),
              const SizedBox(height: 22),

              // 3. Pengeluaran 6 Hari Terakhir
              GrafikEnamHariCard(
                data6Hari: provider.last6DaysExpenses,
                totalExpense: provider.total6DaysExpense,
                onTapLihatGrafik: () {
                  if (onNavigateToLaporan != null) onNavigateToLaporan!();
                },
              ),
              const SizedBox(height: 22),

              // 4. Transaksi Hari Ini + Segmented Control
              TransaksiHariIniList(
                totalCount: provider.todayTransactions.length,
                selectedFilter: provider.selectedFilter,
                onFilterChanged: provider.setFilter,
                transactions: provider.filteredTodayTransactions,
                onDelete: provider.deleteTransaction,
              ),
              const SizedBox(height: 32),
            ],
          ),
        );
      },
    );
  }
}
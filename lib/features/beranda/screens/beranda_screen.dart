import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/widgets/app_header.dart';
import '../../../core/widgets/fade_slide_entrance.dart';
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
              const FadeSlideEntrance(
                delayMs: 0,
                child: SimpananAppHeader(),
              ),
              const SizedBox(height: 18),

              // 1. Hero Card Hijau Tua
              FadeSlideEntrance(
                delayMs: 60,
                child: HeroSaldoCard(summary: provider.todaySummary),
              ),
              const SizedBox(height: 22),

              // 2. Catat Transaksi (Pengeluaran & Pemasukan)
              FadeSlideEntrance(
                delayMs: 120,
                child: CatatCepatSection(
                  onTapPengeluaran: () => _openCatatModal(context, 'EXPENSE'),
                  onTapPemasukan: () => _openCatatModal(context, 'INCOME'),
                ),
              ),
              const SizedBox(height: 22),

              // 3. Pengeluaran 7 Hari Terakhir (Seminggu Penuh)
              FadeSlideEntrance(
                delayMs: 180,
                child: GrafikTujuhHariCard(
                  data7Hari: provider.last7DaysExpenses,
                  totalExpense: provider.total7DaysExpense,
                  onTapLihatGrafik: () {
                    if (onNavigateToLaporan != null) onNavigateToLaporan!();
                  },
                ),
              ),
              const SizedBox(height: 22),

              // 4. Transaksi Hari Ini + Segmented Control
              FadeSlideEntrance(
                delayMs: 240,
                child: TransaksiHariIniList(
                  totalCount: provider.todayTransactions.length,
                  selectedFilter: provider.selectedFilter,
                  onFilterChanged: provider.setFilter,
                  transactions: provider.filteredTodayTransactions,
                  onDelete: provider.deleteTransaction,
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        );
      },
    );
  }
}
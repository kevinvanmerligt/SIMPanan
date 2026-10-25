import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../beranda/screens/beranda_screen.dart';
import '../catat_transaksi/screens/catat_modal_sheet.dart';
import '../laporan/screens/laporan_screen.dart';
import '../profil/screens/profil_screen.dart';
import '../riwayat/screens/riwayat_screen.dart';

class MainNavScreen extends StatefulWidget {
  const MainNavScreen({super.key});

  @override
  State<MainNavScreen> createState() => _MainNavScreenState();
}

class _MainNavScreenState extends State<MainNavScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      BerandaScreen(onNavigateToLaporan: () => _onItemTapped(1)),
      const LaporanScreen(),
      const RiwayatScreen(),
      const ProfilScreen(),
    ];

    return Scaffold(
      body: SafeArea(
        child: screens[_selectedIndex],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SizedBox(
        width: 56,
        height: 56,
        child: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (_) => const CatatModalSheet(initialType: 'EXPENSE'),
            );
          },
          backgroundColor: AppColors.primaryGreen,
          elevation: 2,
          shape: const CircleBorder(),
          child: const Icon(Icons.add, color: Colors.white, size: 28),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: AppColors.cardBorder, width: 1)),
        ),
        child: BottomAppBar(
          color: Colors.white,
          elevation: 0,
          padding: EdgeInsets.zero,
          height: 68,
          shape: const CircularNotchedRectangle(),
          notchMargin: 8,
          child: Row(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildNavItem(Icons.home_outlined, Icons.home, 'Beranda', 0),
                    _buildNavItem(Icons.bar_chart_outlined, Icons.bar_chart, 'Laporan', 1),
                  ],
                ),
              ),
              const SizedBox(width: 64),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildNavItem(Icons.calendar_today_outlined, Icons.calendar_today, 'Riwayat', 2),
                    _buildNavItem(Icons.person_outline, Icons.person, 'Profil', 3),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, IconData activeIcon, String label, int index) {
    final isSelected = _selectedIndex == index;
    final color = isSelected ? AppColors.primaryGreen : AppColors.textSecondary;

    return InkWell(
      onTap: () => _onItemTapped(index),
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(isSelected ? activeIcon : icon, color: color, size: 24),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';

class CatatCepatSection extends StatelessWidget {
  final VoidCallback onTapPengeluaran;
  final VoidCallback onTapPemasukan;

  const CatatCepatSection({
    super.key,
    required this.onTapPengeluaran,
    required this.onTapPemasukan,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              AppStrings.catatTransaksi,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            Text(
              AppStrings.tersimpanOtomatis,
              style: TextStyle(
                fontSize: 12,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildActionCard(
                onTap: onTapPengeluaran,
                iconBg: AppColors.expenseBg,
                iconColor: AppColors.expenseIcon,
                icon: Icons.add,
                title: 'Pengeluaran',
                subtitle: 'Belanja, makan, t...',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildActionCard(
                onTap: onTapPemasukan,
                iconBg: AppColors.incomeBg,
                iconColor: AppColors.incomeIcon,
                icon: Icons.arrow_upward,
                title: 'Pemasukan',
                subtitle: 'Gaji, jualan, trans...',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionCard({
    required VoidCallback onTap,
    required Color iconBg,
    required Color iconColor,
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.cardSurface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.cardBorder),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: iconBg,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: iconColor, size: 22),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
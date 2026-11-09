import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/currency_format.dart';
import '../../../data/models/tabungan_model.dart';
import '../../../providers/finance_provider.dart';
import 'tabungan_detail_modal.dart';
import 'tambah_tabungan_modal.dart';
import 'transfer_tabungan_modal.dart';

class KantongTabunganSection extends StatelessWidget {
  const KantongTabunganSection({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final provider = context.watch<FinanceProvider>();
    final tabunganList = provider.allTabungan;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  Icons.savings_outlined,
                  size: 20,
                  color: colors.primaryGreen,
                ),
                const SizedBox(width: 8),
                Text(
                  'Kantong Tabungan',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: colors.textPrimary,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                if (tabunganList.length > 1)
                  InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (_) => const TransferTabunganModal(),
                      );
                    },
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      margin: const EdgeInsets.only(right: 6),
                      decoration: BoxDecoration(
                        color: colors.inputBg,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: colors.cardBorder),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.swap_horiz_rounded, size: 14, color: colors.primaryGreen),
                          const SizedBox(width: 4),
                          Text(
                            'Transfer',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: colors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
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
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: colors.primaryPillBg,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.add, size: 14, color: colors.primaryGreen),
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
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 156,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: tabunganList.length + 1,
            separatorBuilder: (_, _) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              if (index == tabunganList.length) {
                return _buildAddCard(context, colors);
              }
              final tabungan = tabunganList[index];
              return _buildTabunganCard(context, tabungan, colors);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTabunganCard(
    BuildContext context,
    TabunganModel tabungan,
    AppColorScheme colors,
  ) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (_) => TabunganDetailModal(tabunganId: tabungan.id ?? 1),
        );
      },
      borderRadius: BorderRadius.circular(18),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutCubic,
        width: 200,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: colors.cardSurface,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: tabungan.isPrimary
                ? colors.primaryGreen.withValues(alpha: 0.35)
                : colors.cardBorder,
            width: tabungan.isPrimary ? 1.5 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: tabungan.color.withValues(alpha: colors.isDark ? 0.08 : 0.06),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: tabungan.color.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    tabungan.iconData,
                    color: tabungan.color,
                    size: 20,
                  ),
                ),
                if (tabungan.isPrimary)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
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
                  )
                else if (tabungan.isTargetAchieved)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: colors.primaryPillBg,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      'Tercapai 🎉',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: colors.primaryGreen,
                      ),
                    ),
                  ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tabungan.name,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: colors.textPrimary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  CurrencyFormat.toRupiah(tabungan.currentBalance),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: tabungan.currentBalance < 0
                        ? colors.expenseIcon
                        : (tabungan.isPrimary ? colors.primaryGreen : tabungan.color),
                  ),
                ),
              ],
            ),
            if (tabungan.targetAmount > 0)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: TweenAnimationBuilder<double>(
                      tween: Tween<double>(begin: 0.0, end: tabungan.progress),
                      duration: const Duration(milliseconds: 600),
                      curve: Curves.easeOutCubic,
                      builder: (context, value, _) {
                        return LinearProgressIndicator(
                          value: value,
                          minHeight: 5,
                          backgroundColor: colors.inputBg,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            tabungan.isTargetAchieved ? colors.primaryGreen : tabungan.color,
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Target: ${CurrencyFormat.toRupiah(tabungan.targetAmount)}',
                        style: TextStyle(fontSize: 10, color: colors.textSecondary),
                      ),
                      Text(
                        '${(tabungan.progress * 100).toInt()}%',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: tabungan.color,
                        ),
                      ),
                    ],
                  ),
                ],
              )
            else
              Text(
                'Ketuk untuk detail & kelola',
                style: TextStyle(
                  fontSize: 10,
                  color: colors.textSecondary.withValues(alpha: 0.7),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddCard(BuildContext context, AppColorScheme colors) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (_) => const TambahTabunganModal(),
        );
      },
      borderRadius: BorderRadius.circular(18),
      child: Container(
        width: 140,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: colors.cardSurface.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: colors.cardBorder,
            style: BorderStyle.solid,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: colors.primaryPillBg,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.add_rounded,
                color: colors.primaryGreen,
                size: 24,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Tambah\nTabungan',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: colors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


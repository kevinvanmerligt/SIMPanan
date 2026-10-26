import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/utils/currency_format.dart';

class GrafikTujuhHariCard extends StatelessWidget {
  final List<Map<String, dynamic>> data7Hari;
  final int totalExpense;
  final VoidCallback onTapLihatGrafik;

  const GrafikTujuhHariCard({
    super.key,
    required this.data7Hari,
    required this.totalExpense,
    required this.onTapLihatGrafik,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    double maxY = 100000;
    for (final item in data7Hari) {
      final amt = (item['amount'] as int).toDouble();
      if (amt > maxY) maxY = amt * 1.2;
    }

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colors.cardSurface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.cardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppStrings.pengeluaran7Hari,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: colors.textPrimary,
                ),
              ),
              Text(
                'Total ${CurrencyFormat.toRupiah(totalExpense)}',
                style: TextStyle(
                  fontSize: 13,
                  color: colors.textSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Area Grafik Batang & Garis Horizontal
          SizedBox(
            height: 124,
            child: BarChart(
              swapAnimationDuration: const Duration(milliseconds: 450),
              swapAnimationCurve: Curves.easeOutCubic,
              BarChartData(
                maxY: maxY,
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: maxY / 3,
                  getDrawingHorizontalLine: (value) => FlLine(
                    color: colors.cardBorder,
                    strokeWidth: 1,
                  ),
                ),
                borderData: FlBorderData(
                  show: true,
                  border: Border(
                    bottom: BorderSide(color: colors.cardBorder, width: 1),
                  ),
                ),
                titlesData: FlTitlesData(
                  topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        final idx = value.toInt();
                        if (idx < 0 || idx >= data7Hari.length) return const SizedBox();
                        final date = data7Hari[idx]['date'] as DateTime;
                        final isToday = idx == data7Hari.length - 1;
                        return Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: Text(
                            isToday ? 'Hari ini' : DateFormat('E', 'id_ID').format(date),
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: isToday ? FontWeight.w700 : FontWeight.w500,
                              color: isToday ? colors.primaryGreen : colors.textSecondary,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                barGroups: List.generate(data7Hari.length, (index) {
                  final amount = (data7Hari[index]['amount'] as int).toDouble();
                  final hasData = amount > 0;
                  final isToday = index == data7Hari.length - 1;
                  return BarChartGroupData(
                    x: index,
                    barRods: [
                      BarChartRodData(
                        toY: hasData ? amount : maxY * 0.08,
                        color: hasData
                            ? (isToday ? colors.primaryGreen : (colors.isDark ? colors.primaryGreen.withValues(alpha: 0.6) : const Color(0xFF1B6B45)))
                            : colors.chartEmpty,
                        width: 18,
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ],
                  );
                }),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Legenda
          Row(
            children: [
              _buildLegendDot(colors.primaryGreen, AppStrings.harimuIniDanSebelumnya, colors),
              const SizedBox(width: 16),
              _buildLegendDot(colors.chartEmpty, AppStrings.belumAdaCatatan, colors),
            ],
          ),
          const SizedBox(height: 12),

          // Tombol Lihat Data Grafik
          InkWell(
            onTap: onTapLihatGrafik,
            child: Text(
              AppStrings.lihatDataGrafik,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: colors.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendDot(Color color, String label, AppColorScheme colors) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: colors.textSecondary,
          ),
        ),
      ],
    );
  }
}
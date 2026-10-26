import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class KategoriSelector extends StatelessWidget {
  final String type;
  final String selectedCategory;
  final ValueChanged<String> onSelected;

  const KategoriSelector({
    super.key,
    required this.type,
    required this.selectedCategory,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final categories = type == 'EXPENSE'
        ? ['Belanja', 'Makan & Minum', 'Transportasi', 'Tagihan', 'Lainnya']
        : ['Gaji & Saldo Awal', 'Jualan', 'Transfer Masuk', 'Bonus'];

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: categories.map((cat) {
        final isSelected = cat == selectedCategory;
        return ChoiceChip(
          label: Text(cat),
          selected: isSelected,
          selectedColor: colors.primaryGreen,
          backgroundColor: colors.inputBg,
          side: BorderSide(
            color: isSelected ? colors.primaryGreen : colors.cardBorder,
          ),
          labelStyle: TextStyle(
            color: isSelected
                ? (colors.isDark ? const Color(0xFF0F1411) : Colors.white)
                : colors.textPrimary,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            fontSize: 13,
          ),
          onSelected: (_) => onSelected(cat),
        );
      }).toList(),
    );
  }
}
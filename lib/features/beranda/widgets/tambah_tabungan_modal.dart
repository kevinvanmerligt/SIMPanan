import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../data/models/tabungan_model.dart';
import '../../../providers/finance_provider.dart';

class TambahTabunganModal extends StatefulWidget {
  final TabunganModel? existingTabungan;

  const TambahTabunganModal({super.key, this.existingTabungan});

  @override
  State<TambahTabunganModal> createState() => _TambahTabunganModalState();
}

class _TambahTabunganModalState extends State<TambahTabunganModal> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _targetController = TextEditingController();
  late String _selectedIcon;
  late String _selectedColor;

  @override
  void initState() {
    super.initState();
    if (widget.existingTabungan != null) {
      _nameController.text = widget.existingTabungan!.name;
      _targetController.text = widget.existingTabungan!.targetAmount > 0
          ? widget.existingTabungan!.targetAmount.toString()
          : '';
      _selectedIcon = widget.existingTabungan!.iconName;
      _selectedColor = widget.existingTabungan!.colorHex;
    } else {
      _selectedIcon = 'savings';
      _selectedColor = TabunganModel.availableColors.first;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _targetController.dispose();
    super.dispose();
  }

  void _save() async {
    final name = _nameController.text.trim();
    if (name.isEmpty) return;

    final target = int.tryParse(_targetController.text.trim()) ?? 0;
    final provider = context.read<FinanceProvider>();

    if (widget.existingTabungan != null) {
      final updated = widget.existingTabungan!.copyWith(
        name: name,
        targetAmount: target,
        iconName: _selectedIcon,
        colorHex: _selectedColor,
      );
      await provider.updateTabungan(updated);
    } else {
      await provider.addTabungan(
        name: name,
        targetAmount: target,
        iconName: _selectedIcon,
        colorHex: _selectedColor,
      );
    }

    if (mounted) Navigator.pop(context);
  }

  Color _parseColor(String hex) {
    try {
      final val = int.parse(hex.replaceFirst('#', '').replaceFirst('0x', ''), radix: 16);
      return Color(val > 0xFFFFFF ? val : val | 0xFF000000);
    } catch (_) {
      return const Color(0xFF059669);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final isEditing = widget.existingTabungan != null;

    return Container(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      decoration: BoxDecoration(
        color: colors.cardSurface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        border: Border.all(color: colors.cardBorder),
      ),
      child: SingleChildScrollView(
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
            const SizedBox(height: 16),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: _parseColor(_selectedColor).withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.account_balance_wallet_rounded,
                    color: _parseColor(_selectedColor),
                    size: 20,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  isEditing ? 'Edit Tabungan' : 'Tambah Tabungan Baru',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: colors.textPrimary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            Text(
              'Nama Tabungan / Rencana',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: colors.textSecondary,
              ),
            ),
            const SizedBox(height: 6),
            TextField(
              controller: _nameController,
              style: TextStyle(color: colors.textPrimary),
              decoration: InputDecoration(
                hintText: 'Misal: Beli Laptop, Liburan, Dana Darurat',
                hintStyle: TextStyle(color: colors.textMuted),
                filled: true,
                fillColor: colors.inputBg,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: colors.cardBorder),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: colors.cardBorder),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: colors.primaryGreen, width: 1.5),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              ),
            ),
            const SizedBox(height: 14),
            Text(
              'Target Tabungan (Opsional)',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: colors.textSecondary,
              ),
            ),
            const SizedBox(height: 6),
            TextField(
              controller: _targetController,
              keyboardType: TextInputType.number,
              style: TextStyle(color: colors.textPrimary),
              decoration: InputDecoration(
                hintText: 'Misal: 15000000 (Kosongkan jika tidak ada target)',
                hintStyle: TextStyle(color: colors.textMuted),
                prefixText: 'Rp ',
                prefixStyle: TextStyle(
                  color: colors.textPrimary,
                  fontWeight: FontWeight.w700,
                ),
                filled: true,
                fillColor: colors.inputBg,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: colors.cardBorder),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: colors.cardBorder),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: colors.primaryGreen, width: 1.5),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Pilih Ikon',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: colors.textSecondary,
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 52,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: TabunganModel.availableIcons.length,
                separatorBuilder: (_, _) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final item = TabunganModel.availableIcons[index];
                  final isSelected = item['name'] == _selectedIcon;
                  return InkWell(
                    onTap: () => setState(() => _selectedIcon = item['name'] as String),
                    borderRadius: BorderRadius.circular(12),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeOutCubic,
                      width: 50,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? _parseColor(_selectedColor).withValues(alpha: 0.2)
                            : colors.inputBg,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected ? _parseColor(_selectedColor) : colors.cardBorder,
                          width: isSelected ? 1.8 : 1,
                        ),
                      ),
                      child: Icon(
                        item['icon'] as IconData,
                        color: isSelected ? _parseColor(_selectedColor) : colors.textSecondary,
                        size: 22,
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Warna Aksen',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: colors.textSecondary,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: TabunganModel.availableColors.map((hex) {
                final color = _parseColor(hex);
                final isSelected = hex == _selectedColor;
                return GestureDetector(
                  onTap: () => setState(() => _selectedColor = hex),
                  child: Container(
                    margin: const EdgeInsets.only(right: 10),
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isSelected ? Colors.white : Colors.transparent,
                        width: 2.5,
                      ),
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: color.withValues(alpha: 0.5),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ]
                          : null,
                    ),
                    child: isSelected
                        ? const Icon(Icons.check, size: 16, color: Colors.white)
                        : null,
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _save,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _parseColor(_selectedColor),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: Text(
                  isEditing ? 'Simpan Perubahan' : 'Buat Tabungan',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


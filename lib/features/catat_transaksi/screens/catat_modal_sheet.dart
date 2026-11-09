import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/currency_format.dart';
import '../../../providers/finance_provider.dart';
import '../../beranda/widgets/tambah_tabungan_modal.dart';
import '../widgets/kategori_selector.dart';
import '../widgets/numpad_input.dart';

class CatatModalSheet extends StatefulWidget {
  final String initialType;
  final int? preselectedTabunganId;

  const CatatModalSheet({
    super.key,
    this.initialType = 'EXPENSE',
    this.preselectedTabunganId,
  });

  @override
  State<CatatModalSheet> createState() => _CatatModalSheetState();
}

class _CatatModalSheetState extends State<CatatModalSheet> {
  late String _type;
  late String _selectedCategory;
  int? _selectedTabunganId;
  String _rawAmount = '';
  final TextEditingController _noteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _type = widget.initialType;
    _selectedCategory = _type == 'EXPENSE' ? 'Belanja' : 'Gaji & Saldo Awal';
    _selectedTabunganId = widget.preselectedTabunganId;
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  void _switchType(String newType) {
    setState(() {
      _type = newType;
      _selectedCategory = _type == 'EXPENSE' ? 'Belanja' : 'Gaji & Saldo Awal';
    });
  }

  void _onNumberTap(String val) {
    if (_rawAmount.length >= 10) return;
    setState(() {
      if (_rawAmount.isEmpty && (val == '0' || val == '000')) return;
      _rawAmount += val;
    });
  }

  void _onBackspace() {
    if (_rawAmount.isNotEmpty) {
      setState(() {
        _rawAmount = _rawAmount.substring(0, _rawAmount.length - 1);
      });
    }
  }

  Future<void> _saveTransaction() async {
    final amount = int.tryParse(_rawAmount) ?? 0;
    if (amount <= 0) return;

    final provider = context.read<FinanceProvider>();
    final targetTabungan = provider.allTabungan.firstWhere(
      (t) => t.id == (_selectedTabunganId ?? provider.primaryTabungan.id),
      orElse: () => provider.primaryTabungan,
    );

    final title = _noteController.text.trim().isEmpty
        ? _selectedCategory
        : _noteController.text.trim();

    await provider.addTransaction(
      title: title,
      category: _selectedCategory,
      type: _type,
      amount: amount,
      tabunganId: targetTabungan.id,
      tabunganName: targetTabungan.name,
    );

    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final provider = context.watch<FinanceProvider>();
    final tabunganList = provider.allTabungan;
    final activeTabunganId = _selectedTabunganId ?? provider.primaryTabungan.id ?? 1;
    final parsedAmount = int.tryParse(_rawAmount) ?? 0;

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

            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: colors.inputBg,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: colors.cardBorder),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _switchType('EXPENSE'),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: _type == 'EXPENSE' ? colors.cardSurface : Colors.transparent,
                          borderRadius: BorderRadius.circular(26),
                          border: _type == 'EXPENSE' ? Border.all(color: colors.cardBorder) : null,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'Pengeluaran',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: _type == 'EXPENSE' ? colors.expenseIcon : colors.textSecondary,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _switchType('INCOME'),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: _type == 'INCOME' ? colors.cardSurface : Colors.transparent,
                          borderRadius: BorderRadius.circular(26),
                          border: _type == 'INCOME' ? Border.all(color: colors.cardBorder) : null,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'Pemasukan',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: _type == 'INCOME' ? colors.incomeIcon : colors.textSecondary,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            Center(
              child: Text(
                CurrencyFormat.toRupiah(parsedAmount),
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.w800,
                  color: _type == 'EXPENSE' ? colors.expenseIcon : colors.incomeIcon,
                ),
              ),
            ),
            const SizedBox(height: 14),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _type == 'EXPENSE' ? 'Kurangi dari Tabungan:' : 'Tambahkan ke Tabungan:',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: colors.textSecondary,
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
                  borderRadius: BorderRadius.circular(8),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    child: Row(
                      children: [
                        Icon(Icons.add, size: 14, color: colors.primaryGreen),
                        const SizedBox(width: 2),
                        Text(
                          'Buat Baru',
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
            const SizedBox(height: 6),
            SizedBox(
              height: 42,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: tabunganList.length,
                separatorBuilder: (_, _) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final t = tabunganList[index];
                  final isSelected = t.id == activeTabunganId;
                  return ChoiceChip(
                    avatar: Icon(
                      t.iconData,
                      size: 16,
                      color: isSelected
                          ? (colors.isDark ? const Color(0xFF0F1411) : Colors.white)
                          : t.color,
                    ),
                    label: Text(t.name),
                    selected: isSelected,
                    selectedColor: colors.primaryGreen,
                    backgroundColor: colors.inputBg,
                    checkmarkColor: colors.isDark ? const Color(0xFF0F1411) : Colors.white,
                    side: BorderSide(
                      color: isSelected ? colors.primaryGreen : colors.cardBorder,
                    ),
                    labelStyle: TextStyle(
                      color: isSelected
                          ? (colors.isDark ? const Color(0xFF0F1411) : Colors.white)
                          : colors.textPrimary,
                      fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                      fontSize: 12,
                    ),
                    onSelected: (_) => setState(() => _selectedTabunganId = t.id),
                  );
                },
              ),
            ),
            const SizedBox(height: 14),

            Text(
              'Kategori Transaksi',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: colors.textSecondary,
              ),
            ),
            const SizedBox(height: 6),
            KategoriSelector(
              type: _type,
              selectedCategory: _selectedCategory,
              onSelected: (cat) => setState(() => _selectedCategory = cat),
            ),
            const SizedBox(height: 12),

            TextField(
              controller: _noteController,
              style: TextStyle(color: colors.textPrimary),
              decoration: InputDecoration(
                hintText: 'Tulis catatan singkat (opsional)...',
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
            const SizedBox(height: 12),

            NumpadInput(
              onNumberTap: _onNumberTap,
              onBackspace: _onBackspace,
            ),
            const SizedBox(height: 16),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _saveTransaction,
                style: ElevatedButton.styleFrom(
                  backgroundColor: colors.primaryGreen,
                  foregroundColor: colors.isDark ? const Color(0xFF0F1411) : Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: Text(
                  'Simpan',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: colors.isDark ? const Color(0xFF0F1411) : Colors.white,
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

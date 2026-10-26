import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/currency_format.dart';
import '../../../providers/finance_provider.dart';
import '../widgets/kategori_selector.dart';
import '../widgets/numpad_input.dart';

class CatatModalSheet extends StatefulWidget {
  final String initialType; // 'EXPENSE' atau 'INCOME'

  const CatatModalSheet({super.key, this.initialType = 'EXPENSE'});

  @override
  State<CatatModalSheet> createState() => _CatatModalSheetState();
}

class _CatatModalSheetState extends State<CatatModalSheet> {
  late String _type;
  late String _selectedCategory;
  String _rawAmount = '';
  final TextEditingController _noteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _type = widget.initialType;
    _selectedCategory = _type == 'EXPENSE' ? 'Belanja' : 'Gaji & Saldo Awal';
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

    final title = _noteController.text.trim().isEmpty
        ? _selectedCategory
        : _noteController.text.trim();

    await context.read<FinanceProvider>().addTransaction(
          title: title,
          category: _selectedCategory,
          type: _type,
          amount: amount,
        );

    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
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

            // Switch Pengeluaran / Pemasukan
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

            // Nominal Uang
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
            const SizedBox(height: 16),

            // Kategori
            KategoriSelector(
              type: _type,
              selectedCategory: _selectedCategory,
              onSelected: (cat) => setState(() => _selectedCategory = cat),
            ),
            const SizedBox(height: 12),

            // Input Catatan
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

            // Numpad
            NumpadInput(
              onNumberTap: _onNumberTap,
              onBackspace: _onBackspace,
            ),
            const SizedBox(height: 16),

            // Tombol Simpan
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
                  'Simpan Otomatis',
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
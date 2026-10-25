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
    final parsedAmount = int.tryParse(_rawAmount) ?? 0;

    return Container(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
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
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Switch Pengeluaran / Pemasukan
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _switchType('EXPENSE'),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: _type == 'EXPENSE' ? Colors.white : Colors.transparent,
                          borderRadius: BorderRadius.circular(26),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          'Pengeluaran',
                          style: TextStyle(fontWeight: FontWeight.w700),
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
                          color: _type == 'INCOME' ? Colors.white : Colors.transparent,
                          borderRadius: BorderRadius.circular(26),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          'Pemasukan',
                          style: TextStyle(fontWeight: FontWeight.w700),
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
                  color: _type == 'EXPENSE' ? AppColors.expenseIcon : AppColors.incomeIcon,
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
              decoration: InputDecoration(
                hintText: 'Tulis catatan singkat (opsional)...',
                filled: true,
                fillColor: AppColors.background,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
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
                  backgroundColor: AppColors.primaryGreen,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  'Simpan Otomatis',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
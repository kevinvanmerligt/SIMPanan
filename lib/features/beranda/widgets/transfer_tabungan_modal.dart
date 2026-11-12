import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/currency_format.dart';
import '../../../data/models/tabungan_model.dart';
import '../../../providers/finance_provider.dart';

class TransferTabunganModal extends StatefulWidget {
  final int? preselectedFromId;
  final int? preselectedToId;

  const TransferTabunganModal({
    super.key,
    this.preselectedFromId,
    this.preselectedToId,
  });

  @override
  State<TransferTabunganModal> createState() => _TransferTabunganModalState();
}

class _TransferTabunganModalState extends State<TransferTabunganModal> {
  late int _fromId;
  late int _toId;
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final provider = context.read<FinanceProvider>();
    final list = provider.allTabungan;

    _fromId = widget.preselectedFromId ??
        (list.isNotEmpty ? list.first.id ?? 1 : 1);

    if (widget.preselectedToId != null && widget.preselectedToId != _fromId) {
      _toId = widget.preselectedToId!;
    } else {
      final other = list.firstWhere(
        (t) => t.id != _fromId,
        orElse: () => list.isNotEmpty ? list.last : list.first,
      );
      _toId = other.id ?? 1;
    }

    _amountController.addListener(_onAmountChanged);
  }

  void _onAmountChanged() {
    setState(() {});
  }

  @override
  void dispose() {
    _amountController.removeListener(_onAmountChanged);
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  void _transfer() async {
    final amount = int.tryParse(_amountController.text.trim()) ?? 0;
    if (amount <= 0 || _fromId == _toId) return;

    final provider = context.read<FinanceProvider>();
    final all = provider.allTabungan;
    final fromTab = all.firstWhere((t) => t.id == _fromId, orElse: () => all.first);

    if (fromTab.currentBalance < amount) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Saldo tabungan asal tidak mencukupi.'),
          backgroundColor: Color(0xFFEF4444),
        ),
      );
      return;
    }

    await provider.transferBetweenTabungan(
      fromTabunganId: _fromId,
      toTabunganId: _toId,
      amount: amount,
      note: _noteController.text.trim().isNotEmpty
          ? _noteController.text.trim()
          : null,
    );

    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final provider = context.watch<FinanceProvider>();
    final all = provider.allTabungan;

    TabunganModel getTabungan(int id) {
      return all.firstWhere(
        (t) => t.id == id,
        orElse: () => all.first,
      );
    }

    final fromTab = getTabungan(_fromId);
    final toTab = getTabungan(_toId);

    final enteredAmount = int.tryParse(_amountController.text.trim()) ?? 0;
    final isInsufficient = enteredAmount > fromTab.currentBalance;
    final isZeroBalance = fromTab.currentBalance <= 0;
    final canTransfer = _fromId != _toId && enteredAmount > 0 && !isInsufficient;

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
                    color: colors.primaryGreen.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.swap_horiz_rounded,
                    color: colors.primaryGreen,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  'Transfer Antar Tabungan',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: colors.textPrimary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: colors.inputBg,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: colors.cardBorder),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Dari Tabungan',
                          style: TextStyle(fontSize: 11, color: colors.textSecondary),
                        ),
                        const SizedBox(height: 4),
                        DropdownButtonHideUnderline(
                          child: DropdownButton<int>(
                            isExpanded: true,
                            value: _fromId,
                            dropdownColor: colors.cardSurface,
                            items: all.map((t) {
                              return DropdownMenuItem<int>(
                                value: t.id,
                                child: Row(
                                  children: [
                                    Icon(t.iconData, size: 16, color: t.color),
                                    const SizedBox(width: 6),
                                    Expanded(
                                      child: Text(
                                        t.name,
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w700,
                                          color: colors.textPrimary,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                            onChanged: (val) {
                              if (val != null) setState(() => _fromId = val);
                            },
                          ),
                        ),
                        Text(
                          'Saldo: ${CurrencyFormat.toRupiah(fromTab.currentBalance)}',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: fromTab.currentBalance <= 0
                                ? const Color(0xFFEF4444)
                                : colors.primaryGreen,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: colors.cardSurface,
                      shape: BoxShape.circle,
                      border: Border.all(color: colors.cardBorder),
                    ),
                    child: Icon(
                      Icons.arrow_forward_rounded,
                      size: 16,
                      color: colors.primaryGreen,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: colors.inputBg,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: colors.cardBorder),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Ke Tabungan',
                          style: TextStyle(fontSize: 11, color: colors.textSecondary),
                        ),
                        const SizedBox(height: 4),
                        DropdownButtonHideUnderline(
                          child: DropdownButton<int>(
                            isExpanded: true,
                            value: _toId,
                            dropdownColor: colors.cardSurface,
                            items: all.map((t) {
                              return DropdownMenuItem<int>(
                                value: t.id,
                                child: Row(
                                  children: [
                                    Icon(t.iconData, size: 16, color: t.color),
                                    const SizedBox(width: 6),
                                    Expanded(
                                      child: Text(
                                        t.name,
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w700,
                                          color: colors.textPrimary,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                            onChanged: (val) {
                              if (val != null) setState(() => _toId = val);
                            },
                          ),
                        ),
                        Text(
                          'Saldo: ${CurrencyFormat.toRupiah(toTab.currentBalance)}',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: toTab.color,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Nominal Transfer',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: colors.textSecondary,
                  ),
                ),
                if (fromTab.currentBalance > 0)
                  InkWell(
                    onTap: () {
                      _amountController.text = fromTab.currentBalance.toString();
                    },
                    borderRadius: BorderRadius.circular(6),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                      child: Text(
                        'Pindahkan Semua',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: colors.primaryGreen,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 6),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              style: TextStyle(color: colors.textPrimary),
              decoration: InputDecoration(
                hintText: 'Contoh: 500000',
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
                  borderSide: BorderSide(
                    color: isInsufficient ? const Color(0xFFEF4444) : colors.cardBorder,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: isInsufficient ? const Color(0xFFEF4444) : colors.cardBorder,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: isInsufficient ? const Color(0xFFEF4444) : colors.primaryGreen,
                    width: 1.5,
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              ),
            ),
            if (isInsufficient) ...[
              const SizedBox(height: 6),
              Row(
                children: [
                  const Icon(Icons.error_outline_rounded, size: 14, color: Color(0xFFEF4444)),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      'Saldo tidak mencukupi! Maksimal transfer: ${CurrencyFormat.toRupiah(fromTab.currentBalance)}',
                      style: const TextStyle(
                        color: Color(0xFFEF4444),
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ] else if (isZeroBalance) ...[
              const SizedBox(height: 6),
              Row(
                children: [
                  const Icon(Icons.warning_amber_rounded, size: 14, color: Color(0xFFF59E0B)),
                  const SizedBox(width: 4),
                  const Expanded(
                    child: Text(
                      'Tabungan ini tidak memiliki saldo untuk ditransfer.',
                      style: TextStyle(
                        color: Color(0xFFF59E0B),
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
            const SizedBox(height: 14),
            Text(
              'Catatan Transfer (Opsional)',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: colors.textSecondary,
              ),
            ),
            const SizedBox(height: 6),
            TextField(
              controller: _noteController,
              style: TextStyle(color: colors.textPrimary),
              decoration: InputDecoration(
                hintText: 'Misal: Nabung rutin bulanan',
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
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: canTransfer ? _transfer : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: colors.primaryGreen,
                  disabledBackgroundColor: colors.cardBorder,
                  foregroundColor: colors.isDark ? const Color(0xFF0F1411) : Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  'Pindahkan Saldo',
                  style: TextStyle(
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

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

  bool _showCustomColorPicker = false;
  double _hue = 160.0;
  double _saturation = 0.85;
  double _lightness = 0.40;

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

    final isPreset = TabunganModel.availableColors.contains(_selectedColor);
    if (!isPreset) {
      _showCustomColorPicker = true;
      final color = _parseColor(_selectedColor);
      final hsl = HSLColor.fromColor(color);
      _hue = hsl.hue;
      _saturation = hsl.saturation.clamp(0.0, 1.0);
      _lightness = hsl.lightness.clamp(0.0, 1.0);
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

  String _colorToHex(Color color) {
    return '0x${color.toARGB32().toRadixString(16).padLeft(8, '0').toUpperCase()}';
  }

  void _updateHslColor() {
    final color = HSLColor.fromAHSL(1.0, _hue, _saturation, _lightness).toColor();
    setState(() {
      _selectedColor = _colorToHex(color);
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final isEditing = widget.existingTabungan != null;
    final isCustomColorSelected = !TabunganModel.availableColors.contains(_selectedColor);

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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Warna Aksen',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: colors.textSecondary,
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      _showCustomColorPicker = !_showCustomColorPicker;
                      if (_showCustomColorPicker && !isCustomColorSelected) {
                        _updateHslColor();
                      }
                    });
                  },
                  borderRadius: BorderRadius.circular(8),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.palette_outlined,
                          size: 14,
                          color: _showCustomColorPicker ? colors.primaryGreen : colors.textSecondary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          _showCustomColorPicker ? 'Tutup Kustom' : 'Kustom HSL',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: _showCustomColorPicker ? colors.primaryGreen : colors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ...TabunganModel.availableColors.map((hex) {
                    final color = _parseColor(hex);
                    final isSelected = hex == _selectedColor;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedColor = hex;
                        });
                      },
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
                  }),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _showCustomColorPicker = true;
                        _updateHslColor();
                      });
                    },
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        gradient: const SweepGradient(
                          colors: [
                            Colors.red,
                            Colors.yellow,
                            Colors.green,
                            Colors.cyan,
                            Colors.blue,
                            Colors.purple,
                            Colors.red,
                          ],
                        ),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isCustomColorSelected ? Colors.white : colors.cardBorder,
                          width: isCustomColorSelected ? 2.5 : 1.5,
                        ),
                        boxShadow: isCustomColorSelected
                            ? [
                                BoxShadow(
                                  color: _parseColor(_selectedColor).withValues(alpha: 0.5),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ]
                            : null,
                      ),
                      child: isCustomColorSelected
                          ? const Icon(Icons.check, size: 16, color: Colors.white)
                          : const Icon(Icons.colorize_rounded, size: 14, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            if (_showCustomColorPicker) ...[
              const SizedBox(height: 14),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: colors.inputBg,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: isCustomColorSelected
                        ? _parseColor(_selectedColor).withValues(alpha: 0.5)
                        : colors.cardBorder,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                            color: _parseColor(_selectedColor),
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                            boxShadow: [
                              BoxShadow(
                                color: _parseColor(_selectedColor).withValues(alpha: 0.4),
                                blurRadius: 6,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Pilihan Warna Kustom (HSL)',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: colors.textPrimary,
                              ),
                            ),
                            Text(
                              'Kode: #${_selectedColor.replaceAll('0xFF', '').replaceAll('0xff', '')}',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: colors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Hue (Warna)',
                          style: TextStyle(fontSize: 11, color: colors.textSecondary),
                        ),
                        Text(
                          '${_hue.round()}°',
                          style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: colors.textPrimary),
                        ),
                      ],
                    ),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        trackHeight: 6,
                        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 7),
                      ),
                      child: Slider(
                        value: _hue,
                        min: 0.0,
                        max: 360.0,
                        activeColor: _parseColor(_selectedColor),
                        inactiveColor: colors.cardBorder,
                        onChanged: (val) {
                          _hue = val;
                          _updateHslColor();
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Saturasi',
                          style: TextStyle(fontSize: 11, color: colors.textSecondary),
                        ),
                        Text(
                          '${(_saturation * 100).round()}%',
                          style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: colors.textPrimary),
                        ),
                      ],
                    ),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        trackHeight: 6,
                        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 7),
                      ),
                      child: Slider(
                        value: _saturation,
                        min: 0.0,
                        max: 1.0,
                        activeColor: _parseColor(_selectedColor),
                        inactiveColor: colors.cardBorder,
                        onChanged: (val) {
                          _saturation = val;
                          _updateHslColor();
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Kecerahan',
                          style: TextStyle(fontSize: 11, color: colors.textSecondary),
                        ),
                        Text(
                          '${(_lightness * 100).round()}%',
                          style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: colors.textPrimary),
                        ),
                      ],
                    ),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        trackHeight: 6,
                        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 7),
                      ),
                      child: Slider(
                        value: _lightness,
                        min: 0.15,
                        max: 0.85,
                        activeColor: _parseColor(_selectedColor),
                        inactiveColor: colors.cardBorder,
                        onChanged: (val) {
                          _lightness = val;
                          _updateHslColor();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
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

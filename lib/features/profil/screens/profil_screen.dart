import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/app_header.dart';
import '../../../core/widgets/fade_slide_entrance.dart';
import '../../../core/widgets/floating_notification.dart';
import '../../../data/repositories/profile_repo.dart';
import '../../../providers/theme_provider.dart';
import 'photo_crop_screen.dart';

class ProfilScreen extends StatefulWidget {
  const ProfilScreen({super.key});

  @override
  State<ProfilScreen> createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
  final ProfileRepository _profileRepo = ProfileRepository();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _customJobController = TextEditingController();

  String _selectedJob = 'Pelajar';
  String? _avatarPath;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final profile = await _profileRepo.getProfile();
    setState(() {
      _nameController.text = profile.name;
      _ageController.text = profile.age.toString();
      _avatarPath = profile.avatarPath;

      if (ProfileRepository.availableOccupations.contains(profile.occupation)) {
        _selectedJob = profile.occupation;
      } else {
        _selectedJob = 'Lainnya';
        _customJobController.text = profile.occupation;
      }
      _isLoading = false;
    });
  }

  Future<void> _saveProfile({bool showToast = true}) async {
    final name = _nameController.text.trim();
    final age = int.tryParse(_ageController.text.trim()) ?? 17;
    final occupation = _selectedJob == 'Lainnya' && _customJobController.text.trim().isNotEmpty
        ? _customJobController.text.trim()
        : _selectedJob;

    final updated = UserProfile(
      name: name.isNotEmpty ? name : 'Pengguna',
      age: age,
      occupation: occupation,
      avatarPath: _avatarPath,
    );

    await _profileRepo.saveProfile(updated);

    if (mounted && showToast) {
      FloatingNotification.showSuccess(
        context,
        title: 'Profil Berhasil Disimpan',
        message: 'Informasi akun & pekerjaan Anda telah diperbarui.',
      );
      setState(() {});
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final picker = ImagePicker();
      final picked = await picker.pickImage(
        source: source,
        maxWidth: 1200,
        maxHeight: 1200,
        imageQuality: 90,
      );
      if (picked != null && mounted) {
        final File? croppedFile = await Navigator.push<File>(
          context,
          MaterialPageRoute(
            builder: (_) => PhotoCropScreen(imageFile: File(picked.path)),
          ),
        );

        if (croppedFile != null) {
          final appDir = await getApplicationDocumentsDirectory();
          final fileName = 'avatar_${DateTime.now().millisecondsSinceEpoch}.png';
          final savedFile = await croppedFile.copy('${appDir.path}/$fileName');

          if (_avatarPath != null && _avatarPath!.isNotEmpty) {
            final old = File(_avatarPath!);
            if (old.existsSync()) {
              try {
                old.deleteSync();
              } catch (_) {}
            }
          }

          setState(() {
            _avatarPath = savedFile.path;
          });

          await _saveProfile(showToast: false);

          if (mounted) {
            FloatingNotification.showSuccess(
              context,
              title: 'Foto Profil Diperbarui',
              message: 'Foto profil berhasil disesuaikan & disimpan!',
            );
          }
        }
      }
    } catch (e) {
      if (mounted) {
        FloatingNotification.showError(
          context,
          title: 'Gagal Memilih Foto',
          message: '$e',
        );
      }
    }
  }

  void _showImagePickerSheet() {
    final colors = context.colors;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        decoration: BoxDecoration(
          color: colors.cardSurface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          border: Border.all(color: colors.cardBorder),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
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
            const SizedBox(height: 18),
            Text(
              'Foto Profil',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: colors.textPrimary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Pilih sumber foto profil Anda',
              style: TextStyle(
                fontSize: 13,
                color: colors.textSecondary,
              ),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: colors.primaryPillBg,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.camera_alt_outlined, color: colors.primaryGreen),
              ),
              title: Text(
                'Ambil dari Kamera',
                style: TextStyle(fontWeight: FontWeight.w600, color: colors.textPrimary),
              ),
              onTap: () {
                Navigator.pop(ctx);
                _pickImage(ImageSource.camera);
              },
            ),
            const SizedBox(height: 8),
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: colors.primaryPillBg,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.photo_library_outlined, color: colors.primaryGreen),
              ),
              title: Text(
                'Pilih dari Galeri',
                style: TextStyle(fontWeight: FontWeight.w600, color: colors.textPrimary),
              ),
              onTap: () {
                Navigator.pop(ctx);
                _pickImage(ImageSource.gallery);
              },
            ),
            if (_avatarPath != null && _avatarPath!.isNotEmpty) ...[
              const SizedBox(height: 8),
              ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.red.shade900.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(Icons.delete_outline, color: Colors.red.shade400),
                ),
                title: Text(
                  'Hapus Foto Profil',
                  style: TextStyle(fontWeight: FontWeight.w600, color: Colors.red.shade400),
                ),
                onTap: () async {
                  Navigator.pop(ctx);
                  if (_avatarPath != null) {
                    final old = File(_avatarPath!);
                    if (old.existsSync()) {
                      try {
                        old.deleteSync();
                      } catch (_) {}
                    }
                  }
                  setState(() {
                    _avatarPath = null;
                  });
                  await _saveProfile(showToast: false);
                  if (mounted) {
                    FloatingNotification.showInfo(
                      context,
                      title: 'Foto Profil Dihapus',
                      message: 'Foto profil kembali menggunakan avatar bawaan.',
                    );
                  }
                },
              ),
            ],
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  IconData _getJobIcon(String job) {
    switch (job.toLowerCase()) {
      case 'pelajar':
      case 'mahasiswa':
        return Icons.school_outlined;
      case 'karyawan swasta':
      case 'pns / asn / bumn':
        return Icons.badge_outlined;
      case 'wiraswasta / pengusaha':
        return Icons.storefront_outlined;
      case 'freelancer / kreator':
        return Icons.laptop_chromebook_outlined;
      case 'ibu rumah tangga':
        return Icons.home_outlined;
      default:
        return Icons.work_outline;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _customJobController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    if (_isLoading) {
      return Center(
        child: CircularProgressIndicator(color: colors.primaryGreen),
      );
    }

    final currentJob = _selectedJob == 'Lainnya' && _customJobController.text.trim().isNotEmpty
        ? _customJobController.text.trim()
        : _selectedJob;

    final hasValidAvatar = _avatarPath != null && File(_avatarPath!).existsSync();

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const FadeSlideEntrance(
          delayMs: 0,
          child: SimpananAppHeader(),
        ),
        const SizedBox(height: 18),
        FadeSlideEntrance(
          delayMs: 40,
          child: Text(
            'Profil Pengguna',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: colors.textPrimary,
            ),
          ),
        ),
        const SizedBox(height: 16),

        FadeSlideEntrance(
          delayMs: 80,
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: colors.cardSurface,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: colors.cardBorder),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: colors.isDark ? 0.2 : 0.03),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: _showImagePickerSheet,
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: colors.primaryGreen.withValues(alpha: 0.45),
                            width: 2.5,
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 38,
                          backgroundColor: colors.primaryGreen.withValues(alpha: 0.15),
                          backgroundImage: hasValidAvatar ? FileImage(File(_avatarPath!)) : null,
                          child: !hasValidAvatar
                              ? Text(
                                  _nameController.text.trim().isNotEmpty
                                      ? _nameController.text.trim()[0].toUpperCase()
                                      : 'S',
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w800,
                                    color: colors.primaryGreen,
                                  ),
                                )
                              : null,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: colors.primaryGreen,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: colors.cardSurface,
                              width: 2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.25),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.camera_alt,
                            size: 14,
                            color: colors.isDark ? const Color(0xFF0F1411) : Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _nameController.text.trim().isNotEmpty
                            ? _nameController.text.trim()
                            : 'Pengguna',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: colors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      GestureDetector(
                        onTap: _showImagePickerSheet,
                        child: Text(
                          'Ubah Foto Profil',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: colors.primaryGreen,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 6,
                        runSpacing: 4,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: colors.primaryPillBg,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(_getJobIcon(currentJob), size: 12, color: colors.primaryGreen),
                                const SizedBox(width: 4),
                                Text(
                                  currentJob,
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                    color: colors.primaryGreen,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: colors.inputBg,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: colors.cardBorder),
                            ),
                            child: Text(
                              '${_ageController.text.trim().isNotEmpty ? _ageController.text.trim() : "17"} Tahun',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: colors.textSecondary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),

        FadeSlideEntrance(
          delayMs: 110,
          child: Consumer<ThemeProvider>(
            builder: (context, themeProvider, _) {
              final activePref = themeProvider.preference;

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
                    Row(
                      children: [
                        Icon(
                          Icons.palette_outlined,
                          color: colors.primaryGreen,
                          size: 22,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Tema Tampilan',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: colors.textPrimary,
                          ),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: colors.primaryPillBg,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            activePref.label,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: colors.primaryGreen,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Pilih tema tampilan atau sesuaikan otomatis dengan preferensi perangkat Anda.',
                      style: TextStyle(
                        fontSize: 12,
                        color: colors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 16),

                    Row(
                      children: AppThemeModePreference.values.map((pref) {
                        final isSelected = activePref == pref;

                        return Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: InkWell(
                              onTap: () => themeProvider.setThemePreference(pref),
                              borderRadius: BorderRadius.circular(12),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 220),
                                curve: Curves.easeOutCubic,
                                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                                decoration: BoxDecoration(
                                  color: isSelected ? colors.primaryPillBg : colors.inputBg,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: isSelected ? colors.primaryGreen : colors.cardBorder,
                                    width: isSelected ? 1.8 : 1,
                                  ),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      pref.icon,
                                      size: 22,
                                      color: isSelected ? colors.primaryGreen : colors.textSecondary,
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      pref.label,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                                        color: isSelected ? colors.primaryGreen : colors.textPrimary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: colors.inputBg,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            size: 16,
                            color: colors.primaryGreen,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              activePref == AppThemeModePreference.system
                                  ? 'Mode Sistem: Palet hijau menyesuaikan otomatis (lebih gelap di mode terang, lebih cerah di mode gelap).'
                                  : activePref == AppThemeModePreference.light
                                      ? 'Mode Terang: Palet hijau dirancang lebih gelap & elegan untuk kontras tajam.'
                                      : 'Mode Gelap: Palet hijau dirancang lebih cerah & bercahaya untuk kenyamanan visual.',
                              style: TextStyle(
                                fontSize: 11,
                                color: colors.textSecondary,
                                height: 1.3,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        FadeSlideEntrance(
          delayMs: 140,
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: colors.cardSurface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: colors.cardBorder),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.edit_note_outlined, color: colors.primaryGreen, size: 22),
                    const SizedBox(width: 8),
                    Text(
                      'Informasi Akun & Pekerjaan',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: colors.textPrimary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  'Nama Lengkap',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: colors.textSecondary),
                ),
                const SizedBox(height: 6),
                TextField(
                  controller: _nameController,
                  style: TextStyle(color: colors.textPrimary),
                  decoration: InputDecoration(
                    hintText: 'Contoh: Budi Santoso',
                    hintStyle: TextStyle(color: colors.textMuted),
                    prefixIcon: Icon(Icons.person_outline, size: 20, color: colors.textSecondary),
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
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  'Umur',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: colors.textSecondary),
                ),
                const SizedBox(height: 6),
                TextField(
                  controller: _ageController,
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: colors.textPrimary),
                  decoration: InputDecoration(
                    hintText: 'Contoh: 17',
                    hintStyle: TextStyle(color: colors.textMuted),
                    prefixIcon: Icon(Icons.cake_outlined, size: 20, color: colors.textSecondary),
                    suffixText: 'Tahun',
                    suffixStyle: TextStyle(color: colors.textSecondary, fontWeight: FontWeight.w600),
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
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  'Pekerjaan',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: colors.textSecondary),
                ),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  decoration: BoxDecoration(
                    color: colors.inputBg,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: colors.cardBorder),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      dropdownColor: colors.cardSurface,
                      value: _selectedJob,
                      icon: Icon(Icons.keyboard_arrow_down, color: colors.textSecondary),
                      items: ProfileRepository.availableOccupations.map((job) {
                        return DropdownMenuItem<String>(
                          value: job,
                          child: Row(
                            children: [
                              Icon(_getJobIcon(job), size: 18, color: colors.primaryGreen),
                              const SizedBox(width: 10),
                              Text(
                                job,
                                style: TextStyle(fontSize: 14, color: colors.textPrimary),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: (val) {
                        if (val != null) {
                          setState(() => _selectedJob = val);
                        }
                      },
                    ),
                  ),
                ),

                if (_selectedJob == 'Lainnya') ...[
                  const SizedBox(height: 12),
                  TextField(
                    controller: _customJobController,
                    style: TextStyle(color: colors.textPrimary),
                    decoration: InputDecoration(
                      hintText: 'Tulis pekerjaan Anda...',
                      hintStyle: TextStyle(color: colors.textMuted),
                      prefixIcon: Icon(Icons.work_outline, size: 20, color: colors.textSecondary),
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
                    ),
                  ),
                ],

                const SizedBox(height: 18),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () => _saveProfile(showToast: true),
                    icon: Icon(
                      Icons.check,
                      size: 18,
                      color: colors.isDark ? const Color(0xFF0F1411) : Colors.white,
                    ),
                    label: Text(
                      'Simpan Perubahan Profil',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: colors.isDark ? const Color(0xFF0F1411) : Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colors.primaryGreen,
                      foregroundColor: colors.isDark ? const Color(0xFF0F1411) : Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),

        FadeSlideEntrance(
          delayMs: 180,
          child: Center(
            child: Column(
              children: [
                Text(
                  'SIMPanan v1.2.10 (Patch 1.2.10)',
                  style: TextStyle(
                    fontSize: 12,
                    color: colors.textSecondary.withValues(alpha: 0.8),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Aplikasi Pengelola Keuangan Pribadi Offline & Aman',
                  style: TextStyle(
                    fontSize: 11,
                    color: colors.textSecondary.withValues(alpha: 0.6),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 32),
      ],
    );
  }
}
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/app_header.dart';
import '../../../core/widgets/fade_slide_entrance.dart';
import '../../../data/repositories/profile_repo.dart';
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
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Profil berhasil diperbarui!'),
          backgroundColor: AppColors.primaryGreen,
        ),
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
        // Buka layar crop interaktif yang sangat halus tanpa lag
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

          // Hapus file avatar lama jika ada
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
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Foto profil berhasil disesuaikan & disimpan!'),
                backgroundColor: AppColors.primaryGreen,
              ),
            );
          }
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal memilih foto: $e'),
            backgroundColor: Colors.red.shade700,
          ),
        );
      }
    }
  }

  void _showImagePickerSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
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
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 18),
            const Text(
              'Foto Profil',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Pilih sumber foto profil Anda',
              style: TextStyle(
                fontSize: 13,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.primaryPillBg,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.camera_alt_outlined, color: AppColors.primaryGreen),
              ),
              title: const Text('Ambil dari Kamera', style: TextStyle(fontWeight: FontWeight.w600)),
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
                  color: AppColors.primaryPillBg,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.photo_library_outlined, color: AppColors.primaryGreen),
              ),
              title: const Text('Pilih dari Galeri', style: TextStyle(fontWeight: FontWeight.w600)),
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
                    color: Colors.red.shade50,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(Icons.delete_outline, color: Colors.red.shade600),
                ),
                title: Text('Hapus Foto Profil', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.red.shade600)),
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
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Foto profil berhasil dihapus.'),
                        backgroundColor: AppColors.primaryGreen,
                      ),
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
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
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
        // Judul Halaman
        const FadeSlideEntrance(
          delayMs: 40,
          child: Text(
            'Profil Pengguna',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
          ),
        ),
        const SizedBox(height: 16),

        // 1. Hero Card Profil Pengguna dengan Foto Avatar Interaktif
        FadeSlideEntrance(
          delayMs: 80,
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.cardBorder),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.03),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                // Avatar Interaktif (Bisa upload/ganti foto profil)
                GestureDetector(
                  onTap: _showImagePickerSheet,
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.primaryGreen.withValues(alpha: 0.35),
                            width: 2.5,
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 38,
                          backgroundColor: AppColors.primaryGreen.withValues(alpha: 0.12),
                          backgroundImage: hasValidAvatar ? FileImage(File(_avatarPath!)) : null,
                          child: !hasValidAvatar
                              ? Text(
                                  _nameController.text.trim().isNotEmpty
                                      ? _nameController.text.trim()[0].toUpperCase()
                                      : 'S',
                                  style: const TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.primaryGreen,
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
                            color: AppColors.primaryGreen,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.2),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.camera_alt,
                            size: 14,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                // Nama & Badge Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _nameController.text.trim().isNotEmpty
                            ? _nameController.text.trim()
                            : 'Pengguna',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      GestureDetector(
                        onTap: _showImagePickerSheet,
                        child: const Text(
                          'Ubah Foto Profil',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primaryGreen,
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Wrap(
                        spacing: 6,
                        runSpacing: 4,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppColors.primaryPillBg,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(_getJobIcon(currentJob), size: 12, color: AppColors.primaryGreen),
                                const SizedBox(width: 4),
                                Text(
                                  currentJob,
                                  style: const TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.primaryGreen,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppColors.background,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: AppColors.cardBorder),
                            ),
                            child: Text(
                              '${_ageController.text.trim().isNotEmpty ? _ageController.text.trim() : "17"} Tahun',
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textSecondary,
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

        // 2. Form Edit Profil (Nama, Umur, Pekerjaan)
        FadeSlideEntrance(
          delayMs: 140,
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.cardBorder),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.edit_note_outlined, color: AppColors.primaryGreen, size: 22),
                    SizedBox(width: 8),
                    Text(
                      'Informasi Akun & Pekerjaan',
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Input Nama
                const Text(
                  'Nama Lengkap',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textSecondary),
                ),
                const SizedBox(height: 6),
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    hintText: 'Contoh: Budi Santoso',
                    prefixIcon: const Icon(Icons.person_outline, size: 20),
                    filled: true,
                    fillColor: AppColors.background,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 14),

                // Input Umur
                const Text(
                  'Umur',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textSecondary),
                ),
                const SizedBox(height: 6),
                TextField(
                  controller: _ageController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Contoh: 17',
                    prefixIcon: const Icon(Icons.cake_outlined, size: 20),
                    suffixText: 'Tahun',
                    filled: true,
                    fillColor: AppColors.background,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 14),

                // Pilihan Pekerjaan
                const Text(
                  'Pekerjaan',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textSecondary),
                ),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: _selectedJob,
                      icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.textSecondary),
                      items: ProfileRepository.availableOccupations.map((job) {
                        return DropdownMenuItem<String>(
                          value: job,
                          child: Row(
                            children: [
                              Icon(_getJobIcon(job), size: 18, color: AppColors.primaryGreen),
                              const SizedBox(width: 10),
                              Text(job, style: const TextStyle(fontSize: 14)),
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

                // Jika memilih 'Lainnya', tampilkan input khusus
                if (_selectedJob == 'Lainnya') ...[
                  const SizedBox(height: 12),
                  TextField(
                    controller: _customJobController,
                    decoration: InputDecoration(
                      hintText: 'Tulis pekerjaan Anda...',
                      prefixIcon: const Icon(Icons.work_outline, size: 20),
                      filled: true,
                      fillColor: AppColors.background,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ],

                const SizedBox(height: 18),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () => _saveProfile(showToast: true),
                    icon: const Icon(Icons.check, size: 18),
                    label: const Text('Simpan Perubahan Profil'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryGreen,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),

        // 3. Informasi Patch & Versi
        FadeSlideEntrance(
          delayMs: 200,
          child: Center(
            child: Column(
              children: [
                Text(
                  'SIMPanan v1.1.11 (Patch 1.1.11)',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary.withValues(alpha: 0.8),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Aplikasi Pengelola Keuangan Pribadi Offline & Aman',
                  style: TextStyle(
                    fontSize: 11,
                    color: AppColors.textSecondary.withValues(alpha: 0.6),
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
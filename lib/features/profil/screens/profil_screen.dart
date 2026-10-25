import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/app_header.dart';
import '../../../data/repositories/profile_repo.dart';

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

      if (ProfileRepository.availableOccupations.contains(profile.occupation)) {
        _selectedJob = profile.occupation;
      } else {
        _selectedJob = 'Lainnya';
        _customJobController.text = profile.occupation;
      }
      _isLoading = false;
    });
  }

  Future<void> _saveProfile() async {
    final name = _nameController.text.trim();
    final age = int.tryParse(_ageController.text.trim()) ?? 17;
    final occupation = _selectedJob == 'Lainnya' && _customJobController.text.trim().isNotEmpty
        ? _customJobController.text.trim()
        : _selectedJob;

    final updated = UserProfile(
      name: name.isNotEmpty ? name : 'Pengguna',
      age: age,
      occupation: occupation,
    );

    await _profileRepo.saveProfile(updated);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Profil berhasil diperbarui!'),
          backgroundColor: AppColors.primaryGreen,
        ),
      );
      setState(() {});
    }
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

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const SimpananAppHeader(),
        const SizedBox(height: 18),
        // Judul Halaman
        const Text(
          'Profil Pengguna',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 16),

        // 1. Hero Card Profil Pengguna
        Container(
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
              // Avatar dengan Badge Pekerjaan
              Stack(
                children: [
                  CircleAvatar(
                    radius: 36,
                    backgroundColor: AppColors.primaryGreen.withValues(alpha: 0.12),
                    child: Text(
                      _nameController.text.trim().isNotEmpty
                          ? _nameController.text.trim()[0].toUpperCase()
                          : 'S',
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        color: AppColors.primaryGreen,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: AppColors.primaryGreen,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        _getJobIcon(currentJob),
                        size: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
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
        const SizedBox(height: 16),

        // 2. Form Edit Profil (Nama, Umur, Pekerjaan)
        Container(
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
                  onPressed: _saveProfile,
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
        const SizedBox(height: 24),

        // 3. Informasi Patch & Versi
        Center(
          child: Column(
            children: [
              Text(
                'SIMPanan v1.0.3 (Patch 1.0.3)',
                style: TextStyle(fontSize: 12, color: AppColors.textSecondary.withValues(alpha: 0.8), fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 4),
              Text(
                'Aplikasi Pengelola Keuangan Pribadi Offline & Aman',
                style: TextStyle(fontSize: 11, color: AppColors.textSecondary.withValues(alpha: 0.6)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),
      ],
    );
  }
}
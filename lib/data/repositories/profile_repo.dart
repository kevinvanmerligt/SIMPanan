import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserProfile {
  final String name;
  final int age;
  final String occupation;
  final String? avatarPath;
  final DateTime? birthDate;

  const UserProfile({
    required this.name,
    required this.age,
    required this.occupation,
    this.avatarPath,
    this.birthDate,
  });

  bool get isUnder18 => age < 18;

  UserProfile copyWith({
    String? name,
    int? age,
    String? occupation,
    String? avatarPath,
    DateTime? birthDate,
    bool clearAvatar = false,
  }) {
    return UserProfile(
      name: name ?? this.name,
      age: age ?? this.age,
      occupation: occupation ?? this.occupation,
      avatarPath: clearAvatar ? null : (avatarPath ?? this.avatarPath),
      birthDate: birthDate ?? this.birthDate,
    );
  }

  static int calculateAge(DateTime birthDate) {
    final now = DateTime.now();
    int age = now.year - birthDate.year;
    if (now.month < birthDate.month ||
        (now.month == birthDate.month && now.day < birthDate.day)) {
      age--;
    }
    return age < 0 ? 0 : age;
  }
}

class ProfileRepository {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  static const String _keyName = 'simpanan_user_name';
  static const String _keyAge = 'simpanan_user_age';
  static const String _keyOccupation = 'simpanan_user_occupation';
  static const String _keyAvatar = 'simpanan_user_avatar';
  static const String _keyBirthDate = 'simpanan_user_birthdate';

  static const List<String> availableOccupations = [
    'Pelajar',
    'Mahasiswa',
    'Karyawan Swasta',
    'PNS / ASN / BUMN',
    'Wiraswasta / Pengusaha',
    'Freelancer / Kreator',
    'Ibu Rumah Tangga',
    'Lainnya',
  ];

  Future<UserProfile> getProfile() async {
    final name = await _storage.read(key: _keyName) ?? '';
    final ageStr = await _storage.read(key: _keyAge) ?? '17';
    final occupation = await _storage.read(key: _keyOccupation) ?? 'Pelajar';
    final avatar = await _storage.read(key: _keyAvatar);
    final birthDateStr = await _storage.read(key: _keyBirthDate);

    String? validAvatarPath;
    if (avatar != null && avatar.isNotEmpty) {
      if (File(avatar).existsSync()) {
        validAvatarPath = avatar;
      }
    }

    DateTime? birthDate;
    int age = int.tryParse(ageStr) ?? 17;

    if (birthDateStr != null && birthDateStr.isNotEmpty) {
      birthDate = DateTime.tryParse(birthDateStr);
      if (birthDate != null) {
        age = UserProfile.calculateAge(birthDate);
      }
    }

    return UserProfile(
      name: name,
      age: age,
      occupation: occupation,
      avatarPath: validAvatarPath,
      birthDate: birthDate,
    );
  }

  Future<void> saveProfile(UserProfile profile) async {
    await _storage.write(key: _keyName, value: profile.name);
    await _storage.write(key: _keyAge, value: profile.age.toString());
    await _storage.write(key: _keyOccupation, value: profile.occupation);
    if (profile.avatarPath != null && profile.avatarPath!.isNotEmpty) {
      await _storage.write(key: _keyAvatar, value: profile.avatarPath);
    } else {
      await _storage.delete(key: _keyAvatar);
    }
    if (profile.birthDate != null) {
      await _storage.write(key: _keyBirthDate, value: profile.birthDate!.toIso8601String());
    } else {
      await _storage.delete(key: _keyBirthDate);
    }
  }
}

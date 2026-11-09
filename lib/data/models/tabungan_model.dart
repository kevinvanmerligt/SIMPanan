import 'package:flutter/material.dart';

class TabunganModel {
  final int? id;
  final String name;
  final int targetAmount;
  final String iconName;
  final String colorHex;
  final bool isPrimary;
  final DateTime createdAt;
  final int currentBalance;

  TabunganModel({
    this.id,
    required this.name,
    this.targetAmount = 0,
    this.iconName = 'savings',
    this.colorHex = '0xFF059669',
    this.isPrimary = false,
    required this.createdAt,
    this.currentBalance = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'target_amount': targetAmount,
      'icon_name': iconName,
      'color_hex': colorHex,
      'is_primary': isPrimary ? 1 : 0,
      'created_at': createdAt.toIso8601String(),
    };
  }

  factory TabunganModel.fromMap(Map<String, dynamic> map, {int currentBalance = 0}) {
    return TabunganModel(
      id: map['id'] as int?,
      name: map['name'] as String,
      targetAmount: (map['target_amount'] as int?) ?? 0,
      iconName: (map['icon_name'] as String?) ?? 'savings',
      colorHex: (map['color_hex'] as String?) ?? '0xFF059669',
      isPrimary: ((map['is_primary'] as int?) ?? 0) == 1,
      createdAt: map['created_at'] != null
          ? DateTime.parse(map['created_at'] as String)
          : DateTime.now(),
      currentBalance: currentBalance,
    );
  }

  TabunganModel copyWith({
    int? id,
    String? name,
    int? targetAmount,
    String? iconName,
    String? colorHex,
    bool? isPrimary,
    DateTime? createdAt,
    int? currentBalance,
  }) {
    return TabunganModel(
      id: id ?? this.id,
      name: name ?? this.name,
      targetAmount: targetAmount ?? this.targetAmount,
      iconName: iconName ?? this.iconName,
      colorHex: colorHex ?? this.colorHex,
      isPrimary: isPrimary ?? this.isPrimary,
      createdAt: createdAt ?? this.createdAt,
      currentBalance: currentBalance ?? this.currentBalance,
    );
  }

  double get progress {
    if (targetAmount <= 0) return 0.0;
    return (currentBalance / targetAmount).clamp(0.0, 1.0);
  }

  int get remainingToTarget {
    if (targetAmount <= 0) return 0;
    final diff = targetAmount - currentBalance;
    return diff > 0 ? diff : 0;
  }

  bool get isTargetAchieved => targetAmount > 0 && currentBalance >= targetAmount;

  Color get color {
    try {
      final value = int.parse(colorHex.replaceFirst('#', '').replaceFirst('0x', ''), radix: 16);
      return Color(value > 0xFFFFFF ? value : value | 0xFF000000);
    } catch (_) {
      return const Color(0xFF059669);
    }
  }

  IconData get iconData {
    switch (iconName) {
      case 'laptop':
        return Icons.laptop_mac_rounded;
      case 'home':
        return Icons.home_rounded;
      case 'car':
        return Icons.directions_car_rounded;
      case 'vacation':
        return Icons.flight_takeoff_rounded;
      case 'emergency':
        return Icons.health_and_safety_rounded;
      case 'phone':
        return Icons.smartphone_rounded;
      case 'school':
        return Icons.school_rounded;
      case 'shopping':
        return Icons.shopping_bag_rounded;
      case 'star':
        return Icons.star_rounded;
      case 'savings':
      default:
        return Icons.savings_rounded;
    }
  }

  static const List<Map<String, dynamic>> availableIcons = [
    {'name': 'savings', 'label': 'Utama', 'icon': Icons.savings_rounded},
    {'name': 'laptop', 'label': 'Gadget/Laptop', 'icon': Icons.laptop_mac_rounded},
    {'name': 'phone', 'label': 'HP/Ponsel', 'icon': Icons.smartphone_rounded},
    {'name': 'vacation', 'label': 'Liburan', 'icon': Icons.flight_takeoff_rounded},
    {'name': 'car', 'label': 'Kendaraan', 'icon': Icons.directions_car_rounded},
    {'name': 'home', 'label': 'Rumah', 'icon': Icons.home_rounded},
    {'name': 'emergency', 'label': 'Darurat', 'icon': Icons.health_and_safety_rounded},
    {'name': 'school', 'label': 'Pendidikan', 'icon': Icons.school_rounded},
    {'name': 'shopping', 'label': 'Wishlist', 'icon': Icons.shopping_bag_rounded},
    {'name': 'star', 'label': 'Impian', 'icon': Icons.star_rounded},
  ];

  static const List<String> availableColors = [
    '0xFF059669', // Emerald Green
    '0xFF2563EB', // Blue
    '0xFFD97706', // Amber
    '0xFFDC2626', // Red
    '0xFF7C3AED', // Purple
    '0xFFDB2777', // Pink
    '0xFF0D9488', // Teal
    '0xFF4F46E5', // Indigo
  ];
}


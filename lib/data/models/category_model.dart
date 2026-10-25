class CategoryModel {
  final int? id;
  final String name;
  final String type; // 'EXPENSE' atau 'INCOME'
  final String iconName;

  CategoryModel({
    this.id,
    required this.name,
    required this.type,
    required this.iconName,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'icon_name': iconName,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'] as int?,
      name: map['name'] as String,
      type: map['type'] as String,
      iconName: map['icon_name'] as String,
    );
  }
}
class TransactionModel {
  final int? id;
  final String title;
  final String category;
  final String type;
  final int amount;
  final DateTime date;
  final int tabunganId;
  final String tabunganName;

  TransactionModel({
    this.id,
    required this.title,
    required this.category,
    required this.type,
    required this.amount,
    required this.date,
    this.tabunganId = 1,
    this.tabunganName = 'Tabungan Utama',
  });

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'title': title,
      'category': category,
      'type': type,
      'amount': amount,
      'date': date.toIso8601String(),
      'tabungan_id': tabunganId,
      'tabungan_name': tabunganName,
    };
  }

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      id: map['id'] as int?,
      title: map['title'] as String,
      category: map['category'] as String,
      type: map['type'] as String,
      amount: map['amount'] as int,
      date: DateTime.parse(map['date'] as String),
      tabunganId: (map['tabungan_id'] as int?) ?? 1,
      tabunganName: (map['tabungan_name'] as String?) ?? 'Tabungan Utama',
    );
  }

  TransactionModel copyWith({
    int? id,
    String? title,
    String? category,
    String? type,
    int? amount,
    DateTime? date,
    int? tabunganId,
    String? tabunganName,
  }) {
    return TransactionModel(
      id: id ?? this.id,
      title: title ?? this.title,
      category: category ?? this.category,
      type: type ?? this.type,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      tabunganId: tabunganId ?? this.tabunganId,
      tabunganName: tabunganName ?? this.tabunganName,
    );
  }
}

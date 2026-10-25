class TransactionModel {
  final int? id;
  final String title;
  final String category;
  final String type; // 'EXPENSE' atau 'INCOME'
  final int amount;
  final DateTime date;

  TransactionModel({
    this.id,
    required this.title,
    required this.category,
    required this.type,
    required this.amount,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'category': category,
      'type': type,
      'amount': amount,
      'date': date.toIso8601String(),
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
    );
  }
}
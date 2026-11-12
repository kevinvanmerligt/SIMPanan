class DebtModel {
  final int? id;
  final String title;
  final int amount;
  final int paidAmount;
  final DateTime? dueDate;
  final DateTime createdAt;
  final String? note;
  final bool isPaid;

  DebtModel({
    this.id,
    required this.title,
    required this.amount,
    this.paidAmount = 0,
    this.dueDate,
    required this.createdAt,
    this.note,
    bool? isPaid,
  }) : isPaid = isPaid ?? (paidAmount >= amount);

  int get remainingAmount => (amount - paidAmount) > 0 ? (amount - paidAmount) : 0;
  double get progress => amount > 0 ? (paidAmount / amount).clamp(0.0, 1.0) : 0.0;

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'title': title,
      'amount': amount,
      'paid_amount': paidAmount,
      'due_date': dueDate?.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'note': note,
      'is_paid': isPaid ? 1 : 0,
    };
  }

  factory DebtModel.fromMap(Map<String, dynamic> map) {
    final amount = map['amount'] as int;
    final paidAmount = (map['paid_amount'] as int?) ?? 0;
    final isPaidVal = map['is_paid'] as int?;

    return DebtModel(
      id: map['id'] as int?,
      title: map['title'] as String,
      amount: amount,
      paidAmount: paidAmount,
      dueDate: map['due_date'] != null ? DateTime.tryParse(map['due_date'] as String) : null,
      createdAt: DateTime.parse(map['created_at'] as String),
      note: map['note'] as String?,
      isPaid: isPaidVal != null ? (isPaidVal == 1) : (paidAmount >= amount),
    );
  }

  DebtModel copyWith({
    int? id,
    String? title,
    int? amount,
    int? paidAmount,
    DateTime? dueDate,
    DateTime? createdAt,
    String? note,
    bool? isPaid,
  }) {
    return DebtModel(
      id: id ?? this.id,
      title: title ?? this.title,
      amount: amount ?? this.amount,
      paidAmount: paidAmount ?? this.paidAmount,
      dueDate: dueDate ?? this.dueDate,
      createdAt: createdAt ?? this.createdAt,
      note: note ?? this.note,
      isPaid: isPaid ?? this.isPaid,
    );
  }
}


class DailySummaryModel {
  final int initialBalance; // Contoh: mulai Rp250.000
  final int totalIncome;
  final int totalExpense;
  final int transactionCount;

  DailySummaryModel({
    required this.initialBalance,
    required this.totalIncome,
    required this.totalExpense,
    required this.transactionCount,
  });

  // Rumus Sisa Saldo Hari Ini (Contoh: 350.000 - 288.000 = 62.000)
  int get remainingBalance => totalIncome - totalExpense;
}
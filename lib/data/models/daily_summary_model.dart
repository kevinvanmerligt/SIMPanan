class DailySummaryModel {
  final int initialBalance;
  final int totalIncome;
  final int totalExpense;
  final int totalDebt;
  final int transactionCount;

  DailySummaryModel({
    required this.initialBalance,
    required this.totalIncome,
    required this.totalExpense,
    this.totalDebt = 0,
    required this.transactionCount,
  });

  int get remainingBalance => totalIncome - totalExpense - totalDebt;
  int get netCashFlow => totalIncome - totalExpense;
}

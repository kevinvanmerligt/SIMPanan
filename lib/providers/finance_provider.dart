import 'package:flutter/material.dart';
import '../data/models/daily_summary_model.dart';
import '../data/models/transaction_model.dart';
import '../data/repositories/transaction_repo.dart';

class FinanceProvider extends ChangeNotifier {
  final TransactionRepository _repo = TransactionRepository();

  List<TransactionModel> _allTransactions = [];
  int _startingBudget = 0;
  String _selectedFilter = 'Semua'; // 'Semua', 'Pemasukan', 'Pengeluaran'
  bool _isLoading = true;

  List<TransactionModel> get allTransactions => _allTransactions;
  int get startingBudget => _startingBudget;
  String get selectedFilter => _selectedFilter;
  bool get isLoading => _isLoading;

  Future<void> loadInitialData() async {
    _isLoading = true;
    notifyListeners();

    _startingBudget = await _repo.getStartingBudget();
    _allTransactions = await _repo.getAllTransactions();

    _isLoading = false;
    notifyListeners();
  }

  void setFilter(String filter) {
    _selectedFilter = filter;
    notifyListeners();
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  // Transaksi khusus hari ini
  List<TransactionModel> get todayTransactions {
    final now = DateTime.now();
    return _allTransactions.where((tx) => _isSameDay(tx.date, now)).toList();
  }

  // Transaksi hari ini yang sudah difilter tab (Semua | Pemasukan | Pengeluaran)
  List<TransactionModel> get filteredTodayTransactions {
    final list = todayTransactions;
    if (_selectedFilter == 'Pemasukan') {
      return list.where((tx) => tx.type == 'INCOME').toList();
    } else if (_selectedFilter == 'Pengeluaran') {
      return list.where((tx) => tx.type == 'EXPENSE').toList();
    }
    return list;
  }

  // Ringkasan Hero Card Hari Ini
  DailySummaryModel get todaySummary {
    int income = 0;
    int expense = 0;
    for (final tx in todayTransactions) {
      if (tx.type == 'INCOME') {
        income += tx.amount;
      } else {
        expense += tx.amount;
      }
    }
    return DailySummaryModel(
      initialBalance: 0,
      totalIncome: income,
      totalExpense: expense,
      transactionCount: todayTransactions.length,
    );
  }

  // Data Grafik Pengeluaran 6 Hari Terakhir
  List<Map<String, dynamic>> get last6DaysExpenses {
    final now = DateTime.now();
    final List<Map<String, dynamic>> result = [];

    for (int i = 5; i >= 0; i--) {
      final targetDate = now.subtract(Duration(days: i));
      int dailyExpense = 0;
      for (final tx in _allTransactions) {
        if (tx.type == 'EXPENSE' && _isSameDay(tx.date, targetDate)) {
          dailyExpense += tx.amount;
        }
      }
      result.add({
        'date': targetDate,
        'amount': dailyExpense,
      });
    }
    return result;
  }

  int get total6DaysExpense {
    return last6DaysExpenses.fold(0, (sum, item) => sum + (item['amount'] as int));
  }

  // Auto-save transaksi baru
  Future<void> addTransaction({
    required String title,
    required String category,
    required String type,
    required int amount,
  }) async {
    final newTx = TransactionModel(
      title: title,
      category: category,
      type: type,
      amount: amount,
      date: DateTime.now(),
    );
    await _repo.insertTransaction(newTx);
    await loadInitialData();
  }

  Future<void> deleteTransaction(int id) async {
    await _repo.deleteTransaction(id);
    await loadInitialData();
  }

  Future<void> updateStartingBudget(int newBudget) async {
    await _repo.setStartingBudget(newBudget);
    _startingBudget = newBudget;
    notifyListeners();
  }

  Future<void> clearAllTransactions() async {
    await _repo.clearAllTransactions();
    await loadInitialData();
  }
}
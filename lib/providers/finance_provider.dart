import 'package:flutter/material.dart';
import '../data/models/daily_summary_model.dart';
import '../data/models/tabungan_model.dart';
import '../data/models/transaction_model.dart';
import '../data/repositories/transaction_repo.dart';

class FinanceProvider extends ChangeNotifier {
  final TransactionRepository _repo = TransactionRepository();

  List<TransactionModel> _allTransactions = [];
  List<TabunganModel> _allTabungan = [];
  int _startingBudget = 0;
  String _selectedFilter = 'Semua';
  int? _selectedTabunganId;
  bool _isLoading = true;

  List<TransactionModel> get allTransactions => _allTransactions;
  List<TabunganModel> get allTabungan => _allTabungan;
  int get startingBudget => _startingBudget;
  String get selectedFilter => _selectedFilter;
  int? get selectedTabunganId => _selectedTabunganId;
  bool get isLoading => _isLoading;

  TabunganModel get primaryTabungan {
    return _allTabungan.firstWhere(
      (t) => t.isPrimary,
      orElse: () => _allTabungan.isNotEmpty
          ? _allTabungan.first
          : TabunganModel(
              id: 1,
              name: 'Tabungan Utama',
              isPrimary: true,
              createdAt: DateTime.now(),
            ),
    );
  }

  TabunganModel? get selectedTabungan {
    if (_selectedTabunganId == null) return null;
    return _allTabungan.cast<TabunganModel?>().firstWhere(
          (t) => t?.id == _selectedTabunganId,
          orElse: () => null,
        );
  }

  int get totalSavingsBalance {
    return _allTabungan.fold(0, (sum, t) => sum + t.currentBalance);
  }

  Future<void> loadInitialData() async {
    _isLoading = true;
    notifyListeners();

    _startingBudget = await _repo.getStartingBudget();
    _allTransactions = await _repo.getAllTransactions();
    _allTabungan = await _repo.getAllTabungan();

    _isLoading = false;
    notifyListeners();
  }

  void setFilter(String filter) {
    _selectedFilter = filter;
    notifyListeners();
  }

  void setSelectedTabunganFilter(int? tabunganId) {
    _selectedTabunganId = tabunganId;
    notifyListeners();
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  List<TransactionModel> get transactionsForCurrentTabungan {
    if (_selectedTabunganId == null) return _allTransactions;
    return _allTransactions.where((tx) => tx.tabunganId == _selectedTabunganId).toList();
  }

  List<TransactionModel> get todayTransactions {
    final now = DateTime.now();
    final source = transactionsForCurrentTabungan;
    return source.where((tx) => _isSameDay(tx.date, now)).toList();
  }

  List<TransactionModel> get filteredTodayTransactions {
    final list = todayTransactions;
    if (_selectedFilter == 'Pemasukan') {
      return list.where((tx) => tx.type == 'INCOME').toList();
    } else if (_selectedFilter == 'Pengeluaran') {
      return list.where((tx) => tx.type == 'EXPENSE').toList();
    }
    return list;
  }

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

  List<Map<String, dynamic>> get last7DaysExpenses {
    final now = DateTime.now();
    final List<Map<String, dynamic>> result = [];
    final source = transactionsForCurrentTabungan;

    for (int i = 6; i >= 0; i--) {
      final targetDate = now.subtract(Duration(days: i));
      int dailyExpense = 0;
      for (final tx in source) {
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

  int get total7DaysExpense {
    return last7DaysExpenses.fold(0, (sum, item) => sum + (item['amount'] as int));
  }

  List<Map<String, dynamic>> get last6DaysExpenses => last7DaysExpenses;
  int get total6DaysExpense => total7DaysExpense;

  Future<void> addTransaction({
    required String title,
    required String category,
    required String type,
    required int amount,
    int? tabunganId,
    String? tabunganName,
  }) async {
    final targetId = tabunganId ?? primaryTabungan.id ?? 1;
    final targetName = tabunganName ?? primaryTabungan.name;

    final newTx = TransactionModel(
      title: title,
      category: category,
      type: type,
      amount: amount,
      date: DateTime.now(),
      tabunganId: targetId,
      tabunganName: targetName,
    );
    await _repo.insertTransaction(newTx);
    await loadInitialData();
  }

  Future<void> deleteTransaction(int id) async {
    await _repo.deleteTransaction(id);
    await loadInitialData();
  }

  Future<void> addTabungan({
    required String name,
    int targetAmount = 0,
    String iconName = 'savings',
    String colorHex = '0xFF059669',
  }) async {
    final newTabungan = TabunganModel(
      name: name,
      targetAmount: targetAmount,
      iconName: iconName,
      colorHex: colorHex,
      isPrimary: false,
      createdAt: DateTime.now(),
    );
    await _repo.insertTabungan(newTabungan);
    await loadInitialData();
  }

  Future<void> updateTabungan(TabunganModel tabungan) async {
    await _repo.updateTabungan(tabungan);
    await loadInitialData();
  }

  Future<void> deleteTabungan(int id) async {
    if (_selectedTabunganId == id) {
      _selectedTabunganId = null;
    }
    await _repo.deleteTabungan(id);
    await loadInitialData();
  }

  Future<void> transferBetweenTabungan({
    required int fromTabunganId,
    required int toTabunganId,
    required int amount,
    String? note,
  }) async {
    if (fromTabunganId == toTabunganId || amount <= 0) return;

    final fromTabungan = _allTabungan.firstWhere((t) => t.id == fromTabunganId);
    final toTabungan = _allTabungan.firstWhere((t) => t.id == toTabunganId);
    final now = DateTime.now();

    final titleOut = (note != null && note.trim().isNotEmpty)
        ? note.trim()
        : 'Transfer ke ${toTabungan.name}';
    final titleIn = (note != null && note.trim().isNotEmpty)
        ? note.trim()
        : 'Transfer dari ${fromTabungan.name}';

    final transferOut = TransactionModel(
      title: titleOut,
      category: 'Transfer',
      type: 'EXPENSE',
      amount: amount,
      date: now,
      tabunganId: fromTabungan.id ?? 1,
      tabunganName: fromTabungan.name,
    );

    final transferIn = TransactionModel(
      title: titleIn,
      category: 'Transfer Masuk',
      type: 'INCOME',
      amount: amount,
      date: now.add(const Duration(milliseconds: 10)),
      tabunganId: toTabungan.id ?? 1,
      tabunganName: toTabungan.name,
    );

    await _repo.insertTransaction(transferOut);
    await _repo.insertTransaction(transferIn);
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

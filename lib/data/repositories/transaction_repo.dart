import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../core/database/local_db_helper.dart';
import '../models/transaction_model.dart';

class TransactionRepository {
  final LocalDbHelper _dbHelper = LocalDbHelper.instance;
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  static const String _keyStartingBudget = 'simpanan_starting_daily_budget';

  // Ambil Saldo Awal (Default: Rp0) dari penyimpanan terenkripsi
  Future<int> getStartingBudget() async {
    final value = await _secureStorage.read(key: _keyStartingBudget);
    if (value == null) {
      await setStartingBudget(0);
      return 0;
    }
    return int.tryParse(value) ?? 0;
  }

  Future<void> setStartingBudget(int amount) async {
    await _secureStorage.write(key: _keyStartingBudget, value: amount.toString());
  }

  Future<List<TransactionModel>> getAllTransactions() async {
    final db = await _dbHelper.database;
    final result = await db.query('transactions', orderBy: 'date DESC, id DESC');
    return result.map((map) => TransactionModel.fromMap(map)).toList();
  }

  Future<int> insertTransaction(TransactionModel tx) async {
    final db = await _dbHelper.database;
    return await db.insert('transactions', tx.toMap());
  }

  Future<int> deleteTransaction(int id) async {
    final db = await _dbHelper.database;
    return await db.delete('transactions', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> clearAllTransactions() async {
    await _dbHelper.clearAllTransactions();
  }
}
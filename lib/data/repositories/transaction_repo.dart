import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../core/database/local_db_helper.dart';
import '../models/tabungan_model.dart';
import '../models/transaction_model.dart';

class TransactionRepository {
  final LocalDbHelper _dbHelper = LocalDbHelper.instance;
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  static const String _keyStartingBudget = 'simpanan_starting_daily_budget';

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

  Future<List<TabunganModel>> getAllTabungan() async {
    final db = await _dbHelper.database;
    final tabunganRows = await db.query('tabungan', orderBy: 'is_primary DESC, id ASC');
    final allTxs = await getAllTransactions();

    final List<TabunganModel> list = [];
    for (final row in tabunganRows) {
      final tabunganId = row['id'] as int;
      final tabunganName = row['name'] as String;

      int balance = 0;
      for (final tx in allTxs) {
        if (tx.tabunganId == tabunganId || (tx.tabunganId == 1 && tx.tabunganName == tabunganName)) {
          if (tx.type == 'INCOME') {
            balance += tx.amount;
          } else {
            balance -= tx.amount;
          }
        }
      }

      list.add(TabunganModel.fromMap(row, currentBalance: balance));
    }

    if (list.isEmpty) {
      final defaultTabungan = TabunganModel(
        id: 1,
        name: 'Tabungan Utama',
        targetAmount: 0,
        iconName: 'savings',
        colorHex: '0xFF059669',
        isPrimary: true,
        createdAt: DateTime.now(),
        currentBalance: 0,
      );
      await insertTabungan(defaultTabungan);
      return [defaultTabungan];
    }

    return list;
  }

  Future<int> insertTabungan(TabunganModel tabungan) async {
    final db = await _dbHelper.database;
    return await db.insert('tabungan', tabungan.toMap());
  }

  Future<int> updateTabungan(TabunganModel tabungan) async {
    final db = await _dbHelper.database;
    return await db.update(
      'tabungan',
      tabungan.toMap(),
      where: 'id = ?',
      whereArgs: [tabungan.id],
    );
  }

  Future<void> deleteTabungan(int id) async {
    final db = await _dbHelper.database;
    final list = await db.query('tabungan', where: 'id = ?', whereArgs: [id]);
    if (list.isNotEmpty && (list.first['is_primary'] as int) == 1) {
      return;
    }

    await db.update(
      'transactions',
      {'tabungan_id': 1, 'tabungan_name': 'Tabungan Utama'},
      where: 'tabungan_id = ?',
      whereArgs: [id],
    );

    await db.delete('tabungan', where: 'id = ?', whereArgs: [id]);
  }
}

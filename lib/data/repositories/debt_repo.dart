import '../../core/database/local_db_helper.dart';
import '../models/debt_model.dart';

class DebtRepository {
  final LocalDbHelper _dbHelper = LocalDbHelper.instance;

  Future<List<DebtModel>> getAllDebts() async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'debts',
      orderBy: 'is_paid ASC, id DESC',
    );
    return maps.map((m) => DebtModel.fromMap(m)).toList();
  }

  Future<int> insertDebt(DebtModel debt) async {
    final db = await _dbHelper.database;
    return await db.insert('debts', debt.toMap());
  }

  Future<int> updateDebt(DebtModel debt) async {
    final db = await _dbHelper.database;
    return await db.update(
      'debts',
      debt.toMap(),
      where: 'id = ?',
      whereArgs: [debt.id],
    );
  }

  Future<void> payDebt(int id, int paymentAmount) async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'debts',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      final current = DebtModel.fromMap(maps.first);
      final newPaid = current.paidAmount + paymentAmount;
      final isPaid = newPaid >= current.amount;
      await db.update(
        'debts',
        {
          'paid_amount': newPaid,
          'is_paid': isPaid ? 1 : 0,
        },
        where: 'id = ?',
        whereArgs: [id],
      );
    }
  }

  Future<int> deleteDebt(int id) async {
    final db = await _dbHelper.database;
    return await db.delete('debts', where: 'id = ?', whereArgs: [id]);
  }
}


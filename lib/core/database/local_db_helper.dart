import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'seed_data.dart';

class LocalDbHelper {
  static final LocalDbHelper instance = LocalDbHelper._init();
  static Database? _database;

  LocalDbHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('simpanan.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 3,
      onCreate: _createDB,
      onUpgrade: _onUpgradeDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE categories (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        type TEXT NOT NULL,
        icon_name TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE tabungan (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        target_amount INTEGER NOT NULL DEFAULT 0,
        icon_name TEXT NOT NULL DEFAULT 'savings',
        color_hex TEXT NOT NULL DEFAULT '0xFF059669',
        is_primary INTEGER NOT NULL DEFAULT 0,
        created_at TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE transactions (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        category TEXT NOT NULL,
        type TEXT NOT NULL,
        amount INTEGER NOT NULL,
        date TEXT NOT NULL,
        tabungan_id INTEGER NOT NULL DEFAULT 1,
        tabungan_name TEXT NOT NULL DEFAULT 'Tabungan Utama'
      )
    ''');

    await db.execute('''
      CREATE TABLE debts (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        amount INTEGER NOT NULL,
        paid_amount INTEGER NOT NULL DEFAULT 0,
        due_date TEXT,
        created_at TEXT NOT NULL,
        note TEXT,
        is_paid INTEGER NOT NULL DEFAULT 0
      )
    ''');

    for (final cat in SeedData.defaultCategories) {
      await db.insert('categories', cat.toMap());
    }

    await db.insert('tabungan', {
      'id': 1,
      'name': 'Tabungan Utama',
      'target_amount': 0,
      'icon_name': 'savings',
      'color_hex': '0xFF059669',
      'is_primary': 1,
      'created_at': DateTime.now().toIso8601String(),
    });
  }

  Future<void> _onUpgradeDB(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute('''
        CREATE TABLE IF NOT EXISTS tabungan (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL,
          target_amount INTEGER NOT NULL DEFAULT 0,
          icon_name TEXT NOT NULL DEFAULT 'savings',
          color_hex TEXT NOT NULL DEFAULT '0xFF059669',
          is_primary INTEGER NOT NULL DEFAULT 0,
          created_at TEXT NOT NULL
        )
      ''');

      try {
        await db.execute("ALTER TABLE transactions ADD COLUMN tabungan_id INTEGER NOT NULL DEFAULT 1");
      } catch (_) {}

      try {
        await db.execute("ALTER TABLE transactions ADD COLUMN tabungan_name TEXT NOT NULL DEFAULT 'Tabungan Utama'");
      } catch (_) {}

      final count = Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM tabungan'));
      if (count == null || count == 0) {
        await db.insert('tabungan', {
          'id': 1,
          'name': 'Tabungan Utama',
          'target_amount': 0,
          'icon_name': 'savings',
          'color_hex': '0xFF059669',
          'is_primary': 1,
          'created_at': DateTime.now().toIso8601String(),
        });
      }
    }

    if (oldVersion < 3) {
      await db.execute('''
        CREATE TABLE IF NOT EXISTS debts (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT NOT NULL,
          amount INTEGER NOT NULL,
          paid_amount INTEGER NOT NULL DEFAULT 0,
          due_date TEXT,
          created_at TEXT NOT NULL,
          note TEXT,
          is_paid INTEGER NOT NULL DEFAULT 0
        )
      ''');
    }
  }

  Future<void> clearAllTransactions() async {
    final db = await database;
    await db.delete('transactions');
  }
}

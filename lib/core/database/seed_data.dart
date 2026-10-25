import '../../data/models/category_model.dart';
import '../../data/models/transaction_model.dart';

class SeedData {
  static List<CategoryModel> get defaultCategories => [
        CategoryModel(name: 'Makan & Minum', type: 'EXPENSE', iconName: 'restaurant'),
        CategoryModel(name: 'Belanja', type: 'EXPENSE', iconName: 'shopping_bag'),
        CategoryModel(name: 'Transportasi', type: 'EXPENSE', iconName: 'directions_car'),
        CategoryModel(name: 'Tagihan', type: 'EXPENSE', iconName: 'receipt_long'),
        CategoryModel(name: 'Gaji & Saldo Awal', type: 'INCOME', iconName: 'account_balance_wallet'),
        CategoryModel(name: 'Jualan', type: 'INCOME', iconName: 'storefront'),
        CategoryModel(name: 'Transfer Masuk', type: 'INCOME', iconName: 'swap_horiz'),
      ];

  static List<TransactionModel> getInitialTransactions(DateTime now) {
    return [
      TransactionModel(
        title: 'Saldo Awal & Tambahan',
        category: 'Gaji & Saldo Awal',
        type: 'INCOME',
        amount: 350000,
        date: now,
      ),
      TransactionModel(
        title: 'Belanja Kebutuhan Harian',
        category: 'Belanja',
        type: 'EXPENSE',
        amount: 188000,
        date: now,
      ),
      TransactionModel(
        title: 'Makan Siang & Transport',
        category: 'Makan & Minum',
        type: 'EXPENSE',
        amount: 100000,
        date: now,
      ),
    ];
  }
}
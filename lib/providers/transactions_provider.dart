import 'package:flutter/cupertino.dart';
import 'package:gas2s/models/transaction_model.dart';
import 'package:hive/hive.dart';

class TransactionsProvider extends ChangeNotifier {
  List<Transaction> _transactionList = <Transaction>[];

  List<Transaction> get transactionList => _transactionList;

  addItem(Transaction transaction) async {
    var box = await Hive.openBox<Transaction>('transactions');

    box.add(transaction);
    notifyListeners();
  }

  getItem() async {
    final box = await Hive.openBox<Transaction>('transactions');

    _transactionList = box.values.toList();
    notifyListeners();
  }

  updateItem(int index, Transaction transaction) {
    final box = Hive.box<Transaction>('transactions');

    box.putAt(index, transaction);
    notifyListeners();
  }

  deleteItem(int index) {
    final box = Hive.box<Transaction>('transactions');

    box.deleteAt(index);

    getItem();
    notifyListeners();
  }
}

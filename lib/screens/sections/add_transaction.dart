import 'package:flutter/material.dart';
import 'package:gas2s/models/transaction/transaction_model.dart';
import 'package:gas2s/models/user/user_model.dart';
import 'package:gas2s/theme/colors.dart';
import 'package:gas2s/widgets/ui/forms/dropdown_list.dart';
import 'package:gas2s/widgets/layout.dart';
import 'package:gas2s/widgets/ui/forms/number_field.dart';
import 'package:gas2s/widgets/ui/title_text.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

class AddTrasactionScreen extends StatefulWidget {
  const AddTrasactionScreen({Key? key}) : super(key: key);

  @override
  State<AddTrasactionScreen> createState() => _AddTrasactionScreenState();
}

class _AddTrasactionScreenState extends State<AddTrasactionScreen> {
  Box<Transaction> transactions = Hive.box<Transaction>('transactions');

  final List<String> _types = ['Expense', 'Income'];
  final List<String> _categories = [
    'Clothes',
    'Food',
    'Transportation',
    'Gadget',
    'Others',
  ];

  String _isExpense = 'Expense';
  String _category = 'Clothes';
  int _amount = 0;
  DateTime _selectedDate = DateTime.now();
  bool _isIncome = false;

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _Menu(),
            const SizedBox(height: 30),
            const AppTitle(text: 'Add Transaction'),
            const SizedBox(height: 30),
            DropdownList(
              onChanged: (String newValue) {
                setState(() {
                  if (_isExpense != newValue) {
                    _isExpense = newValue;
                    _isIncome = !_isIncome;
                  }
                });
              },
              defaultValue: _isExpense,
              items: _types,
              label: 'Types',
            ),
            NumberField(
              onChanged: (String value) {
                setState(() {
                  _amount = int.tryParse(value) ?? 0;
                });
              },
              label: 'Amount',
            ),
            const SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Date Added',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.coolGray,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: AppColors.elevation,
                        blurRadius: 5,
                        offset: Offset(2, 3),
                      )
                    ],
                  ),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.white,
                      minimumSize: const Size.fromHeight(50),
                      primary: Colors.black,
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(),
                    ),
                    onPressed: () {
                      _selectDate(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          DateFormat.yMMMMd().format(_selectedDate).toString(),
                        ),
                        const Icon(
                          Icons.calendar_month,
                          color: AppColors.coolGray,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Visibility(
              visible: !_isIncome,
              child: DropdownList(
                onChanged: (String newValue) {
                  setState(() {
                    _category = newValue;
                  });
                },
                defaultValue: _category,
                items: _categories,
                label: 'Category',
              ),
            ),
            const SizedBox(height: 10),
            _SubmitButton(
              category: _category,
              amount: _amount,
              selectedDate: _selectedDate,
              isExpense: _isExpense,
              transactions: transactions,
            ),
          ],
        ),
      ),
    );
  }

  _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2022),
      lastDate: DateTime(2050),
    );
    if (selected != null && selected != _selectedDate) {
      setState(() {
        _selectedDate = selected;
      });
    }
  }
}

class _SubmitButton extends StatelessWidget {
  const _SubmitButton({
    Key? key,
    required String category,
    required int amount,
    required DateTime selectedDate,
    required String isExpense,
    required this.transactions,
  })  : _category = category,
        _amount = amount,
        _selectedDate = selectedDate,
        _isExpense = isExpense,
        super(key: key);

  final String _category;
  final int _amount;
  final DateTime _selectedDate;
  final String _isExpense;
  final Box<Transaction> transactions;

  @override
  Widget build(BuildContext context) {
    Box<User> users = Hive.box<User>('user');
    final user = users.getAt(0);

    onSubmit() {
      final transaction = Transaction()
        ..name = _isExpense == 'Income' ? 'Income' : _category
        ..amount = _amount.toDouble()
        ..dateAdded = _selectedDate
        ..isExpense = _isExpense == 'Expense' ? true : false;

      if (_amount != 0) {
        transactions.add(transaction);

        if (_isExpense == 'Expense') {
          user?.balance -= _amount;
          user?.expenses += _amount;
        } else {
          user?.balance += _amount;
          user?.income += _amount;
        }

        user?.save();

        Navigator.pushNamed(context, '/home');
      }
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.violet,
            AppColors.pink,
          ],
        ),
      ),
      child: TextButton(
        style: TextButton.styleFrom(
          minimumSize: const Size.fromHeight(50),
          primary: Colors.white,
          textStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
          padding: const EdgeInsets.only(),
        ),
        onPressed: () => onSubmit(),
        child: const Text('Submit'),
      ),
    );
  }
}

class _Menu extends StatelessWidget {
  const _Menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.transparent,
          ),
          child: InkWell(
            onTap: () => Navigator.pop(context),
            child: const Icon(
              Icons.arrow_back,
              color: AppColors.coolDarkGray,
              size: 30.0,
            ),
          ),
        ),
      ],
    );
  }
}

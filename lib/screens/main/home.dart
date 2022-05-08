import 'package:flutter/material.dart';
import 'package:gas2s/models/transaction/transaction_model.dart';
import 'package:gas2s/models/user/user_model.dart';
import 'package:gas2s/theme/colors.dart';
import 'package:gas2s/widgets/layout.dart';
import 'package:gas2s/widgets/transactions/transactions_dateexpense.dart';
import 'package:gas2s/widgets/ui/menu.dart';
import 'package:gas2s/widgets/ui/title_text.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Box<Transaction> transactions = Hive.box<Transaction>('transactions');

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: Column(
        children: [
          // Top Menu
          const Menu(),
          // Expense/Income tracker
          const SizedBox(height: 25.0),
          const _TransactionTracker(),

          const SizedBox(height: 50.0),

          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const AppTitle(text: 'Transactions'),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => Navigator.pushNamed(context, '/transactions'),
                  child: const Text(
                    'View All',
                    style: TextStyle(
                      color: AppColors.coolGray,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 25.0),

          ValueListenableBuilder(
            valueListenable: transactions.listenable(),
            builder: (context, Box<Transaction> box, _) {
              final transactions = box.values.toList().cast<Transaction>();

              return TransactionDateExpense(
                transactionListItems: transactions,
              );
            },
          ),
        ],
      ),
    );
  }
}

class _TransactionTracker extends StatelessWidget {
  const _TransactionTracker({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Box<User> users = Hive.box<User>('user');

    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.violet,
            AppColors.pink,
          ],
        ),
        boxShadow: const [
          BoxShadow(
            color: AppColors.violet,
            offset: Offset(5, -1),
            blurRadius: 15,
          ),
          BoxShadow(
            color: AppColors.pink,
            offset: Offset(-5, 1),
            blurRadius: 15,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Total Balance',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10.0),
          Text(
            NumberFormat.simpleCurrency(locale: 'fil')
                .format(users.getAt(0)!.balance),
            style: const TextStyle(
              fontSize: 36.0,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 35.0),
          Row(
            children: [
              _IconTransaction(
                icon: Icons.attach_money_sharp,
                iconColor: AppColors.green,
                title: 'Income',
                amount: users.getAt(0)!.income.toInt(),
              ),
              const SizedBox(width: 20.0),
              _IconTransaction(
                icon: Icons.money_off_sharp,
                iconColor: AppColors.red,
                title: 'Expenses',
                amount: users.getAt(0)!.expenses.toInt(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _IconTransaction extends StatelessWidget {
  const _IconTransaction({
    Key? key,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.amount,
  }) : super(key: key);

  final IconData icon;
  final Color iconColor;
  final String title;
  final int amount;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(4.0),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          child: Icon(
            icon,
            color: iconColor,
            size: 28.0,
          ),
        ),
        const SizedBox(width: 8.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Color(0xFFECECEC),
                fontSize: 12.0,
              ),
            ),
            const SizedBox(height: 2.0),
            Text(
              '₱ ${NumberFormat.decimalPattern().format(amount)}',
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

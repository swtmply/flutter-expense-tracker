import 'package:flutter/material.dart';
import 'package:gas2s/models/transaction_model.dart';
import 'package:gas2s/theme/colors.dart';
import 'package:gas2s/widgets/layout.dart';
import 'package:gas2s/widgets/ui/title_text.dart';
import 'package:gas2s/widgets/transactions/transactions_dateexpense.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({Key? key}) : super(key: key);

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  Box<Transaction> transactions = Hive.box<Transaction>('transactions');

  final List<String> _categoryFilterItems = [
    'All',
    'Clothes',
    'Food',
    'Transportation',
    'Gadget',
    'Others',
  ];

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: Column(
        children: [
          const _Menu(),
          const SizedBox(height: 30),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppTitle(text: 'Transactions'),
              const SizedBox(height: 20),
              _CategoryList(categoryFilterItems: _categoryFilterItems),
              const SizedBox(height: 20),
            ],
          ),
          const SizedBox(height: 30),
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

class _CategoryList extends StatelessWidget {
  const _CategoryList({
    Key? key,
    required List<String> categoryFilterItems,
  })  : _categoryFilterItems = categoryFilterItems,
        super(key: key);

  final List<String> _categoryFilterItems;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 30,
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: _categoryFilterItems
            .map((category) => _CategoryFilterItem(text: category))
            .toList(),
      ),
    );
  }
}

class _CategoryFilterItem extends StatelessWidget {
  const _CategoryFilterItem({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        right: 10,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 25,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Text(text),
    );
  }
}

class _Menu extends StatelessWidget {
  const _Menu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
        InkWell(
          child: Container(
            padding: const EdgeInsets.all(4.0),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(4.0),
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  color: AppColors.elevation,
                  blurRadius: 5,
                  offset: Offset(2, 3),
                )
              ],
            ),
            child: const Icon(
              Icons.filter_list,
              color: AppColors.coolGray,
              size: 28.0,
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:gas2s/models/transaction/transaction_model.dart';
import 'package:gas2s/theme/colors.dart';
import 'package:gas2s/utils/get_color.dart';
import 'package:gas2s/widgets/layout.dart';
import 'package:gas2s/widgets/ui/title_text.dart';
import 'package:gas2s/widgets/transactions/transactions_dateexpense.dart';
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
    'Income',
    'Clothes',
    'Food',
    'Transportation',
    'Gadget',
    'Others',
  ];

  late String selectedFilter;

  @override
  void initState() {
    super.initState();
    selectedFilter = _categoryFilterItems[0];
  }

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
              _CategoryList(
                categoryFilterItems: _categoryFilterItems,
                selectedFilter: selectedFilter,
                onChanged: (String text) {
                  setState(() {
                    selectedFilter = text;
                  });
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
          const SizedBox(height: 30),
          ValueListenableBuilder(
            valueListenable: transactions.listenable(),
            builder: (context, Box<Transaction> box, _) {
              final transactions = box.values
                  .where((t) {
                    if (selectedFilter == 'All') {
                      return true;
                    } else if (t.name == selectedFilter) {
                      return true;
                    } else {
                      return false;
                    }
                  })
                  .toList()
                  .cast<Transaction>();

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
    required this.categoryFilterItems,
    required this.selectedFilter,
    required this.onChanged,
  }) : super(key: key);

  final List<String> categoryFilterItems;
  final String selectedFilter;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 40,
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: categoryFilterItems
            .map((category) => _CategoryFilterItem(
                  text: category,
                  selectedFilter: selectedFilter,
                  onChanged: onChanged,
                ))
            .toList(),
      ),
    );
  }
}

class _CategoryFilterItem extends StatelessWidget {
  const _CategoryFilterItem({
    Key? key,
    required this.text,
    required this.selectedFilter,
    required this.onChanged,
  }) : super(key: key);

  final String text;
  final String selectedFilter;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChanged(text),
      child: Container(
        margin: const EdgeInsets.only(
          right: 10,
          bottom: 10,
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 25,
        ),
        decoration: BoxDecoration(
          color: selectedFilter == text
              ? GetColor.transactionType(text)
              : Colors.transparent,
          border: Border.all(
            color: selectedFilter != text ? Colors.black : Colors.transparent,
            width: selectedFilter != text ? 1 : 0,
          ),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: selectedFilter == text ? Colors.white : Colors.black,
          ),
        ),
      ),
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

import 'package:flutter/material.dart';
import 'package:gas2s/models/transaction_model.dart';
import 'package:gas2s/theme/colors.dart';
import 'package:gas2s/widgets/transactions/transaction_list_item.dart';

class TransactionDateExpense extends StatelessWidget {
  const TransactionDateExpense(
      {Key? key, this.date, this.amount, required this.transactionListItems})
      : super(key: key);

  final String? date;
  final int? amount;
  final List<Transaction> transactionListItems;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: transactionListItems.length,
        itemBuilder: (context, index) {
          return TransactionListItem(
              transaction: transactionListItems[
                  transactionListItems.length - (index + 1)]);
        },
      ),
    );
  }
}

class DateExpense extends StatelessWidget {
  const DateExpense({
    Key? key,
    required this.date,
    required this.amount,
  }) : super(key: key);

  final String date;
  final int amount;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          date,
          style: const TextStyle(
            color: AppColors.coolGray,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          amount.toString(),
          style: const TextStyle(
            color: AppColors.coolGray,
          ),
        ),
      ],
    );
  }
}

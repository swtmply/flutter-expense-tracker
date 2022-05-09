import 'package:flutter/material.dart';
import 'package:gas2s/models/transaction/transaction_model.dart';
import 'package:gas2s/theme/colors.dart';
import 'package:gas2s/widgets/transactions/transaction_list_item.dart';
import 'package:intl/intl.dart';

class TransactionDateExpense extends StatelessWidget {
  const TransactionDateExpense(
      {Key? key, this.date, this.amount, required this.transactionListItems})
      : super(key: key);

  final String? date;
  final int? amount;
  final List<Transaction> transactionListItems;

  // ignore: todo
  // TODO work for a better algorithm

  @override
  Widget build(BuildContext context) {
    final List<Map<String, int>?> transactionDates =
        transactionListItems.reversed
            .map((transaction) {
              return DateFormat('MMM dd, yyyy')
                  .format(transaction.dateAdded)
                  .toString();
            })
            .toSet()
            .toList()
            .map((date) {
              int amount = 0;

              for (var transaction in transactionListItems) {
                if (DateFormat('MMM dd, yyyy')
                        .format(transaction.dateAdded)
                        .toString() ==
                    date) {
                  amount = transaction.isExpense
                      ? amount - transaction.amount.toInt()
                      : amount + transaction.amount.toInt();
                }
              }

              return {date: amount};
            })
            .toList();

    return Expanded(
      child: ListView.builder(
        itemCount: transactionDates.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              DateExpense(
                date: transactionDates[index]!.keys.first.toString(),
                amount: transactionDates[index]!.values.first,
              ),
              const SizedBox(
                height: 20,
              ),
              ...transactionListItems.toList().reversed.map((transaction) {
                if (DateFormat('MMM dd, yyyy')
                        .format(transaction.dateAdded)
                        .toString() ==
                    transactionDates[index]!.keys.first.toString()) {
                  return TransactionListItem(transaction: transaction);
                }

                return Container();
              }),
              const SizedBox(
                height: 20,
              ),
            ],
          );
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
          NumberFormat.simpleCurrency(locale: 'fil').format(amount),
          style: const TextStyle(
            color: AppColors.coolGray,
          ),
        ),
      ],
    );
  }
}

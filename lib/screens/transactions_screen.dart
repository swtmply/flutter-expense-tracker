import 'package:flutter/material.dart';
import 'package:gas2s/theme/colors.dart';
import 'package:gas2s/widgets/layout.dart';
import 'package:gas2s/widgets/transaction_list_item.dart';

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: Column(
        children: [
          const _Menu(),
          const SizedBox(height: 50),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'May 1, 2022',
                    style: TextStyle(
                      color: AppColors.coolGray,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    '-500.00',
                    style: TextStyle(
                      color: AppColors.coolGray,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TransactionListItem(),
              TransactionListItem(),
              TransactionListItem(),
            ],
          )
        ],
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
        Row(
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
            const SizedBox(width: 20),
            const Text(
              'Transactions',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
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

import 'package:flutter/material.dart';
import 'package:gas2s/theme/colors.dart';

class TransactionListItem extends StatelessWidget {
  const TransactionListItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(
        horizontal: 18.0,
        vertical: 9.0,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: AppColors.elevation,
            blurRadius: 5,
            offset: Offset(1, 5),
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.pink,
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                'Food',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: const [
              Text('₱ -100'),
              Text(
                'Today',
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.darkGray,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:gas2s/models/transaction_model.dart';
import 'package:gas2s/theme/colors.dart';
import 'package:hive/hive.dart';

class Menu extends StatelessWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var transactions = Hive.box<Transaction>('transactions');

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {
            transactions.clear();
          },
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
              Icons.menu,
              color: AppColors.coolGray,
              size: 28.0,
            ),
          ),
        ),
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: const [
                Text(
                  'Hello,',
                  style: TextStyle(
                    color: AppColors.coolGray,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'John Allen',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                )
              ],
            ),
            const SizedBox(
              width: 10,
            ),
            Container(
              width: 45,
              height: 45,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.pink,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.elevation,
                    blurRadius: 5,
                    offset: Offset(2, 2),
                  )
                ],
              ),
            )
          ],
        )
      ],
    );
  }
}

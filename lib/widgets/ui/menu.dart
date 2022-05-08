import 'package:flutter/material.dart';
import 'package:gas2s/models/transaction/transaction_model.dart';
import 'package:gas2s/models/user/user_model.dart';
import 'package:gas2s/theme/colors.dart';
import 'package:hive/hive.dart';

class Menu extends StatelessWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Box<User> users = Hive.box<User>('user');

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text(
                  'Hello,',
                  style: TextStyle(
                    color: AppColors.coolGray,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  users.getAt(0)!.name.toString(),
                  style: const TextStyle(
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

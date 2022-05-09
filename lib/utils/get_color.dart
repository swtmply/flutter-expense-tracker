import 'package:flutter/material.dart';
import 'package:gas2s/theme/colors.dart';

class GetColor {
  static Color transactionType(String type) {
    switch (type) {
      case 'Food':
        return AppColors.pink;
      case 'Clothes':
        return AppColors.red;
      case 'Transportation':
        return AppColors.purple;
      case 'Gadget':
        return AppColors.orange;
      case 'Income':
        return AppColors.green;
      default:
        return AppColors.violet;
    }
  }

  GetColor();
}

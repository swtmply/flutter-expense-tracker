import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gas2s/theme/colors.dart';

class AppTextField extends StatefulWidget {
  final Function onChanged;
  final String label;

  const AppTextField({
    Key? key,
    required this.onChanged,
    required this.label,
  }) : super(key: key);

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  @override
  Widget build(BuildContext context) {
    return FormField(
      builder: (FormFieldState state) {
        return InputDecorator(
          decoration: InputDecoration(
            label: Text(widget.label),
            labelStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.coolGray,
            ),
            border: InputBorder.none,
          ),
          child: Container(
            margin: const EdgeInsets.only(
              top: 10,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 5,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: AppColors.elevation,
                  blurRadius: 5,
                  offset: Offset(2, 3),
                )
              ],
            ),
            child: TextField(
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
              maxLines: 1,
              onChanged: (String value) => widget.onChanged(value),
            ),
          ),
        );
      },
    );
  }
}

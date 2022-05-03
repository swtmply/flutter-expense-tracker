import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gas2s/theme/colors.dart';

class NumberField extends StatefulWidget {
  final Function onChanged;
  final String label;

  NumberField({
    Key? key,
    required this.onChanged,
    required this.label,
  }) : super(key: key);

  @override
  State<NumberField> createState() => _NumberFieldState();
}

class _NumberFieldState extends State<NumberField> {
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
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
              ],
              keyboardType: TextInputType.number,
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

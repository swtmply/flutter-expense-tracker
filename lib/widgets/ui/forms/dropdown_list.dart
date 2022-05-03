import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:gas2s/theme/colors.dart';

class DropdownList extends StatefulWidget {
  final Function onChanged;
  final List<String> items;
  final String label;
  final String defaultValue;

  const DropdownList(
      {Key? key,
      required this.onChanged,
      required this.items,
      required this.label,
      required this.defaultValue})
      : super(key: key);

  @override
  State<DropdownList> createState() => _DropdownListState();
}

class _DropdownListState extends State<DropdownList> {
  @override
  Widget build(BuildContext context) {
    return FormField<String>(builder: (FormFieldState<String> state) {
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
          child: DropdownButtonHideUnderline(
            child: DropdownButton2(
              isExpanded: true,
              buttonPadding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 5,
              ),
              iconEnabledColor: AppColors.coolGray,
              dropdownDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    color: AppColors.elevation,
                    blurRadius: 5,
                    offset: Offset(2, 3),
                  )
                ],
                color: Colors.white,
              ),
              iconSize: 32,
              value: widget.defaultValue,
              onChanged: (newType) {
                setState(() {
                  widget.onChanged(newType);
                  state.didChange(newType as String);
                });
              },
              items: widget.items
                  .map((type) =>
                      DropdownMenuItem(value: type, child: Text(type)))
                  .toList(),
              offset: const Offset(0, -10),
            ),
          ),
        ),
      );
    });
  }
}

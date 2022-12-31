import 'package:flutter/material.dart';

class DropdownField extends StatelessWidget {
  // final controller;
  final String? selectedValue;
  final List<String>? items;
  final String hintText;
  final Function(String?)? onChanged;
  // final Object? selectedValue;

  DropdownField({
    super.key,
    required this.items,
    this.selectedValue,
    required this.hintText,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      value: selectedValue,
      items: items
          ?.map(
            (e) => DropdownMenuItem(
              value: e,
              child: Text(e),
            ),
          )
          .toList(),
      onChanged: onChanged,
      hint: Text(hintText),
    );
  }
}

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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: DropdownButtonFormField(
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
        icon: const Icon(Icons.keyboard_arrow_down_rounded),
        decoration: const InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
          fillColor: Color.fromRGBO(250, 250, 250, 1),
          filled: true,
          // hintText: hintText,
        ),
      ),
    );
  }
}

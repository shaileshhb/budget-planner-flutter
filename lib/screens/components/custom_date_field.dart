import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomDateField extends StatelessWidget {
  final controller;
  final String hintText;
  final String? Function(String?)? validator;

  const CustomDateField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.validator,
  });

  void datePicker(BuildContext context) async {
    DateTime? transactionDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime(2500));

    if (transactionDate != null) {
      print("transactionDate -> $transactionDate");
      controller.text = DateFormat('yyyy-MM-dd').format(transactionDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextFormField(
        controller: controller,
        validator: validator,
        readOnly: true,
        //set it true, so that user will not able to edit text
        onTap: () {
          datePicker(context);
        },
        decoration: InputDecoration(
          suffixIcon: const Icon(Icons.calendar_today),
          // icon: const Icon(Icons.calendar_today),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey.shade400,
            ),
          ),
          fillColor: Colors.grey.shade50,
          filled: true,
          hintText: hintText,
        ),
      ),
    );
  }
}

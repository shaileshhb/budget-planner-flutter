import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateOfBirthField extends StatelessWidget {
  final controller;
  final String hintText;

  const DateOfBirthField(
      {super.key, required this.controller, required this.hintText});

  void datePicker(BuildContext context) async {
    DateTime? dob = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1950),
        lastDate: DateTime(2100));

    if (dob != null) {
      print(dob);
      String formattedDate = DateFormat('yyyy-MM-dd').format(dob);
      print(formattedDate); //formatted date output using intl

      controller.text = formattedDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextFormField(
        controller: controller,
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

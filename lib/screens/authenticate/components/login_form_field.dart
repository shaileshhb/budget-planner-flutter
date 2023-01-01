import 'package:flutter/material.dart';

class LoginFormField extends StatefulWidget {
  final controller;
  final String hintText;
  final bool obscureText;
  final String? Function(String?)? validator;

  const LoginFormField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.validator,
  });

  @override
  State<LoginFormField> createState() => _LoginFormFieldState();
}

class _LoginFormFieldState extends State<LoginFormField> {
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextFormField(
        controller: widget.controller,
        validator: widget.validator,
        obscureText: widget.obscureText ? !isPasswordVisible : false,
        decoration: InputDecoration(
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
          suffixIcon: widget.obscureText
              ? IconButton(
                  icon: isPasswordVisible
                      ? const Icon(Icons.visibility)
                      : const Icon(Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      isPasswordVisible = !isPasswordVisible;
                    });
                  },
                )
              : null,
          fillColor: Colors.grey.shade50,
          filled: true,
          hintText: widget.hintText,
        ),
      ),
    );
  }
}

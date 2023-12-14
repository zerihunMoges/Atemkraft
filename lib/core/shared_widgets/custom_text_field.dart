import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final bool isPassword;
  final String? Function(String?)? validator;

  final TextEditingController controller;

  const CustomTextField({
    Key? key,
    required this.label,
    this.isPassword = false,
    required this.controller,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      validator: validator,
      style: Theme.of(context).textTheme.bodySmall,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
        hintText: label,
        hintStyle: Theme.of(context)
            .textTheme
            .bodySmall!
            .copyWith(color: const Color(0xFF979292)),
        border: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(10.0), // Set the border radius here
        ),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }
}

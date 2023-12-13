import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;

  const CustomTextField({
    Key? key,
    required this.label,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: Theme.of(context).textTheme.bodyMedium,
      decoration: InputDecoration(
        hintText: label,
        hintStyle: Theme.of(context)
            .textTheme
            .bodyMedium!
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

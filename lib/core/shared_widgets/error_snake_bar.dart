import 'package:flutter/material.dart';

import '../theme/colors.dart';

void showCustomMessage(BuildContext context, String message,
    {bool isError = true}) {
  final snackBar = SnackBar(
    margin: const EdgeInsets.all(20),
    content: Text(
      message,
      style: Theme.of(context).textTheme.bodySmall!.copyWith(color: white),
    ),
    backgroundColor: isError
        ? Colors.red.withOpacity(0.7)
        : Colors.green.withOpacity(0.7), // Color for error messages
    behavior: SnackBarBehavior.floating,
    dismissDirection: DismissDirection.horizontal,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

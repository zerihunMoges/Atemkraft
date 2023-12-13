import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../theme/colors.dart';

class CustomButtonTwo extends StatelessWidget {
  final VoidCallback onPressed;
  final double radius;
  final String buttonText;
  final double? width;
  final double? height;

  const CustomButtonTwo(
      {super.key,
      required this.onPressed,
      this.radius = 10,
      required this.buttonText,
      this.width,
      this.height});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
          width: width ?? 75.w,
          height: height ?? 6.h,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                  color: black.withOpacity(0.2),
                  spreadRadius: 2)
            ],
            borderRadius: BorderRadius.circular(radius),
            color: primaryLightColor,
          ),
          child: Center(
              child: Text(buttonText,
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium!
                      .copyWith(color: const Color(0xFF1E1E1E))))),
    );
  }
}

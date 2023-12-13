import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../core/theme/colors.dart';

Widget buildOnboardingItem(String imagePath, String text) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        width: 80.w,
        height: 45.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color:primaryColor.withOpacity(0.6),
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
          ),
        ),
      ),
      const SizedBox(height: 20.0),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 20.0,
            color: greyTextColor,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      
    ],
  );
}

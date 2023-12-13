import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  final double? width;
  final double? height;
  const AppLogo({super.key, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Image.asset(
        'assets/images/atemkraft_logo.png',
        width: width ?? MediaQuery.sizeOf(context).width,
        height: height,
        fit: BoxFit.contain,
      ),
    );
  }
}

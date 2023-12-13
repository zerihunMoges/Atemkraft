import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/shared_widgets/logo.dart';
import '../../../core/theme/colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              primaryColor,
              Color.fromRGBO(162, 178, 197, 1),
            ],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: -25,
              child: Transform.scale(
                scale: 1.15,
                child: SvgPicture.asset(
                  'assets/images/splash_lung.svg',
                  color: primaryColor.withOpacity(0.2),
                  width: MediaQuery.of(context)
                      .size
                      .width, // Adjust width as needed
                  // height: 100, // Adjust height as needed
                ),
              ),
            ),
            const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Logo Image in the Center
                SizedBox(height: 30),
                AppLogo()
                // Decorative SVG Image on the Top
              ],
            ),
          ],
        ),
      ),
    );
  }
}

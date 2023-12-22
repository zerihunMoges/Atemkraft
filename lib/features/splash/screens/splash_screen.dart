import 'package:atemkraft/core/routes/app_routes.dart';
import 'package:atemkraft/core/utils/firebase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../core/shared_widgets/logo.dart';
import '../../../core/theme/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _storage = const FlutterSecureStorage();
  late bool _isFirstTime;
  late GoRouter _router;

  @override
  void initState() {
    super.initState();
    _router = GoRouter.of(context);
    checkFirstTime();
  }

  void checkFirstTime() async {
    _isFirstTime = (await _storage.read(key: 'isFirstTime')) == null;

    Future.delayed(const Duration(seconds: 3), () async {
      if (FirebaseAuth.instance.currentUser != null) {
        final isAdmin = await isUserAdmin();
        if (!isAdmin) {
          _router.go(AppRoutes.home);
        } else {
          _router.go(AppRoutes.adminHome);
        }
      } else {
        _router.go(AppRoutes.login);
      }
    });
  }

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

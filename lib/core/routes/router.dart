import 'package:atemkraft/features/home/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_theme.dart';
import 'app_routes.dart';

class AppRouter extends StatelessWidget {
  late final GoRouter _router;

  AppRouter({super.key}) {
    _router = GoRouter(
      initialLocation: AppRoutes.home,
      routes: <GoRoute>[
        GoRoute(
          path: AppRoutes.home,
          builder: (context, state) => const HomeScreen(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) => MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routeInformationProvider: _router.routeInformationProvider,
      routeInformationParser: _router.routeInformationParser,
      routerDelegate: _router.routerDelegate,
      theme: appTheme);
}

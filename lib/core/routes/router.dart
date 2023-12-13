import 'package:atemkraft/features/account/presentation/screens/about_screen.dart';
import 'package:atemkraft/features/account/presentation/screens/account_information_screen.dart';
import 'package:atemkraft/features/account/presentation/screens/my_account.dart';
import 'package:atemkraft/features/account/presentation/screens/notifications.dart';
import 'package:atemkraft/features/account/presentation/screens/settings.dart';
import 'package:atemkraft/features/home/presentation/screens/home_screen.dart';
import 'package:atemkraft/features/home/presentation/screens/my_training_plan_screen.dart';
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
        GoRoute(
          path: AppRoutes.myTrainingPlan,
          builder: (context, state) => const MyTrainingPlanScreen(),
        ),
        GoRoute(
          path: AppRoutes.notifications,
          builder: (context, state) => const NotificationsScreen(),
        ),
        GoRoute(
          path: AppRoutes.myaccount,
          builder: (context, state) => const MyAccountScreen(),
        ),
        GoRoute(
          path: AppRoutes.accountInformation,
          builder: (context, state) => const AccountInformationScreen(),
        ),
        GoRoute(
          path: AppRoutes.settings,
          builder: (context, state) => const SettingScreen(),
        ),
        GoRoute(
          path: AppRoutes.aboutOwner,
          builder: (context, state) => const AboutScreen(),
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

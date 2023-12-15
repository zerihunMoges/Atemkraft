import 'package:atemkraft/features/account/presentation/screens/about_screen.dart';
import 'package:atemkraft/features/account/presentation/screens/account_information_screen.dart';
import 'package:atemkraft/features/account/presentation/screens/my_account.dart';
import 'package:atemkraft/features/account/presentation/screens/notifications.dart';
import 'package:atemkraft/features/account/presentation/screens/settings.dart';
import 'package:atemkraft/features/auth/presentation/screens/login_screen.dart';
import 'package:atemkraft/features/home/presentation/screens/home_screen.dart';
import 'package:atemkraft/features/home/presentation/screens/my_training_plan_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/admin/presentation/screens/admin_home_screen.dart';
import '../../features/admin/presentation/screens/user_plan_screen.dart';
import '../../features/auth/presentation/screens/sign_up_screen.dart';
import '../../features/onboarding/screens/onboarding_screen.dart';
import '../../features/splash/screens/splash_screen.dart';
import '../theme/app_theme.dart';
import 'app_routes.dart';

class AppRouter extends StatelessWidget {
  late final GoRouter _router;

  AppRouter({super.key}) {
    _router = GoRouter(
      initialLocation: AppRoutes.splash,
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
            routes: [
              GoRoute(
                path: AppRoutes.accountInformation,
                builder: (context, state) => const AccountInformationScreen(),
              ),
              GoRoute(
                path: AppRoutes.aboutOwner,
                builder: (context, state) => const AboutScreen(),
              ),
            ]),
        GoRoute(
          path: AppRoutes.settings,
          builder: (context, state) => const SettingScreen(),
        ),
        GoRoute(
          path: AppRoutes.splash,
          builder: (context, state) => const SplashScreen(),
        ),
        GoRoute(
          path: AppRoutes.onboarding,
          builder: (context, state) => const OnboardingScreen(),
        ),
        GoRoute(
          path: AppRoutes.login,
          builder: (context, state) => LoginScreen(),
        ),
        GoRoute(
          path: AppRoutes.signUp,
          builder: (context, state) => SignUpScreen(),
        ),
        GoRoute(
          path: AppRoutes.adminHome,
          builder: (context, state) => const AdminHomeScreen(),
        ),
        GoRoute(
          path: AppRoutes.adminUserPlan,
          builder: (context, state) {
            var extra = state.extra as Map<String, String>;
            return UserPlansScreen(
              uId: extra['uId'] ?? '',
              email: extra['email'] ?? '',
            );
          },
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

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../routes/app_routes.dart';
import '../theme/colors.dart';

class CustomBottomNavBar extends StatefulWidget {
  final int activeIndex;
  const CustomBottomNavBar({super.key, required this.activeIndex});

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: widget.activeIndex,
      onTap: (index) {
        switch (index) {
          case 0:
            context.go(AppRoutes.home);
          case 1:
            context.go(AppRoutes.myTrainingPlan);
          case 2:
            context.go(AppRoutes.myaccount);
        }
      },
      items: [
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/icons/home_icon.svg',
            colorFilter: ColorFilter.mode(
                widget.activeIndex == 0 ? primaryColor : black,
                BlendMode.srcIn),
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset('assets/icons/nav_training_icon.svg',
              colorFilter: ColorFilter.mode(
                  widget.activeIndex == 1 ? primaryColor : black,
                  BlendMode.srcIn)),
          label: 'Training',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/icons/profile_icon.svg',
            colorFilter: ColorFilter.mode(
                widget.activeIndex == 2 ? primaryColor : black,
                BlendMode.srcIn),
          ),
          label: 'Profile',
        ),
      ],
    );
  }
}

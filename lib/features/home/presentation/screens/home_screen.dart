import 'package:atemkraft/core/utils/constants.dart';
import 'package:atemkraft/features/home/presentation/widgets/bolt.dart';
import 'package:atemkraft/features/home/presentation/widgets/home_app_bar.dart';
import 'package:atemkraft/features/home/presentation/widgets/my_training_plan_card.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../core/shared_widgets/bottom_nav_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(edgeInset),
            child: Column(
              children: [
                const HomeAppBar(),
                SizedBox(
                  height: 5.h,
                ),
                const MyTrainingPlanCard(),
                SizedBox(
                  height: 5.h,
                ),
                const BOLT(),
                SizedBox(
                  height: 10.h,
                ),
              ],
            ),
          ),
          bottomNavigationBar: const CustomBottomNavBar(
            activeIndex: 0,
          )),
    );
  }
}

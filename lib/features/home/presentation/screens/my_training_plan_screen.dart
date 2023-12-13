import 'package:atemkraft/core/utils/constants.dart';
import 'package:atemkraft/features/home/presentation/widgets/common_card.dart';
import 'package:atemkraft/features/home/presentation/widgets/home_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MyTrainingPlanScreen extends StatelessWidget {
  const MyTrainingPlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
          padding: const EdgeInsets.all(edgeInset),
          child: Column(
            children: [
              const HomeAppBar(),
              SizedBox(
                height: 5.h,
              ),
              CommonCard(
                  headingTitle: 'Persönlicher Trainingsplan',
                  headingPadding: 16,
                  headingAction: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 4.w,
                    color: Colors.white, // Set the arrow color
                  )),
            ],
          )),
    ));
  }
}

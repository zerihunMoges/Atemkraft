import 'package:atemkraft/core/routes/app_routes.dart';
import 'package:atemkraft/features/home/presentation/widgets/common_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MyTrainingPlanCard extends StatelessWidget {
  const MyTrainingPlanCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(AppRoutes.myTrainingPlan);
      },
      child: CommonCard(
        headingTitle: "Mein Trainingsplan",
        headingAction: Icon(
          Icons.arrow_forward_ios_rounded,
          size: 4.w,
          color: Colors.white, // Set the arrow color
        ),
      ),
    );
  }
}

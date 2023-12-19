import 'package:atemkraft/core/routes/app_routes.dart';
import 'package:atemkraft/core/utils/images.dart';
import 'package:atemkraft/features/account/presentation/widgets/custom_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MyAccountOptions extends StatelessWidget {
  final List<List> accountOptions = [
    [
      userIcon,
      'Account Information',
      '${AppRoutes.myaccount}/${AppRoutes.accountInformation}'
    ],
    [trainingIcon, 'My Trainings', AppRoutes.myTrainingPlan],
    // [notificationIcon, 'Notifications', AppRoutes.notifications],
    [settingIcon, 'Settings', AppRoutes.settings],
    // [achievementsIcon, 'Achievements', '${AppRoutes.myaccount}/${AppRoutes.aboutOwner}'
    // ],
    // [personalHistoryIcon, 'Personal History', AppRoutes.accountInformation]
  ];

  MyAccountOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        separatorBuilder: (context, index) => SizedBox(
              height: 3.h,
            ),
        itemCount: accountOptions.length,
        itemBuilder: (context, index) {
          return CustomListTile(
            leading: SvgPicture.asset(
              accountOptions[index][0],
            ),
            title: accountOptions[index][1],
            onNextPressed: () {
              context.push(accountOptions[index][2]);
            },
          );
        });
  }
}

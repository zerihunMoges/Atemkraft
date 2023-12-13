import 'package:atemkraft/core/routes/app_routes.dart';
import 'package:atemkraft/core/utils/images.dart';
import 'package:atemkraft/features/account/presentation/widgets/custom_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AccountSettings extends StatelessWidget {
  final List<List> settings = [
    ['Edit Profile', AppRoutes.editProfile],
    ['Change Password', AppRoutes.changePassword],
    ['Delete Account', AppRoutes.deleteAccount]
  ];

  AccountSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(userIcon),
          SizedBox(
            width: 3.w,
          ),
          Text(
            'Account',
            style:
                Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 18),
          )
        ],
      ),
      SizedBox(
        height: 1.h,
      ),
      Divider(),
      SizedBox(
        height: 2.h,
      ),
      ListView.separated(
          shrinkWrap: true,
          separatorBuilder: (context, index) => SizedBox(
                height: 1.h,
              ),
          itemCount: settings.length,
          itemBuilder: (context, index) {
            return CustomListTile(
              title: settings[index][0],
              onNextPressed: () {
                context.push(settings[index][1]);
              },
            );
          }),
    ]);
  }
}

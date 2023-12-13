import 'package:atemkraft/core/shared_widgets/custom_appbar.dart';
import 'package:atemkraft/core/utils/constants.dart';
import 'package:atemkraft/core/utils/images.dart';
import 'package:atemkraft/features/account/presentation/widgets/my_account_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MyAccount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'My Account'),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(edgeInset),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          SizedBox(
            height: 5.h,
          ),
          Center(
            child: Column(
              children: [
                Text(
                  'Alexander Trishy',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Text(
                  'Trishyalex@gmail.com',
                  style: Theme.of(context).textTheme.bodySmall,
                )
              ],
            ),
          ),
          SizedBox(
            height: 7.h,
          ),
          Flexible(child: MyAccountOptions()),
          SizedBox(
            height: 7.h,
          ),
          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(logoutIcon),
                SizedBox(
                  width: 3.w,
                ),
                Text(
                  'Log-Out',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontSize: 16),
                )
              ],
            ),
          )
        ]),
      ),
    );
  }
}

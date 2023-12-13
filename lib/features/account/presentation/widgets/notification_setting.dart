import 'package:atemkraft/core/theme/colors.dart';
import 'package:atemkraft/core/utils/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class NotificationSetting extends StatefulWidget {
  const NotificationSetting({super.key});

  @override
  State<NotificationSetting> createState() => _NotificationSettingState();
}

class _NotificationSettingState extends State<NotificationSetting> {
  bool isPushNotificationOn = false;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(notificationIcon),
          SizedBox(
            width: 3.w,
          ),
          Text(
            'Notifications',
            style:
                Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 18),
          )
        ],
      ),
      SizedBox(
        height: 1.h,
      ),
      const Divider(),
      SizedBox(
        height: 1.h,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Push Notifications',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontSize: 16)),
          Transform.scale(
            scale: 0.8,
            child: Switch(
              value: isPushNotificationOn,
              onChanged: (value) {
                setState(() {
                  isPushNotificationOn = value;
                });
              },
              activeTrackColor: primaryLightColor,
              activeColor: primaryColor,
              inactiveThumbColor: Colors.grey,
              thumbColor: MaterialStateProperty.all(primaryColor),
              // Adjusts the size of the thumb
            ),
          )
        ],
      )
    ]);
  }
}

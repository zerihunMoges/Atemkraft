import 'package:atemkraft/core/shared_widgets/notification_icon.dart';
import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hello,',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            Text(
              'Alexander',
              style: Theme.of(context).textTheme.bodyMedium,
            )
          ],
        ),
        NotificationIcon()
      ],
    );
  }
}

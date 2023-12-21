import 'package:flutter/material.dart';

import '../../../../core/utils/firebase.dart';

class HomeAppBar extends StatelessWidget {
  final List<Widget>? actions;
  const HomeAppBar({super.key, this.actions = const []});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hello,',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            Text(
              getDisplayName(),
              style: Theme.of(context).textTheme.bodyMedium,
            )
          ],
        ),
        Spacer(),
        Row(
          children: actions!,
        )
        // InkWell(
        //   child: const NotificationIcon(),
        //   onTap: () => context.push(AppRoutes.notifications),
        // )
      ],
    );
  }
}

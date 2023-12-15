import 'package:flutter/material.dart';

import '../../../../core/utils/firebase.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

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
              getDisplayName(),
              style: Theme.of(context).textTheme.bodyMedium,
            )
          ],
        ),
        // InkWell(
        //   child: const NotificationIcon(),
        //   onTap: () => context.push(AppRoutes.notifications),
        // )
      ],
    );
  }
}

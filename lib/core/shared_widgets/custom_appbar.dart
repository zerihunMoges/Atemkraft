import 'package:atemkraft/core/shared_widgets/notification_icon.dart';
import 'package:atemkraft/core/theme/colors.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final void Function()? onBackPressed;
  final Color? color;

  const CustomAppBar(
      {super.key, required this.title, this.onBackPressed, this.color});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: BackButton(onPressed: onBackPressed),
      backgroundColor: color ?? Colors.transparent,
      elevation: 0,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1.0),
        child: Container(
          color: Colors.grey.withOpacity(0.6),
          height: 1.0,
        ),
      ),
      title: Text(title,
          style: Theme.of(context).textTheme.labelMedium!.copyWith(
              color: primaryColor, fontWeight: FontWeight.bold, fontSize: 20)),
      actions: [NotificationIcon()],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

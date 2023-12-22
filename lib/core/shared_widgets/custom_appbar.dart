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
      title: Text(title, style: Theme.of(context).textTheme.labelLarge),
      centerTitle: true,
      actions: const [
        // NotificationIcon(),
        // SizedBox(
        //   width: 20,
        // )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

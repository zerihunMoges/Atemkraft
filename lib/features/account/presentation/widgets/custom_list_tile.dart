import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomListTile extends StatelessWidget {
  final Widget? leading;
  final String title;
  final void Function()? onNextPressed;

  const CustomListTile(
      {super.key, required this.title, this.onNextPressed, this.leading});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onNextPressed,
      child: Row(
        children: [
          if (leading != null) leading!,
          if (leading != null)
            SizedBox(
              width: 3.w,
            ),
          Text(
            '$title',
            style:
                Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 16),
          ),
          Expanded(child: SizedBox()),
          Icon(
            Icons.arrow_forward_ios_rounded,
            size: 18,
          )
        ],
      ),
    );
  }
}

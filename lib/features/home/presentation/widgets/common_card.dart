import 'package:atemkraft/core/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CommonCard extends StatelessWidget {
  final String headingTitle;
  final TextStyle? headingTitleStyle;
  final dynamic headingAction;
  final void Function()? onHeadingActionTap;
  final bool centerHeading;
  final double? headingPadding;
  final Widget? body;
  const CommonCard(
      {super.key,
      required this.headingTitle,
      this.headingTitleStyle,
      this.headingAction,
      this.onHeadingActionTap,
      this.headingPadding,
      this.centerHeading = true,
      this.body});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
            padding:
                EdgeInsets.all(headingPadding != null ? headingPadding! : 8),
            decoration: const BoxDecoration(
              color:
                  primaryColor, // Set the primary color as the background color
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0), // Adjust the radius as needed
                topRight: Radius.circular(10.0), // Adjust the radius as needed
              ),
            ),
            // Adjust the padding as needed
            child: Row(
              mainAxisAlignment: centerHeading
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.start,
              children: [
                Text(
                  headingTitle,
                  style: headingTitleStyle ??
                      Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: white),
                ),
                SizedBox(
                  width: 5.w,
                ), // Adds flexible space to push the arrow to the right
                if (headingAction != null)
                  InkWell(
                    onTap: onHeadingActionTap,
                    child: headingAction,
                  ),
              ],
            )),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Color(0xFFD1DCE8),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10.0),
              bottomRight: Radius.circular(10.0),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [body ?? Container()],
          ),
        )
      ],
    );
  }
}

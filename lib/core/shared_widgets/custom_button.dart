import 'package:atemkraft/core/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {required this.buttonText,
      required this.borderRadius,
      this.borderOnly = false,
      this.height,
      this.oneSideOff = false,
      this.width,
      this.borderColor,
      super.key,
      this.onPressed});
  final Color? borderColor;
  final double borderRadius;
  final bool borderOnly;
  final double? height;
  final bool oneSideOff;
  final double? width;
  final String buttonText;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    final border = BorderSide(
        width: 1,
        color: borderColor ?? (borderOnly ? primaryColor : Colors.transparent));

    return InkWell(
      onTap: onPressed,
      child: Container(
        width: width ?? 30.w,
        height: height ?? 6.h,
        padding: EdgeInsets.symmetric(horizontal: (4).w),
        decoration: BoxDecoration(
          borderRadius: oneSideOff
              ? BorderRadius.only(
                  topLeft: Radius.zero,
                  topRight: Radius.circular(borderRadius),
                  bottomLeft: Radius.circular(borderRadius),
                  bottomRight: Radius.circular(borderRadius),
                )
              : BorderRadius.circular(borderRadius),
          color: borderOnly
              ? white
              : onPressed != null
                  ? primaryColor
                  : primaryColor.withOpacity(0.3),
          border: onPressed != null
              ? Border(bottom: border, top: border, left: border, right: border)
              : Border.all(
                  width: 0, color: borderOnly ? black.withOpacity(0.3) : white),
        ),
        child: Center(
          child: Text(buttonText,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: borderOnly ? black : white,
                  )),
        ),
      ),
    );
  }
}

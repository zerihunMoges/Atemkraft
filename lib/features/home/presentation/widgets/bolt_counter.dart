import 'package:atemkraft/core/utils/images.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class BOLTCounter extends StatefulWidget {
  const BOLTCounter({super.key});

  @override
  State<BOLTCounter> createState() => _BOLTCounterState();
}

class _BOLTCounterState extends State<BOLTCounter> {
  final sec = 25;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Image.asset(
                heart,
                width: 40.w,
              ),
            ),
            const Positioned(
                top: 0,
                right: 0,
                child: Icon(
                  Icons.alarm_add_rounded,
                  size: 50,
                  color: Color(0xFF01ABE3),
                ))
          ],
        ),
        SizedBox(
          height: 1.h,
        ),
        Text(
          '$sec Sek',
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(fontWeight: FontWeight.w300, fontSize: 24),
        )
      ],
    );
  }
}

import 'dart:async';

import 'package:atemkraft/core/utils/images.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../core/utils/firebase.dart';

class BOLTCounter extends StatefulWidget {
  final Function(int seconds, DateTime timestamp) onTimeRecorded;
  const BOLTCounter({super.key, required this.onTimeRecorded});

  @override
  State<BOLTCounter> createState() => _BOLTCounterState();
}

class _BOLTCounterState extends State<BOLTCounter> {
  int sec = 0;
  final Stopwatch stopwatch = Stopwatch();

  void handleAlarmClick() {
    if (stopwatch.isRunning) {
      stopwatch.stop();
      widget.onTimeRecorded(stopwatch.elapsed.inSeconds, DateTime.now());
      stopwatch.reset();
      saveBoltToTable();
    } else {
      stopwatch.start();
      Timer.periodic(const Duration(seconds: 1), (Timer t) {
        if (stopwatch.isRunning) {
          setState(() {
            sec = stopwatch.elapsed.inSeconds;
          });
        } else {
          t.cancel();
        }
      });
    }
  }

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
            Positioned(
              top: -3,
              right: -3,
              child: IconButton(
                icon: Icon(
                  Icons.alarm_add_rounded,
                  size: 50,
                  color: !stopwatch.isRunning
                      ? const Color(0xFF01ABE3)
                      : Colors.red[400],
                ),
                onPressed: handleAlarmClick,
              ),
            )
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
              .copyWith(fontWeight: FontWeight.w400, fontSize: 24),
        )
      ],
    );
  }

  saveBoltToTable() {
    addToBoltTable(sec);
  }
}

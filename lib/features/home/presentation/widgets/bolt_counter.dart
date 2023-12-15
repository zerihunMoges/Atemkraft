import 'dart:async';

import 'package:atemkraft/core/shared_widgets/error_snake_bar.dart';
import 'package:atemkraft/core/utils/firebase.dart';
import 'package:atemkraft/core/utils/images.dart';
import 'package:atemkraft/features/home/domain/entity/bolt_entity.dart';
import 'package:atemkraft/features/home/presentation/bloc/bolt_bloc.dart';
import 'package:atemkraft/features/home/presentation/bloc/bolt_bloc_events.dart';
import 'package:atemkraft/features/home/presentation/bloc/bolt_bloc_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class BOLTCounter extends StatefulWidget {
  const BOLTCounter({super.key});

  @override
  State<BOLTCounter> createState() => _BOLTCounterState();
}

class _BOLTCounterState extends State<BOLTCounter> {
  int sec = 0;
  final Stopwatch stopwatch = Stopwatch();

  void handleAlarmClick() {
    if (stopwatch.isRunning) {
      stopwatch.stop();

      stopwatch.reset();
    } else {
      stopwatch.start();
      setState(() {
        sec = stopwatch.elapsed.inSeconds;
      });
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
              padding: EdgeInsets.all(10.w),
              child: Image.asset(
                heart,
                width: 40.w,
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: BlocConsumer<BoltBloc, BoltBlocStates>(
                  builder: (context, state) {
                if (state is AddBoltLoading) {
                  return const Icon(
                    Icons.timelapse_outlined,
                    size: 50,
                    color: Color(0xFF01ABE3),
                  );
                }
                return IconButton(
                  icon: Icon(
                    Icons.alarm_add_rounded,
                    size: 50,
                    color: !stopwatch.isRunning
                        ? const Color(0xFF01ABE3)
                        : Colors.red[400],
                  ),
                  onPressed: () {
                    if (stopwatch.isRunning) {
                      BlocProvider.of<BoltBloc>(context).add(AddBoltEvent(
                        payload: BoltPayload(duration: sec),
                      ));
                    }
                    handleAlarmClick();
                  },
                );
              }, listener: (context, state) {
                if (state is AddBoltSuccess) {
                  BlocProvider.of<BoltBloc>(context)
                      .add(GetBoltsEvent(user: getUserId()));
                }
                if (state is AddBoltFailure) {
                  showCustomMessage(context, state.errorMessage);
                }
              }),
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
}

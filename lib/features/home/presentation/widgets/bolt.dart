import 'package:atemkraft/core/theme/colors.dart';
import 'package:atemkraft/features/home/presentation/widgets/bolt_counter.dart';
import 'package:atemkraft/features/home/presentation/widgets/bolt_values.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../core/shared_widgets/custom_text_field.dart';

class BOLT extends StatefulWidget {
  const BOLT({super.key});

  @override
  State<BOLT> createState() => _BOLTState();
}

class _BOLTState extends State<BOLT> {
  List<Map<String, dynamic>> dataList = [];
  TextEditingController manualInputController = TextEditingController();

  void recordTime(int seconds, DateTime timestamp) {
    setState(() => dataList.add({
          'seconds': seconds,
          'timestamp': timestamp,
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            showInsertDataDialog(context);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('BOLT Wert manuell eintragen',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 3.h),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).primaryColor,
                ),
                child: const Center(
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 1.h,
        ),
        BOLTValues(
          boltValues: dataList,
        ),
        SizedBox(
          height: 10.h,
        ),
        BOLTCounter(
          onTimeRecorded: recordTime,
        )
      ],
    );
  }

  void showInsertDataDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(25),
          title: Text('Insert BOLT manually',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelMedium),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CustomTextField(
                  controller: manualInputController,
                  label:
                      "Sekunden eintragen..."), // Assuming CustomTextField accepts a controller
              const SizedBox(height: 10), // Adjust as needed
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  TextButton(
                    onPressed: () {
                      context.pop(); // Close the dialog
                    },
                    child: Text('Cancel',
                        style: Theme.of(context).textTheme.labelMedium),
                  ),
                  TextButton(
                    onPressed: () {
                      final String value = manualInputController.text;
                      final DateTime timestamp = DateTime.now();

                      if (value != '') {
                        recordTime(int.parse(value), timestamp);
                      }

                      context.pop();
                    },
                    child: Text('Enter',
                        style: Theme.of(context).textTheme.labelMedium),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

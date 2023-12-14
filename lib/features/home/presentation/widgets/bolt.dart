import 'package:atemkraft/core/theme/colors.dart';
import 'package:atemkraft/features/home/presentation/widgets/bolt_counter.dart';
import 'package:atemkraft/features/home/presentation/widgets/bolt_values.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class BOLT extends StatefulWidget {
  const BOLT({super.key});

  @override
  State<BOLT> createState() => _BOLTState();
}

class _BOLTState extends State<BOLT> {
  List<Map<String, dynamic>> dataList = [];

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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('BOLT Wert manuell eintragen',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(fontSize: 16, fontWeight: FontWeight.bold)),
            GestureDetector(
              onTap: () async {
                final TextEditingController controller =
                    TextEditingController();
                await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      actionsPadding: EdgeInsets.zero,
                      contentPadding:
                          const EdgeInsets.only(left: 16, right: 16, top: 16),
                      titlePadding: EdgeInsets.zero,
                      content: TextField(
                        controller: controller,
                        decoration: const InputDecoration(
                            hintText: 'Sekunden eintragen...'),
                        keyboardType: TextInputType.number,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: Text(
                            'OK',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: primaryColor),
                          ),
                          onPressed: () {
                            final String value = controller.text;
                            final DateTime timestamp = DateTime.now();

                            if (value != '') {
                              recordTime(value as int, timestamp);
                            }

                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              child: Container(
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
              ),
            )
          ],
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
}

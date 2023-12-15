import 'package:atemkraft/core/theme/colors.dart';
import 'package:atemkraft/features/home/presentation/widgets/common_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BOLTValues extends StatelessWidget {
  final List<Map<String, dynamic>> boltValues;
  const BOLTValues({super.key, required this.boltValues});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CommonCard(
          headingPadding: 20,
          headingTitle: "Letzte BOLT Werten",
          headingTitleStyle: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(color: white, fontSize: 14),
          centerHeading: false,
          body: SizedBox(
            width: MediaQuery.sizeOf(context).width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: boltValues.length,
                  itemBuilder: (context, index) {
                    final seconds = boltValues[index]['seconds'];
                    final timestamp = boltValues[index]['timestamp'];

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                            height:
                                8), // Adjust as needed for space between rows

                        // Timestamp row
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'Erstellt am: ${formatDateTime(timestamp)}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(color: black),
                            ),
                            const SizedBox(width: 20),
                            Text(
                              '${seconds.toString()} SEK',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall!
                                  .copyWith(
                                    color: black,
                                  ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  String formatDateTime(DateTime dateTime) {
    String formattedDateTime = DateFormat.yMMMd().format(dateTime);
    return formattedDateTime;
  }
}

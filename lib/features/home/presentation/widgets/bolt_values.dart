import 'package:atemkraft/core/theme/colors.dart';
import 'package:atemkraft/features/home/presentation/widgets/common_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

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
            body: boltValues.length > 0
                ? Expanded(
                    child: ListView.separated(
                        shrinkWrap: true,
                        separatorBuilder: (context, index) => SizedBox(
                              height: 1.h,
                            ),
                        itemCount: boltValues.length,
                        itemBuilder: (context, index) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                  'Erstellt am: ${DateFormat('dd, MMM, yyyy', 'de_DE').format(boltValues[index]['timestamp']!)}',
                                  style: Theme.of(context).textTheme.bodySmall),
                              Text(
                                '${boltValues[index]['seconds']!} Sek',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(fontSize: 16),
                              )
                            ],
                          );
                        }),
                  )
                : Text('No Records Found',
                    style: Theme.of(context).textTheme.bodySmall))
      ],
    );
  }
}

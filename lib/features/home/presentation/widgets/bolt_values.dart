import 'package:atemkraft/core/theme/colors.dart';
import 'package:atemkraft/features/home/presentation/widgets/common_card.dart';
import 'package:flutter/material.dart';

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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                  Text("Erstellt am: 12, Sep., 2023",
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: black)),
                  Text("25 SEK",
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall!
                          .copyWith(color: black,)),
                ])
              ],
            ),
          ),
        )
      ],
    );
  }
}

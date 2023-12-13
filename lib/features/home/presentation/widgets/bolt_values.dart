import 'package:atemkraft/core/theme/colors.dart';
import 'package:atemkraft/features/home/presentation/widgets/common_card.dart';
import 'package:flutter/material.dart';

class BOLTValues extends StatelessWidget {
  const BOLTValues({super.key});

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
        )
      ],
    );
  }
}

import 'package:atemkraft/features/home/presentation/widgets/bolt_values.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class BOLT extends StatelessWidget {
  const BOLT({super.key});

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
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).primaryColor, // Set the primary color
              ),
              child: const Center(
                child: Icon(
                  Icons.add,
                  color: Colors.white, // Set the icon color to white
                ),
              ),
            )
          ],
        ),
        SizedBox(
          height: 1.h,
        ),
        const BOLTValues()
      ],
    );
  }
}

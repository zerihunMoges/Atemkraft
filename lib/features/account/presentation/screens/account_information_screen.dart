import 'package:atemkraft/core/shared_widgets/custom_appbar.dart';
import 'package:atemkraft/core/shared_widgets/custom_button.dart';
import 'package:atemkraft/core/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AccountInformationScreen extends StatelessWidget {
  const AccountInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Account Information'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(edgeInset),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            height: 5.h,
          ),
          infoRow('Name:', 'Alexander Trishy', context),
          infoRow('Date of Birth:', '25th January, 1989', context),
          infoRow('Weight:', '75.01 Kg', context),
          SizedBox(
            height: 5.h,
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                    borderOnly: true, buttonText: 'Edit', borderRadius: 10),
                Spacer(),
                CustomButton(buttonText: 'Save', borderRadius: 10),
              ],
            ),
          )
        ]),
      ),
    );
  }
}

Widget infoRow(String label, String value, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(top: 8.0, bottom: 8),
    child: Row(
      children: [
        Text(label,
            style:
                Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 16)),
        SizedBox(width: 4.w),
        Text(value,
            style:
                Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 16)),
      ],
    ),
  );
}

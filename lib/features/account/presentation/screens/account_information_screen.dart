import 'package:atemkraft/core/shared_widgets/custom_appbar.dart';
import 'package:atemkraft/core/shared_widgets/custom_button.dart';
import 'package:atemkraft/core/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AccountInformationScreen extends StatelessWidget {
  const AccountInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Account Information'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(36),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          infoRow('Name', 'Alexander Trishy', context),
          infoRow('Date of Birth', '25th January, 1989', context),
          infoRow('Weight', '75.01 Kg', context),
          infoRow('Size', '7 ft Tall', context),
          infoRow('Phone Number', '+220-8473-3933', context),
          infoRow('Email Address', 'Trishyalex@gmail.com', context),
          SizedBox(
            height: 5.h,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                    borderOnly: true,
                    buttonText: 'Edit',
                    width: 35.w,
                    borderColor: primaryColor),
                const Spacer(),
                CustomButton(buttonText: 'Save', width: 35.w, onPressed: () {}),
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
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style:
                Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 16)),
        Text(value,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(fontSize: 16, color: Colors.black.withOpacity(0.5))),
      ],
    ),
  );
}

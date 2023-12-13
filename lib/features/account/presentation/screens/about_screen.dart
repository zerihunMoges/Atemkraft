import 'package:atemkraft/core/shared_widgets/custom_appbar.dart';
import 'package:atemkraft/core/theme/colors.dart';
import 'package:atemkraft/core/utils/constants.dart';
import 'package:atemkraft/core/utils/images.dart';
import 'package:atemkraft/features/account/presentation/widgets/owner_biography.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'About'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(edgeInset),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Image.asset(owner)),
            SizedBox(
              height: 3.h,
            ),
            Text(
              'Name:',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: primaryColor),
            ),
            SizedBox(
              height: 1.h,
            ),
            Text(
              'Melanie Yildiz',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            SizedBox(
              height: 2.h,
            ),
            Text(
              'Biographie:',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: primaryColor),
            ),
            SizedBox(
              height: 1.h,
            ),
            OwnerBiography()
          ],
        ),
      ),
    );
  }
}

import 'package:atemkraft/core/shared_widgets/custom_appbar.dart';
import 'package:atemkraft/core/utils/constants.dart';
import 'package:atemkraft/features/account/presentation/widgets/account_settings.dart';
import 'package:atemkraft/features/account/presentation/widgets/notification_setting.dart';
import 'package:atemkraft/features/account/presentation/widgets/other_settings.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Settings'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(edgeInset),
        child: Column(
          children: [
            AccountSettings(),
            SizedBox(height: 5.h),
            const NotificationSetting(),
            SizedBox(height: 5.h),
            OtherSettings()
          ],
        ),
      ),
    );
  }
}

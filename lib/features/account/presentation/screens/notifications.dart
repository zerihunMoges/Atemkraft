import 'package:atemkraft/core/shared_widgets/custom_appbar.dart';
import 'package:atemkraft/core/utils/constants.dart';
import 'package:atemkraft/features/account/presentation/widgets/notifcation_card.dart';
import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Notification'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(edgeInset),
        child: Column(
          children: [
            NotificationCard(
                picture:
                    'https://glider.ai/wp-content/uploads/call-center-supervisor-scaled.jpg',
                message:
                    'Hi, Michelle is requesting fro a customized workout plans she has submitted all the needed informations',
                time: DateTime.now(),
                title: 'Michelle Barak')
          ],
        ),
      ),
    );
  }
}

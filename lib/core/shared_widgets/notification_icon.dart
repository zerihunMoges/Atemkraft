import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NotificationIcon extends StatelessWidget {
  const NotificationIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Icon(Icons.notifications_none_rounded),
        Positioned(
          right: 0,
          top: 0,
          child: Container(
            padding: EdgeInsets.all(1),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(3),
            ),
            constraints: BoxConstraints(
              minWidth: 6,
              minHeight: 6,
            ),
          ),
        ),
      ],
    );
  }
}

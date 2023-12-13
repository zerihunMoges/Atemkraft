import 'package:flutter/material.dart';

class OrDivider extends StatelessWidget {
  final double thickness;
  final Color color;
  final TextStyle textStyle;

  const OrDivider({
    Key? key,
    this.thickness = 1.0,
    this.color = Colors.black,
    this.textStyle = const TextStyle(fontSize: 14.0, color: Colors.black),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Divider(
            color: color,
            thickness: thickness,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            'or',
            style: textStyle,
          ),
        ),
        Expanded(
          child: Divider(
            color: color,
            thickness: thickness,
          ),
        ),
      ],
    );
  }
}

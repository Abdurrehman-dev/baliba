import 'package:flutter/material.dart';

class CustomRowBar extends StatelessWidget {
  CustomRowBar(
      {Key key,
      this.mainAxisDirection,
      this.padding,
      this.text,
      this.color,
      this.fontSize});
  final padding;
  final mainAxisDirection;
  final text;
  final fontSize;
  final color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisDirection,
      children: <Widget>[
        Padding(
          padding: padding,
          child: Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: fontSize,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}

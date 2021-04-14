import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  CustomContainer({this.height, this.radius, this.color});
  double height;
  Color color;
  double radius;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(radius),
        ),
      ),
    );
  }
}

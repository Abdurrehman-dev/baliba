import 'package:flutter/material.dart';

class CartButtons extends StatelessWidget {
  CartButtons({this.onPressed, this.icon});
  final icon;
  Function onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: onPressed,
        child: Container(
          height: 28.0,
          width: 28.0,
          // padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: [BoxShadow(blurRadius: 2.0, color: Colors.grey)]),
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: Center(child: icon),
          ),
        ),
      ),
    );
  }
}

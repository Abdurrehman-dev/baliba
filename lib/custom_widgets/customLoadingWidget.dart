import 'package:ecommerceapp/ColorsForGrocon/colorsForGrocon.dart';
import 'package:flutter/material.dart';

class CustomLoading extends StatefulWidget {
  @override
  _CustomLoadingState createState() => _CustomLoadingState();
}

class _CustomLoadingState extends State<CustomLoading>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  double value = 0.0;
  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );
    super.initState();
    animationController.repeat(reverse: true);
    animationController.addListener(() {
      setState(() {
        value = animationController.value;
      });
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(90, 0.0, 90.0, 0.0),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Opacity(
              opacity: 1.0, child: Image.asset("assets/loadingLogo.png")),
        ),
      ),
    );
  }
}

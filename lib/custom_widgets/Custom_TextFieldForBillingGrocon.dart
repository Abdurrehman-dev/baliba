import 'package:flutter/material.dart';

Widget CustomTextFieldForBilling({
  @required Icon icon,
  @required TextEditingController controller,
  @required String hintText,
}) {
  return Column(
    children: [
      Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: controller,
            cursorColor: Colors.black,
            decoration: InputDecoration(
                hintText: hintText,
                prefixIcon: icon,
                fillColor: Colors.grey,
                border: InputBorder.none),
          ),
        ),
      ),
      Divider(thickness: 1.5, indent: 15.0, endIndent: 15.0, height: 0.0),
    ],
  );
}

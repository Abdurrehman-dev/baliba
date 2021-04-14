import 'package:flutter/material.dart';

Widget TextFieldForRegister({
  @required final hintText,
  @required final prefixIcon,
  @required TextEditingController controller,
  bool obSecure = false,
  String validator,
}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      height: 74.0,
      width: 280.0,
      child: TextFormField(
        validator: (val) {
          if (val.isEmpty) {
            return validator;
          }
        },
        controller: controller,
        obscureText: obSecure,
        cursorColor: Colors.black,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: prefixIcon,
          border: OutlineInputBorder(
              borderSide: BorderSide(),
              borderRadius: BorderRadius.circular(10.0)),
        ),
      ),
    ),
  );
}

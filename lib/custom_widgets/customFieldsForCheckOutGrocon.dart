import 'package:flutter/material.dart';

Widget CustomFieldsForCheckOut({
  @required String title,
  Icon icon,
  Function onpressed,
}) {
  return Padding(
    padding: const EdgeInsets.all(15.0),
    child: Container(
      height: 60.0,
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(blurRadius: 1.0, color: Colors.grey)],
          borderRadius: BorderRadius.circular(12.0)),
      child: Row(
        children: <Widget>[
          Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              )),
          Expanded(
            flex: 1,
            child: icon == null
                ? Container()
                : IconButton(icon: icon, onPressed: onpressed),
          )
        ],
      ),
    ),
  );
}

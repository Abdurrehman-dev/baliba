import 'package:flutter/material.dart';

class CustomeCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: 180.0,
          width: 320.0,
          child: Card(),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(186.0, 46.0, 0.0, 0.0),
          child: Container(
            height: 130.0,
            width: 130.0,
            decoration: BoxDecoration(
                color: Colors.orange[100],
                borderRadius:
                    BorderRadius.only(topLeft: Radius.circular(200.0))),
          ),
        ),
      ],
    );
  }
}

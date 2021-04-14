import 'package:ecommerceapp/ColorsForGrocon/colorsForGrocon.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class ProductPageCardGrocon extends StatelessWidget {
  ProductPageCardGrocon(
      {@required this.price, @required this.imagePath, @required this.title});
  List imagePath;
  final price;
  final title;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 70.0),
          child: Container(
            height: 260.0,
            width: 300.0,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    blurRadius: 10.0, spreadRadius: 0.0, color: Colors.grey)
              ],
              borderRadius: BorderRadius.circular(50.0),
              color: Colors.white,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(30.0, 20.0, 0.0, 0.0),
          child: Container(
            child: Center(
                child: Padding(
                    padding: EdgeInsets.all(4.0),
                    child: imagePath.isEmpty
                        ? Image.asset("assets/empty.png")
                        : Image.network(imagePath[0]["src"], height: 140.0))),
            height: 200.0,
            width: 240.0,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    blurRadius: 3.0, spreadRadius: 0.0, color: Colors.grey)
              ],
              borderRadius: BorderRadius.circular(40.0),
              color: Colors.white,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(20.0, 260.0, 0.0, 0.0),
          child: Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(190.0, 250.0, 0.0, 0.0),
          child: FlatButton(
            onPressed: () {
              print("clicked");
            },
            child: Text("Rs" + price + ".0"),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: BorderSide(
                    width: 2.0,
                    color: productButtonColor,
                    style: BorderStyle.solid)),
          ),
        ),
      ],
    );
  }
}

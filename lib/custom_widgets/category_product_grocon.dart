import 'package:flutter/material.dart';
import 'package:ecommerceapp/ColorsForGrocon/colorsForGrocon.dart';

class CategoryProductForGrocon extends StatelessWidget {
  CategoryProductForGrocon({this.imagepath, this.title, this.price});
  final imagepath;
  final title;
  final price;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Container(
            height: 120.0,
            width: 150.0,
            color: productBackgroundColor,
            child: Center(child: Image.asset(imagepath)),
          ),
          Container(
            height: 111.8,
            width: 150.0,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(title, style: TextStyle(fontSize: 12.0)),
                ),
                Text("Rs " + price,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: productPriceColor)),
                Padding(
                  padding: const EdgeInsets.only(top: 15.8),
                  child: FlatButton(
                    padding: EdgeInsets.fromLTRB(38.0, 0.0, 38.0, 0.0),
                    onPressed: () {},
                    child: Text(
                      "Add To Cart",
                      style: TextStyle(color: Colors.white),
                    ),
                    color: productButtonColor,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

import 'package:ecommerceapp/ColorsForGrocon/colorsForGrocon.dart';
import 'package:ecommerceapp/Dart_lists/provider_cartList.dart';
import 'package:flutter/material.dart';

class ProductCardForGrocon extends StatelessWidget {
  ProductCardForGrocon(
      {this.imagePath,
      this.title,
      this.price,
      this.onPressed,
      this.old_price,
      this.id});
  final id;
  final List imagePath;
  final title;
  final price;
  final old_price;
  Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: productBackgroundColor,
            boxShadow: [
              BoxShadow(spreadRadius: 0.0, blurRadius: 5.0, color: Colors.grey)
            ]),
        height: 0.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Container(
                height: 80.0,
                child: imagePath.isEmpty
                    ? Image.asset("assets/empty.png")
                    : Image.network(imagePath[0]["src"]),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                  child: Text(
                    title,
                    style: TextStyle(fontSize: 14.0),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                  child: Text("id: " + "$id"),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                  child: Text(
                    "Rs" + price + ".0",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17.0,
                        color: productPriceColor),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: FlatButton(
                        minWidth: 1.0,
                        onPressed: () {},
                        child: Image.asset(
                          "icons/heart.png",
                          height: 25.0,
                        ),
                      ),
                    ),
                    Expanded(
                      child: FlatButton(
                        minWidth: 1.0,
                        onPressed: onPressed,
                        child: Icon(Icons.add_shopping_cart, color: iconColor),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

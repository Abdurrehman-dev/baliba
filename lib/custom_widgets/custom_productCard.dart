import 'package:flutter/material.dart';

class CustomProductCard extends StatelessWidget {
  CustomProductCard(
      {Key key,
      this.imagePath,
      this.title,
      this.price,
      this.old_price,
      this.onTap});
  final imagePath;
  final title;
  final price;
  final old_price;
  Function onTap;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: 250.0,
          width: 180.0,
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(35.0))),
            child: Column(
              children: [
                Container(
                  height: 130.0,
                  child: Image.asset(imagePath),
                ),
                Divider(thickness: 2.0, color: Colors.orange),
                Text(
                  title,
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 20.0, 80.0, 0.0),
                  child: Text(price + " Rs",
                      style: TextStyle(
                          color: Colors.orange,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0)),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 80.0),
                  child: Text(old_price + " Rs",
                      style: TextStyle(decoration: TextDecoration.lineThrough)),
                ),
              ],
            ),
            elevation: 4.8,
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(126.0, 195.0, 0.0, 0.0),
          child: InkWell(
            onTap: onTap,
            child: Container(
                child: Icon(
                  Icons.add,
                  color: Colors.orange,
                ),
                height: 40.0,
                width: 40.0,
                decoration: BoxDecoration(
                    color: Colors.orange[100],
                    borderRadius: BorderRadius.circular(100.0))),
          ),
        ),
      ],
    );
  }
}

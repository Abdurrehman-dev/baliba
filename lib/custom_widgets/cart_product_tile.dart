import 'package:ecommerceapp/ColorsForGrocon/colorsForGrocon.dart';
import 'package:ecommerceapp/Screen_3/main_screen_3.dart';
import 'package:flutter/material.dart';
import 'package:ecommerceapp/custom_widgets/cart_buttons_for_Grocon.dart';

class CartTile extends StatefulWidget {
  final List imagepath;
  final String title;
  int price;
  int total;
  int quantity;
//  Function delete1;
  Function delete2;
  Function plusButton;
  Function minusButton;
  bool pay;
  CartTile(
      {@required this.imagepath,
      @required this.title,
      @required this.price,
//      @required this.delete1,
      @required this.delete2,
      @required this.plusButton,
      @required this.minusButton,
      this.quantity,
      this.pay});
  @override
  _CartTileState createState() => _CartTileState();
}

class _CartTileState extends State<CartTile> {
  int _count = 1;
  int total = 1;

  @override
  void initState() {
    total = widget.price;
    widget.total = widget.price;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 140.0,
          color: productBackgroundColor,
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: widget.imagepath.isEmpty
                        ? Image.asset("assets/empty.png")
                        : Image.network(widget.imagepath[0]["src"]),
                  ),
                  height: 90.0,
                  width: 90.0,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 2.0,
                            spreadRadius: 0.0,
                            color: Colors.grey)
                      ]),
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(28.0, 30.0, 0.0, 0.0),
                    child: Container(
                      width: 110.0,
                      child: Text(
                        widget.title.toUpperCase(),
                        style: TextStyle(fontSize: 14.0),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 34.0),
                    child: Text(
                      "Rs" + widget.price.toString() + ".0",
                      style: TextStyle(
                          color: productPriceColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    //TODO:button for fav
                    //button for fav
                    CartButtons(
                      onPressed: () {},
                      icon: Image.asset("icons/heart.png", height: 20.0),
                    ),
                    //button for delete if product quantity is greater than 1
//                  widget.quantity == 1
//                      ? Container(height: 46.0)
//                      : CartButtons(
//                          onPressed: widget.delete1,
//                          icon: Image.asset("icons/delete.png"),
//                        ),
                    SizedBox(height: 30.0),
                    Row(
                      children: <Widget>[
                        //button for delete if product quantity is 1
                        widget.quantity == 1
                            ? CartButtons(
                                onPressed: widget.delete2,
                                icon: Image.asset("icons/delete.png",
                                    height: 20.0),
                              )
                            : CartButtons(
                                onPressed: widget.minusButton,
//                                  () {
//                                setState(() {
//                                  _count--;
//                                });
//                                setState(() {
//                                  widget.total = 0;
//                                  widget.total = widget.price * _count;
//                                });
//                              },
                                icon: Icon(Icons.remove),
                              ),
                        Text(
                          widget.quantity.toString(),
                          style: TextStyle(
                              fontSize: 15.0, fontWeight: FontWeight.bold),
                        ),
                        //button for adding products
                        CartButtons(
                          onPressed: widget.plusButton,
//                          () {
//                          setState(() {
//                            _count++;
//                          });
//                          setState(() {
//                            widget.total = 0;
//                            widget.total = widget.price * _count;
//                          });
//                        },
                          icon: Icon(Icons.add),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Divider(
          height: 0.0,
          thickness: 0.7,
          indent: 12.0,
          endIndent: 12.0,
          color: Colors.black,
        ),
      ],
    );
  }
}

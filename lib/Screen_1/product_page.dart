import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:ecommerceapp/Screen_1/cart_page.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:ecommerceapp/Dart_lists/cart_list.dart';
import 'check_out_page_for_buy_now.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProductPage extends StatefulWidget {
  ProductPage({
    @required this.image,
    @required this.name,
    @required this.price,
    @required this.old_price,
    @required this.description,
  });
  final image;
  final name;
  final price;
  final old_price;
  final description;

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  //creating object of cart_list
  CartList cart = CartList();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.search, color: Colors.orange),
                onPressed: () {}),
            IconButton(
                icon: Icon(Icons.shopping_cart, color: Colors.orange),
                onPressed: () {
                  print(CartList.cartlist);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => CartPage()));
                  print(CartList.cartlist);
                })
          ],
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_outlined,
              color: Colors.orange,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: Container(
                height: 200.0,
                width: MediaQuery.of(context).size.width,
                // child: image[0],
                child: Carousel(
                  autoplay: false,
                  indicatorBgPadding: 3.0,
                  dotSize: 5.0,
                  dotBgColor: Colors.transparent,
                  dotColor: Colors.orange,
                  images: [
                    Image.asset(widget.image[0]),
                    Image.asset(widget.image[1]),
                  ],
                ),
              ),
            ),
            Divider(
              height: 20.0,
              thickness: 5.0,
            ),
            Expanded(
              flex: 0,
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(
                        widget.name,
                        style: TextStyle(
                            fontSize: 28.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        Text(
                          "Price " + widget.price + " Rs",
                          style: TextStyle(
                              color: Colors.orange,
                              fontWeight: FontWeight.bold,
                              fontSize: 17.0),
                        ),
                        Text(
                          "Old_Price " + widget.old_price + " Rs",
                          style: TextStyle(
                              decoration: TextDecoration.lineThrough,
                              fontSize: 10.0),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Divider(
              thickness: 5.0,
            ),
            Expanded(
              flex: 3,
              child: Container(
                child: ListView(children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Description :",
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      Divider(color: Colors.transparent),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          widget.description,
                          style: TextStyle(fontSize: 15.0),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ],
                  ),
                ]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: FlatButton(
                      textColor: Colors.orange,
                      height: 50.0,
                      color: Colors.transparent,
                      onPressed: () {
                        Fluttertoast.showToast(
                            msg: "Added to cart",
                            textColor: Colors.white,
                            backgroundColor: Colors.orange,
                            gravity: ToastGravity.CENTER);
                        //divider
                        print(CartList.cartlist);
                        CartList.cartlist.add({
                          "name": widget.name,
                          "image": widget.image[0],
                          "price": widget.price,
                          "old_price": widget.old_price,
                        });
                        setState(() {
                          print(CartList.cartlist);
                        });
                      },
                      child: Row(
                        children: [
                          Text("Add To Cart "),
                          Icon(Icons.card_travel, color: Colors.orange)
                        ],
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                    ),
                  ),
                  Expanded(
                      child: FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          textColor: Colors.white,
                          height: 50.0,
                          color: Colors.orange,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        //sending product_page data to buyNowCheckOut page
                                        BuyNowCheckOut(
                                          name: widget.name,
                                          price: widget.price,
                                          description: widget.description,
                                          imagePath: widget.image,
                                        )));
                          },
                          child: Text("Buy Now"))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:ecommerceapp/ColorsForGrocon/colorsForGrocon.dart';
import 'package:ecommerceapp/Dart_lists/cart_list.dart';
import 'package:ecommerceapp/Dart_lists/products.dart';
import 'package:ecommerceapp/Dart_lists/provider_cartList.dart';
import 'package:ecommerceapp/Screen_3/main_screen_3.dart';
import 'package:ecommerceapp/models/product_model_attributes.dart';
import 'package:flutter/material.dart';
import 'package:ecommerceapp/custom_widgets/product_page_card_grocon.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'cart_page_for_grocon.dart';

int _currentIndex = 0;

class ProductPageGrocon extends StatefulWidget {
  static int cartValue = 0;
//  ProductPageGrocon(
  // {this.imagepath, this.price, this.title, this.old_price, this.cartVal});
  ProductAttributes productAttributes;
  int cartVal;
  ProductPageGrocon({this.productAttributes, this.cartVal});

  @override
  _ProductPageGroconState createState() => _ProductPageGroconState();
}

class _ProductPageGroconState extends State<ProductPageGrocon> {
  Products productlist = Products();
  int _count = 1;
  int mytotal = 0;
  var result;
  var ids;
  CartForGrocon cartForGrocon = CartForGrocon();
  bool found = false;
  @override
  void initState() {
    print(CartList.cartlist.length);
    ProductPageGrocon.cartValue = CartList.cartlist.length;
    mytotal = int.parse(widget.productAttributes.price);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        setState(() {
          Navigator.pop(context, CartList.cartlist.length);
        });
        return;
      },
      child: Scaffold(
        backgroundColor: scaffoldBackgroundColor,
        appBar: AppBar(
          toolbarHeight: 75.0,
          backgroundColor: appBarColor,
          title: Text(
            "Product",
            style:
                TextStyle(color: appBarTextColor, fontWeight: FontWeight.bold),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.chevron_left,
              color: Colors.black,
              size: 45.0,
            ),
            onPressed: () {
              setState(
                () {
                  Navigator.pop(context, CartList.cartlist.length);
                },
              );
            },
          ),
          actions: [
            Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(23.0, 15.0, 0.0, 0.0),
                child: Stack(
                  children: [
                    IconButton(
                        icon: Icon(
                          Icons.shopping_cart_outlined,
                          color: iconColor,
                        ),
                        onPressed: () async {
                          result = await Navigator.push(
                              context,
                              PageRouteBuilder(
                                  transitionDuration:
                                      Duration(milliseconds: 700),
                                  transitionsBuilder: (BuildContext context,
                                      Animation<double> animation,
                                      Animation<double> secanimation,
                                      Widget child) {
                                    animation = CurvedAnimation(
                                        parent: animation,
                                        curve: Curves.fastOutSlowIn);
                                    return ScaleTransition(
                                      scale: animation,
                                      alignment: Alignment.topRight,
                                      child: child,
                                    );
                                  },
                                  pageBuilder: (BuildContext context,
                                          Animation<double> animation,
                                          Animation<double> secanimation) =>
                                      CartForGrocon()));
                          setState(() {
                            ProductPageGrocon.cartValue = result;
                          });
                        }),
                    CartList.cartlist.length == 0
                        ? Container()
                        : Padding(
                            padding:
                                const EdgeInsets.fromLTRB(25.0, 6.0, 0.0, 0.0),
                            child: Container(
                              height: 15.0,
                              width: 15.0,
                              decoration: BoxDecoration(
                                  color: buttonColor,
                                  borderRadius: BorderRadius.circular(50.0)),
                              child: Center(
                                child: Text(
                                    "${ProductPageGrocon.cartValue.toString()}"),
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ProductPageCardGrocon(
                imagePath: widget.productAttributes.images,
                price: widget.productAttributes.price,
                title: widget.productAttributes.name),
            Divider(
              thickness: 0.0,
              color: Colors.grey[300],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(40.0, 10.0, 0.0, 0.0),
                  child: Text(
                    "Other Products",
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
        bottomSheet: Container(
          height: 200.0,
          decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(30.0)),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.fromLTRB(65.0, 5.0, 65.0, 0.0),
                    child: MaterialButton(
                        color: Colors.white,
                        elevation: 5.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        onPressed: () {
                          setState(() {
                            if (_count == 1) {
                              _count + 1;
                            } else {
                              _count--;
                              mytotal = _count *
                                  int.parse(widget.productAttributes.price);
                            }
                          });
                        },
                        child: Text(
                          "-",
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold),
                        )),
                  )),
                  Expanded(
                    flex: 0,
                    child: Text(
                      _count.toString(),
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.fromLTRB(65.0, 5.0, 65.0, 0.0),
                    child: MaterialButton(
                        color: Colors.white,
                        elevation: 5.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        onPressed: () {
                          setState(() {
                            _count++;
                            mytotal = _count *
                                int.parse(widget.productAttributes.price);
                          });
                        },
                        child: Text(
                          "+",
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold),
                        )),
                  )),
                ],
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: Text(
                    "Total: " + mytotal.toString(),
                    style: TextStyle(
                        color: productPriceColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: MaterialButton(
                  padding: EdgeInsets.fromLTRB(100.0, 0.0, 100.0, 0.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  onPressed: () {
                    if (CartList.cartlist.isEmpty) {
                      found = true;
                      CartList.cartlist.add({
                        "id": widget.productAttributes.id,
                        "title": widget.productAttributes.name,
                        "imagePath": widget.productAttributes.images,
                        "price": int.parse(widget.productAttributes.price),
                        "old_price": widget.productAttributes.sale_price,
                        "quantity": 1
                      });
                      setState(() {
                        ProductPageGrocon.cartValue = CartList.cartlist.length;
//                            MainScreen.val = CartList.cartlist.length;
                      });
                      ids = widget.productAttributes.id;
                      print("");
                      setState(() {
                        MainScreen3.cartTotal +=
                            int.parse(widget.productAttributes.price);
                      });
                      cartForGrocon.sharedPrefsetIds();
                    } else if (CartList.cartlist.isNotEmpty) {
                      found = false;
                      found = false;
                      int id = widget.productAttributes.id;
                      print(CartList.cartlist.length);
                      for (int i = 0; i < CartList.cartlist.length; i++) {
                        print(found);
                        print(CartList.cartlist[i]["id"]);
                        if (CartList.cartlist[i]["id"] == id) {
                          found = true;
                          print("Already Exists");
                          Fluttertoast.showToast(
                              msg: "Already Exists",
                              gravity: ToastGravity.CENTER);
                        }
                      }
                    }
                    if (!found) {
                      CartList.cartlist.add({
                        "id": widget.productAttributes.id,
                        "title": widget.productAttributes.name,
                        "imagePath": widget.productAttributes.images,
                        "price": int.parse(widget.productAttributes.price),
                        "old_price": widget.productAttributes.regular_price,
                        "quantity": 1
                      });
                      setState(() {
                        ProductPageGrocon.cartValue = CartList.cartlist.length;
//                              MainScreen.val = cartUpdate;
                        MainScreen3.cartTotal +=
                            int.parse(widget.productAttributes.price);
                        print(
                            "Total in cart" + MainScreen3.cartTotal.toString());
                      });
                      print(MainScreen3().cartUpdate);
                      cartForGrocon.sharedPrefsetIds();
                      setState(() {});
                    }
                  },
                  child: Text("Add To Cart",
                      style: TextStyle(color: Colors.white)),
                  color: productButtonColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

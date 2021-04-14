import 'package:ecommerceapp/ColorsForGrocon/colorsForGrocon.dart';
import 'package:ecommerceapp/Screen_3/LoginPageForGrocon.dart';
import 'package:ecommerceapp/Screen_3/register_for_grocon.dart';
import 'package:ecommerceapp/main.dart';
import 'package:ecommerceapp/models/line_items.dart';
import 'package:ecommerceapp/services/shipping_service.dart';
import 'package:ecommerceapp/sharedPreferencesFile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//my imports.
import 'package:ecommerceapp/Dart_lists/products.dart';
import 'package:ecommerceapp/Screen_3/check_out_page.dart';
import 'package:ecommerceapp/Screen_3/main_screen_3.dart';
import 'package:ecommerceapp/custom_widgets/cart_product_tile.dart';
import 'package:ecommerceapp/Dart_lists/cart_list.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartForGrocon extends StatefulWidget {
  List listofProducts;
  List secCartlist = [];
  List count = [];
  List myQuantity = [];
  List<int> myPrice = [];
  static List quantity = [];
  static var total = 0;
  static bool someWidgets = false;
  CartForGrocon({this.listofProducts});

  static setUserExistenceSharedPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.getString("userEmail");
  }

  List<String> cartIDs = [];
  sharedPrefgetIds({List totalProducts}) async {
    cartIDs = [];
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    cartIDs = sharedPreferences.getStringList("cartids");
    for (int j = 0; j < cartIDs.length; j++) {
      var id = cartIDs[j];
      for (int i = 0; i < totalProducts.length; i++) {
        var productId = totalProducts[i]["id"].toString();
        if (productId == id) {
          //TODO: change price
          totalProducts[i]["price"] = "100";
          secCartlist.add({
            "id": totalProducts[i]["id"],
            "title": totalProducts[i]["name"],
            "imagePath": totalProducts[i]["images"],
            "price": int.parse(totalProducts[i]["price"]),
            "old_price": totalProducts[i]["regular_price"],
            "quantity": 1
          });
        }
      }
    }
    CartList.cartlist = [];
    CartList.cartlist = secCartlist;
    secCartlist = [];
  }

  sharedPrefsetIds() async {
    cartIDs = [];
    for (int i = 0; i < CartList.cartlist.length; i++) {
      cartIDs.add(CartList.cartlist[i]["id"].toString());
    }
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setStringList("cartids", cartIDs);
    cartIDs = [];
    sharedPreferences.setInt("length", CartList.cartlist.length);
  }

  @override
  _CartForGroconState createState() => _CartForGroconState();
}

class _CartForGroconState extends State<CartForGrocon> {
  MainScreen mainScreen = MainScreen();
  ShippingService shippingService = ShippingService();
  int vari;
  void addToLineItems() {
    for (int i = 0; i < vari; i++) {
      CheckOutPage.line_item.add(LineItems(
              id: CartList.cartlist[i]["id"],
              quantity: CartList.cartlist[i]["quantity"])
          .toMap());
      print(CheckOutPage.line_item);
      print("");
//      CheckOutPage.line_item.add({
//        "id": CartList.cartlist[i]["id"],
//        "quantity": CartList.cartlist[i]["quantity"]
//      });
    }
  }

  var quantity = 1;
  Products products = Products();
  MainScreen3 mainScreen3 = MainScreen3();
  int totalList = 0;
//  int setPrice(int index) {
//    for (int i = 0; i < CartList.cartlist.length; i++) {
//      widget.myPrice.add(
//          CartList.cartlist[i]["price"] * CartList.cartlist[i]["quantity"]);
//      CartForGrocon.total += widget.myPrice[i];
//    }
//    return widget.myPrice[index];
//    getSinglePrice(index);
//  }
//
//  getSinglePrice(int index) {
//    return widget.myPrice[index];
//  }

  setPrice() {
    for (int i = 0; i < CartList.cartlist.length; i++) {
      widget.myPrice.add(
          CartList.cartlist[i]["price"] * CartList.cartlist[i]["quantity"]);
      CartForGrocon.total += widget.myPrice[i];
    }
  }

  LineItems lineItems = LineItems();
  List shippingProp = [];
  String minvalue;
  getShippingApi() async {
    shippingProp = await shippingService.getShippingProperties();
    minvalue = shippingProp[0]["settings"]["min_amount"]["value"];
  }

  @override
  void initState() {
//    widget.sharedPrefsetIds();
    vari = CartList.cartlist.length;
    widget.sharedPrefgetIds(totalProducts: widget.listofProducts);
    CartForGrocon.total = 0;
    getShippingApi();
    setPrice();
    //TODO:temporary set 100 to product price
    // setPrice();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        setState(() async {
          SharedPreferences sharedPref = await SharedPreferences.getInstance();
          List length1 = [];
          length1 = await sharedPref.getStringList("cartids");
          setState(() {
            Navigator.pop(context, length1.length);
          });
        });
      },
      child: Scaffold(
        backgroundColor: scaffoldBackgroundColor,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: appBarColor,
          leading: IconButton(
            onPressed: () async {
              SharedPreferences sharedPreferences =
                  await SharedPreferences.getInstance();
              List length = [];
              length = await sharedPreferences.getStringList("cartids");
              setState(() {
                Navigator.pop(context, length.length);
              });
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
              size: 28.0,
            ),
          ),
          title: Text(
            "Cart",
            style: TextStyle(
              color: appBarTextColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Column(
          children: [
            Container(
              height: 525.0,
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  //TODO: Change Price
                  return CartTile(
                    imagepath: CartList.cartlist[index]["imagePath"],
                    title: CartList.cartlist[index]["title"],
                    price: widget.myPrice[index],
//                    delete1: () async {
//                      setState(() {
//                        for (int i = 0;
//                            i < CartList.cartlist[index]["quantity"];
//                            i++) {
//                          total -= CartList.cartlist[index]["price"];
//                        }
//                        CartList.cartlist.removeAt(index);
//                      });
//                      setState(() {
//                        MainScreen3.cartTotal = MainScreen3.cartTotal -
//                            CartList.cartlist[index]["price"];
//                      });
//                      await sharedPrefsetIds();
//                    },
                    //TODO: funtion 2 when quantity is 1.
                    delete2: () async {
                      setState(() {
                        CartForGrocon.total -=
                            CartList.cartlist[index]["price"];
                        CartList.cartlist.removeAt(index);
                      });
                      await widget.sharedPrefsetIds();
                      setState(() {
                        MainScreen3.cartTotal = MainScreen3.cartTotal -
                            CartList.cartlist[index]["price"];
                        print("");
                      });
                    },
                    plusButton: () {
                      setState(() {
                        CartList.cartlist[index]["quantity"]++;
                        widget.myPrice[index] = CartList.cartlist[index]
                                ["price"] *
                            CartList.cartlist[index]["quantity"];
                        CartForGrocon.total +=
                            CartList.cartlist[index]["price"];
//                        for (int i = 0;
//                            i < (CartList.cartlist[index]["quantity"] - 1);
//                            i++) {
//                          setState(() {
//                            total += CartList.cartlist[i]["price"];
//                          });
//                        }
                      });
                    },
                    minusButton: () {
                      setState(() {
                        CartList.cartlist[index]["quantity"]--;
                        widget.myPrice[index] = CartList.cartlist[index]
                                ["price"] *
                            CartList.cartlist[index]["quantity"];
                        CartForGrocon.total -=
                            CartList.cartlist[index]["price"];
                      });
                    },
                    quantity: CartList.cartlist[index]["quantity"],
                  );
                },
                itemCount: CartList.cartlist.length,
              ),
            ),
          ],
        ),
        bottomSheet: Container(
          height: 170.0,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(40.0)),
          child: Column(
            children: [
              Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Text(
                    "Total: " + CartForGrocon.total.toString() + " Rs.",
                    style: TextStyle(fontSize: 15.0, color: productPriceColor),
                  )),
              CartForGrocon.someWidgets == false
                  ? Container()
                  : Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Text(
                        "Shipping price: 0.0 Rs.",
                        style:
                            TextStyle(fontSize: 15.0, color: productPriceColor),
                      )),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: CartList.cartlist.length == 0
                    ? FlatButton(
                        onPressed: () {
                          Fluttertoast.showToast(
                              msg: "Cart is empty.",
                              toastLength: Toast.LENGTH_SHORT,
                              backgroundColor: toastColor,
                              gravity: ToastGravity.CENTER);
                        },
                        child: Text("Check Out"),
                        color: Colors.grey,
                        padding: EdgeInsets.fromLTRB(100.0, 0.0, 100.0, 0.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                        textColor: Colors.white,
                      )
                    : FlatButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CheckOutPage()));
                          CheckOutPage.line_item = [];
                          addToLineItems();
                        },
                        child: Text("Check Out"),
                        color: productButtonColor,
                        padding: EdgeInsets.fromLTRB(100.0, 0.0, 100.0, 0.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                        textColor: Colors.white,
                      ),
              ),
              Text(
                "Note\n" +
                    "Free Shipping over the purchase of " +
                    "2500" +
                    " Rs.",
                textAlign: TextAlign.center,
                style: TextStyle(color: buttonColor),
              )
            ],
          ),
        ),
      ),
    );
  }
}

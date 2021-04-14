import 'package:ecommerceapp/ColorsForGrocon/colorsForGrocon.dart';
import 'package:ecommerceapp/Dart_lists/cart_list.dart';
import 'package:ecommerceapp/Screen_3/billing_details.dart';
import 'package:ecommerceapp/Screen_3/cart_page_for_grocon.dart';
import 'package:ecommerceapp/Screen_3/main_screen_3.dart';
import 'package:ecommerceapp/Screen_3/shipping_details.dart';
import 'package:ecommerceapp/models/customer_billing_properties.dart';
import 'package:ecommerceapp/services/createOrder_service.dart';
import 'package:ecommerceapp/services/shipping_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'check_out_page.dart';

class PayToGo extends StatefulWidget {
  @override
  _PayToGoState createState() => _PayToGoState();
}

class _PayToGoState extends State<PayToGo> {
  BillingProperties billingProperties = BillingProperties();
  bool loading = false;
  CreateOrder createorder = CreateOrder();
  List myImage = [];
  int allTotal = 0;

  _showDialog() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        insetPadding: EdgeInsets.fromLTRB(50.0, 150.0, 50.0, 150.0),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        title: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 50.0,
              decoration: BoxDecoration(color: buttonColor),
              child: Center(
                child: Text(
                  "Thank You",
                  style: TextStyle(color: buttonTextColor),
                ),
              ),
            ),
          ],
        ),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Please Take a Screenshot of your receipt"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("OR"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Note Down Your Order id"),
            ),
          ],
        ),
        actions: <Widget>[
          Center(
            child: FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("OK"),
              color: buttonColor,
              textColor: buttonTextColor,
            ),
          )
        ],
      ),
    );
  }

  List<dynamic> shippingProp = [];
  bool shipLoding = true;
  int shippingPrice = 170;
  int minvalue = 0;
  ShippingService shippingService = ShippingService();
  getApi() async {
    shippingProp = await shippingService.getShippingProperties();
    minvalue = int.parse(shippingProp[0]["settings"]["min_amount"]["value"]);
    methodTitle = shippingProp[0]["title"];
    setState(() {
      shipLoding = false;
    });
  }

  bool response = false;
  bool value = false;
  String methodTitle;
  @override
  void initState() {
    super.initState();
    getApi();
//    getImage();
    allTotal = CartForGrocon.total + shippingPrice;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: shipLoding
          ? Center(child: CircularProgressIndicator())
          : Container(
              height: 290.0,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: CartForGrocon.total >= minvalue
                        ? Text("Total: " + CartForGrocon.total.toString(),
                            style:
                                TextStyle(color: buttonColor, fontSize: 20.0))
                        : Text(
                            "Total: " + allTotal.toString(),
                            style:
                                TextStyle(color: buttonColor, fontSize: 20.0),
                          ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Text(
                      "Subtotal: " + CartForGrocon.total.toString(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: CartForGrocon.total >= minvalue
                        ? Text(
                            "Shipping: Free Shipping",
                            style: TextStyle(color: buttonColor),
                          )
                        : Text("Shipping: " + shippingPrice.toString()),
                  ),
                  Text(
                    "Address",
                    style: TextStyle(color: buttonColor),
                  ),
                  Text(
                    BillingDetails.mapvarforBilling["address_1"] ??
                        "Please edit billing details",
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  CartForGrocon.total >= minvalue
                      ? Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: loading
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : FlatButton(
                                  onPressed: () async {
                                    setState(() {
                                      loading = true;
                                    });
                                    response = await createorder.createOrder(
                                        line_item: CheckOutPage.line_item,
                                        billing:
                                            BillingDetails.mapvarforBilling,
                                        shipping:
                                            ShippingDetails.mapvarforShipping);
                                    if (response) {
                                      Fluttertoast.showToast(
                                          msg: "Order Created");
                                      setState(() {
                                        loading = false;
                                      });
                                      _showDialog();
                                    } else {
                                      setState(() {
                                        loading = false;
                                      });
                                    }
                                  },
                                  child: Text("Place Order"),
                                  textColor: buttonTextColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  color: buttonColor,
                                ),
                        )
                      : Container(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Checkbox(
                                    value: value,
                                    onChanged: response
                                        ? null
                                        : (bool changevalue) {
                                            setState(() {
                                              value = changevalue;
                                            });
                                          },
                                    checkColor: Colors.white,
                                  ),
                                  Text(
                                    "Payment Method: COD ",
                                    style: TextStyle(color: Colors.grey[700]),
                                  ),
                                ],
                              ),
                              response
                                  ? Container()
                                  : value == false
                                      ? Container()
                                      : Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: loading
                                              ? Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                )
                                              : FlatButton(
                                                  onPressed: () async {
                                                    setState(() {
                                                      loading = true;
                                                    });
                                                    response = await createorder
                                                        .createOrder(
                                                            line_item:
                                                                CheckOutPage
                                                                    .line_item,
                                                            billing: BillingDetails
                                                                .mapvarforBilling,
                                                            shipping:
                                                                ShippingDetails
                                                                    .mapvarforShipping);
                                                    if (response) {
                                                      Fluttertoast.showToast(
                                                          msg: "Order Created");
                                                      setState(() {
                                                        loading = false;
                                                      });
                                                      _showDialog();
                                                    } else {
                                                      setState(() {
                                                        loading = false;
                                                      });
                                                    }
                                                  },
                                                  child: Text("Place Order"),
                                                  textColor: buttonTextColor,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0)),
                                                  color: buttonColor,
                                                ),
                                        )
                            ],
                          ),
                        )
                ],
              ),
            ),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () async {
            Navigator.pop(context);
            SharedPreferences sharedPref =
                await SharedPreferences.getInstance();
            if (response == true) {
              setState(() {
                CartList.cartlist = [];
                sharedPref.setStringList("cartids", []);
              });
            }
          },
        ),
        title: Text(
          "Pay To Go",
          style: TextStyle(color: appBarTextColor),
        ),
        centerTitle: true,
        backgroundColor: appBarColor,
      ),
      body: Container(
        height: 385.0,
        child: CustomScrollView(
          slivers: [
            SliverList(
                delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
              myImage = CartList.cartlist[index]["imagePath"];
              return ListTile(
                leading: myImage.isEmpty
                    ? Image.asset("assets/empty.png")
                    : Image.network(myImage[0]["src"]),
                title: Text(CartList.cartlist[index]["title"]),
                subtitle: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text("Price per Piece\n" +
                          CartList.cartlist[index]["price"].toString()),
                    ),
                    Expanded(
                      child: Text("Quantity\n" +
                          CartList.cartlist[index]["quantity"].toString()),
                    ),
                    Expanded(
                      child: Text("Total\n" +
                          (CartList.cartlist[index]["quantity"] *
                                  CartList.cartlist[index]["price"])
                              .toString()),
                    )
                  ],
                ),
              );
            }, childCount: CartList.cartlist.length))
          ],
        ),
      ),
    );
  }
}

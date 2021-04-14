import 'package:ecommerceapp/Screen_1/cart_page.dart';
import 'package:flutter/material.dart';
import 'package:ecommerceapp/Dart_lists/cart_list.dart';

class CheckOut extends StatefulWidget {
  bool checkBoxValue = false;
  bool checkBoxValue1 = false;

  @override
  _CheckOutState createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  void value(bool value) {
    widget.checkBoxValue = value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text("Check Out"),
      ),
      body: ListView(children: [
        Column(
          children: <Widget>[
            //card for address
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              elevation: 3.8,
              margin: EdgeInsets.all(15.0),
              child: Container(
                padding: EdgeInsets.all(60.0),
                child: Center(
                  child:
                      Text("Address:\n\n House no.1, Street no.3 DHA Lahore"),
                ),
              ),
            ),
            //card for show selected products
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              elevation: 3.8,
              margin: EdgeInsets.all(15.0),
              child: Container(
                padding: EdgeInsets.all(20.0),
                child: Container(
                  height: 200.0,
                  child: ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        leading: Image.asset(
                          CartList.cartlist[index]["image"][0],
                          width: 70.0,
                        ),
                        title: Text(CartList.cartlist[index]["name"]),
                        trailing: Column(
                          children: [
                            Text(
                              CartList.cartlist[index]["price"].toString() +
                                  " Rs",
                              style: TextStyle(
                                  color: Colors.orange,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0),
                            ),
                            Text(
                              CartList.cartlist[index]["old_price"] + " Rs",
                              style: TextStyle(
                                  decoration: TextDecoration.lineThrough),
                            ),
                          ],
                        ),
                      );
                    },
                    itemCount: CartList.cartlist.length,
                  ),
                ),
              ),
            ),
            //payment method card
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              elevation: 3.8,
              margin: EdgeInsets.all(15.0),
              child: Container(
                padding: EdgeInsets.all(60.0),
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Text("Select Payment Method"),
                      ListTile(
                        leading: Icon(
                          Icons.monetization_on,
                          color: Colors.orange,
                        ),
                        title: Text(
                          "Cash On Delivery",
                          style: TextStyle(fontSize: 12.0),
                        ),
                        trailing: Checkbox(
                          activeColor: Colors.orange,
                          value: widget.checkBoxValue,
                          onChanged: (newValue) {
                            setState(() {
                              widget.checkBoxValue = newValue;
                            });
                          },
                        ),
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.money,
                          color: Colors.orange,
                        ),
                        title: Text(
                          "Through Bank",
                          style: TextStyle(fontSize: 12.0),
                        ),
                        trailing: Checkbox(
                          activeColor: Colors.orange,
                          value: widget.checkBoxValue1,
                          onChanged: (newValue1) {
                            setState(() {
                              widget.checkBoxValue1 = newValue1;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ]),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BuyNowCheckOut extends StatefulWidget {
  BuyNowCheckOut({this.name, this.price, this.description, this.imagePath});

  final name;
  final price;
  final imagePath;
  final description;
  @override
  _BuyNowCheckOutState createState() => _BuyNowCheckOutState();
}

class _BuyNowCheckOutState extends State<BuyNowCheckOut> {
  bool checkBoxValue = false;
  bool checkBoxValue1 = false;
  @override
  Widget build(BuildContext context) {
    print(widget.name.toString());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text("Check Out"),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 20.0),
            child: Column(
              children: <Widget>[
                Center(
                  //card for image, name and price.
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    elevation: 3.8,
                    margin: EdgeInsets.all(15.0),
                    child: Container(
                      padding: EdgeInsets.all(40.0),
                      child: Center(
                        child: Column(
                          children: <Widget>[
                            Container(
                              height: 120.0,
                              child: Image.asset(widget.imagePath[0]),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                widget.name.toString(),
                                style: TextStyle(
                                    fontSize: 27.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Text(
                              "Price: " + widget.price.toString() + " Rs",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25.0,
                                  color: Colors.orange),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                //card for address
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  margin: EdgeInsets.all(15.0),
                  elevation: 3.8,
                  child: Container(
                    child: Container(
                      padding: EdgeInsets.all(60.0),
                      child: Center(
                        child: Text(
                            "Address:\n\nHouse no.1, Street no.3 DHA Lahore"),
                      ),
                    ),
                  ),
                ),
                //card for payment method
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
                          //listtile for payment method as COD
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
                              value: checkBoxValue,
                              onChanged: (newValue) {
                                setState(() {
                                  checkBoxValue = newValue;
                                });
                              },
                            ),
                          ),
                          //listtile for payment method as text
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
                              value: checkBoxValue1,
                              onChanged: (newValue1) {
                                setState(() {
                                  checkBoxValue1 = newValue1;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                FlatButton(
                  onPressed: () {},
                  child: Text("Proceed"),
                  textColor: Colors.white,
                  color: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  padding: EdgeInsets.all(25.0),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

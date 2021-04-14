import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../main.dart';
import 'package:ecommerceapp/Dart_lists/cart_list.dart';
import 'checkout_page.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  //creating empty list of product counter.
  List<int> _products1 = [];

  int _product_price = 0;
  int total = 0;
  Color colour;

  //declaring index of bottomAppBar
  int _currentIndex = 1;
  void _indexOnTap(int index) {
    setState(() {
      _currentIndex = index;
      if (index == 0) {
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) => MyHome()));
      }
    });
  }

  @override
  void initState() {
    //in initState we declare for_loop for adding "1" in product_list for every index and the maximum value of loop is length of cart_list.
    for (int i = 0; i <= CartList.cartlist.length; i++) {
      _products1.add(1);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(CartList.cartlist);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(
          "Cart",
          style: TextStyle(color: Colors.orange),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          _product_price =
              _products1[index] * int.parse(CartList.cartlist[index]["price"]);
          String item;

          return Dismissible(
            onDismissed: (direction) {
              CartList.cartlist.removeAt(index);
              Fluttertoast.showToast(
                  msg: "Item Removed",
                  textColor: Colors.white,
                  backgroundColor: Colors.orange,
                  gravity: ToastGravity.CENTER);
            },
            background: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                      size: 30.0,
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.orange,
              ),
            ),
            key: Key(item),
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                elevation: 3.8,
                color: colour,
                child: ListTile(
                  leading: Image.asset(
                    CartList.cartlist[index]["image"][0],
                    width: 70.0,
                  ),
                  title: Text(CartList.cartlist[index]["name"]),
                  subtitle: Row(
                    children: [
                      FlatButton(
                        onPressed: () {
                          setState(() {
                            total = _product_price;
                            _products1[index]++;

                            print(_product_price);
                          });
                        },
                        child: Text("+"),
                        minWidth: 10.0,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(50.0))),
//   color: Colors.orange,
                      ),
                      Text(
                        _products1[index].toString(),
                        textAlign: TextAlign.center,
                      ),
                      FlatButton(
                        onPressed: () {
                          setState(() {
                            total = _product_price;
                            if (_products1[index] == 1) {
                              _products1[index] = 1;
                            } else {
                              _products1[index]--;
                            }
                          });
                        },
                        child: Text("-"),
                        minWidth: 10.0,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(50.0))),
//    color: Colors.orange,
                      ),
                    ],
                  ),
                  trailing: Column(
                    children: [
                      Text(
                        _product_price.toString() + " Rs",
                        style: TextStyle(
                            color: Colors.orange,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0),
                      ),
                      Text(
                        CartList.cartlist[index]["old_price"] + " Rs",
                        style:
                            TextStyle(decoration: TextDecoration.lineThrough),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        itemCount: CartList.cartlist.length,
      ),
      floatingActionButton: Row(
        children: <Widget>[
          Expanded(
              child: Padding(
            padding: const EdgeInsets.only(left: 50.0),
            child: Text("Total: "),
          )),
          Expanded(
            child: FlatButton(
                padding: EdgeInsets.all(20.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                onPressed: () {
                  if (CartList.cartlist.isEmpty) {
                    Fluttertoast.showToast(
                        msg: "Cart is Empty",
                        textColor: Colors.white,
                        backgroundColor: Colors.orange,
                        gravity: ToastGravity.CENTER);
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        // CheckOut()
                        builder: (BuildContext context) => CheckOut(),
                      ),
                    );
                  }
                },
                child: Text("Proceed to checkout"),
                color: Colors.orange,
                textColor: Colors.white),
          ),
        ],
      ),
    );
  }
}

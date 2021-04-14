import 'dart:io';
import 'package:flutter/material.dart';
import 'package:ecommerceapp/Screen_3/main_screen_3.dart';
import 'Screen_2/main_screen_2.dart';
import 'main.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // when user press back button this function will popup
  Future<bool> _onwillPop() {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Are You Sure?"),
              content: Text("Do You want to exit from app"),
              actions: [
                FlatButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: Text(
                      "NO",
                      style: TextStyle(color: Colors.orange),
                    )),
                FlatButton(
                    onPressed: () => exit(0),
                    child: Text(
                      "YES",
                      style: TextStyle(color: Colors.orange),
                    )),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onwillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Select Screen"),
          centerTitle: true,
          backgroundColor: Colors.deepOrange,
          leading: Icon(Icons.add, color: Colors.deepOrange),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FlatButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => MyHome()));
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                      child: Text("First Screen"),
                      color: Colors.deepOrange,
                      textColor: Colors.white),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FlatButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    SecondScreenModel()));
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                      child: Text("Second Screen"),
                      color: Colors.deepOrange,
                      textColor: Colors.white),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FlatButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => MainScreen(),
                            ));
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                      child: Text("Third Screen"),
                      color: Colors.deepOrange,
                      textColor: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

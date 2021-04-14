import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//my imports
import 'category_page.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: Colors.orange),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 10.0,
              child: Icon(Icons.image, size: 70.0),
            ),
            accountName: Text("Name: ABC"),
            accountEmail: Text("Email: abc@gmail.com"),
            arrowColor: Colors.orange,
          ),
          SizedBox(
            height: 550.0,
            child: ListView(
              children: [
                ListTile(
                  leading: Icon(Icons.home),
                  title: Text("Home"),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(Icons.store),
                  title: Text("Store"),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(Icons.list),
                  title: Text("Categories"),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CategoryPage()));
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

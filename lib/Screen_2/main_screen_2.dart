import 'dart:io';
import 'package:ecommerceapp/Screen_1/cart_page.dart';
import 'package:ecommerceapp/Screen_1/category_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ecommerceapp/Dart_lists/category_list2.dart';
import 'package:ecommerceapp/custom_widgets/custom_container.dart';
import 'package:ecommerceapp/custom_widgets/custom_bars.dart';
import 'package:ecommerceapp/custom_widgets/custome_card.dart';
import 'products_page2.dart';
import 'profile_page.dart';
import 'package:ecommerceapp/main.dart';

class SecondScreenModel extends StatefulWidget {
  @override
  _SecondScreenModelState createState() => _SecondScreenModelState();
}

class _SecondScreenModelState extends State<SecondScreenModel> {
  //index for bottomNavigationBar
  int _currentIndex = 0;
  void _indexOnTap(int index) {
    setState(() {
      _currentIndex = index;
      _pageController.animateToPage(index,
          duration: Duration(milliseconds: 500), curve: Curves.ease);
    });
  }

  PageController _pageController =
      PageController(initialPage: 0, keepPage: true);
  // ignore: missing_return
  Widget _drawer() {
    return Drawer(
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Colors.orangeAccent, Colors.deepOrange])),
              accountEmail: Text("UserEmail"),
              accountName: Text("UserName"))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xF1F1F1F1),
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        elevation: 0.0,
      ),
      drawer: _drawer(),
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: [
          AppBody2(),
          ProductsPage2(),
          ProfilePage(),
          CartPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _indexOnTap,
        fixedColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("Home")),
          BottomNavigationBarItem(
              icon: Icon(Icons.store), title: Text("Store")),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_box_outlined), title: Text("Profile")),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), title: Text("Cart")),
        ],
      ),
    );
  }
}

class AppBody2 extends StatefulWidget {
  @override
  _AppBody2State createState() => _AppBody2State();
}

class _AppBody2State extends State<AppBody2> {
  Category2 category2 = Category2();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Column(
                  children: [
                    Stack(
                      children: [
                        CustomContainer(
                            height: 200.0, color: Colors.amber, radius: 70.0),
                        CustomContainer(
                            height: 125.0, color: Colors.orange, radius: 70.0),
                        CustomContainer(
                            height: 50.0,
                            color: Colors.deepOrange,
                            radius: 230.0),
                        Padding(
                          padding: const EdgeInsets.all(25.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Woo-Commerce",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "App that fits your style",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 30.0),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 70.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey,
                                          blurRadius: 8.0,
                                          spreadRadius: 4.0),
                                    ],
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  height: 60.0,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      TextField(
                                        cursorColor: Colors.orangeAccent,
                                        decoration: InputDecoration(
                                          hintText: "Search",
                                          hintStyle:
                                              TextStyle(color: Colors.grey),
                                          border: InputBorder.none,
                                          prefixIcon: Icon(
                                            Icons.search,
                                            color: Colors.orangeAccent,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 40.0,
                      child: Row(
                        children: [
                          Expanded(
                            //custom row Bar for showing left and right text like (category and seeAll) text
                            child: CustomRowBar(
                              color: Colors.black,
                              fontSize: 20.0,
                              text: "Categories",
                              padding: EdgeInsets.only(left: 12.0),
                              mainAxisDirection: MainAxisAlignment.start,
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CategoryPage()));
                              },
                              //custom row Bar for showing left and right text like (category and seeAll) text
                              child: CustomRowBar(
                                color: Colors.blue,
                                text: "See All",
                                padding: EdgeInsets.only(right: 12.0),
                                mainAxisDirection: MainAxisAlignment.end,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 80.0,
                      width: MediaQuery.of(context).size.width,
                      //listView.builder for category list
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            width: 100.0,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
                                  if (index == 4) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                CategoryPage()));
                                  }
                                },
                                child: Card(
                                  color: Colors.white,
                                  elevation: 0.0,
                                  margin: EdgeInsets.all(0.0),
                                  child: category2.category2_list[index]
                                      ["icon"],
                                ),
                              ),
                            ),
                          );
                        },
                        itemCount: category2.category2_list.length,
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 190.0,
                  //listview for showing custom card
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      //custom cards
                      CustomeCard(),
                      CustomeCard(),
                      CustomeCard()
                    ],
                  ),
                ),
              ],
            ),
          ),

          //SliverGrid for showing products
          SliverGrid(
              delegate:
                  SliverChildBuilderDelegate((BuildContext context, int index) {
                return null;
              }, childCount: 0),
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2)),
        ],
      ),
    );
  }
}

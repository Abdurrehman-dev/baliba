import 'dart:async';
import 'package:ecommerceapp/Screen_3/LoginPageForGrocon.dart';
import 'package:ecommerceapp/Screen_3/main_screen_3.dart';
import 'package:ecommerceapp/providerLength.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Dart_lists/cart_list.dart';
import 'Screen_1/my_drawer.dart';
//my imports
import 'Screen_1/app_body.dart';
import 'Screen_1/cart_page.dart';
import 'package:provider/provider.dart';
import 'package:ecommerceapp/Dart_lists/provider_cartList.dart';
import 'package:ecommerceapp/ColorsForGrocon/colorsForGrocon.dart';

//creating object of CartList
CartList cart = CartList();

void main() => runApp(ChangeNotifierProvider<CartLength>(
      create: (context) => CartLength(),
      child: MaterialApp(
        theme: ThemeData(accentColor: accentColor, primaryColor: Colors.white),

        title: "Beliba",

        // MyHome(),

        home: SplashScreen(),
      ),
    ));

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  String useremail = "";
  getUser() async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    useremail = await shared.getString("useremail") ?? "";
    return useremail;
  }

  AnimationController animationController;

  var value = 0.0;
  @override
  void initState() {
    getUser();
    print(useremail);
    print("");
    animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1100));
    animationController.forward();
    animationController.addListener(() {
      setState(() {
        value = animationController.value;
      });
    });
    Timer(Duration(milliseconds: 5000), () {
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            transitionDuration: Duration(milliseconds: 1500),
            transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secAnimation,
                Widget child) {
              animation =
                  CurvedAnimation(parent: animation, curve: Curves.bounceOut);
              return ScaleTransition(
                  scale: animation,
                  alignment: Alignment.bottomCenter,
                  child: child);
            },
            pageBuilder: (BuildContext context, Animation<double> animation,
                    Animation<double> secAnimation) =>
                useremail == "" ? LoginPageForGrocon() : MainScreen(),
            /* MainPage() SecondScreenModel() MyHome()*/
          ));
    });
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(80.0),
          child: Transform.scale(
              scale: value + 0.3, child: Image.asset("assets/MainLogo.png")),
        ),
      ),
    );
  }
}

class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    PageController pageController = PageController(
      initialPage: 0,
      keepPage: true,
    );
    void _indexOnTap(int index) {
      setState(() {
        _currentIndex = index;
        pageController.animateToPage(index,
            duration: Duration(microseconds: 500), curve: Curves.ease);
      });
    }

    return Scaffold(
      //creating Drawer
      drawer: MyDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.orange,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
        ],
        title: Text("E-Commerce"),
      ),
      // body: AppBody(),
      //Adding pageview in body property
      body: PageView(
        controller: pageController,
        onPageChanged: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        //children are Pages
        children: [
          AppBody(),
          CartPage(),
        ],
      ),
      //adding bottom navigation bar
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.orange,
        selectedFontSize: 15.0,
        currentIndex: _currentIndex,
        onTap: _indexOnTap,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            label: "Home",
            icon: Icon(Icons.store),
          ),
          BottomNavigationBarItem(
            label: "Cart",
            icon: Icon(Icons.shopping_cart),
          ),
        ],
      ),
    );
  }
}

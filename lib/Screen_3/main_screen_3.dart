import 'dart:io';
import 'package:ecommerceapp/ColorsForGrocon/colorsForGrocon.dart';
import 'package:ecommerceapp/Dart_lists/cart_list.dart';
import 'package:ecommerceapp/Screen_3/Category_screen.dart';
import 'package:ecommerceapp/Screen_3/cart_page_for_grocon.dart';
import 'package:ecommerceapp/Screen_3/user_profileForGrocon.dart';
import 'package:ecommerceapp/custom_widgets/category_product_grocon.dart';
import 'package:ecommerceapp/custom_widgets/customLoadingWidget.dart';
import 'package:ecommerceapp/models/User_model_attributes.dart';
import 'package:ecommerceapp/models/product_model_attributes.dart';
import 'package:ecommerceapp/services/product_services.dart';
import 'package:flutter/material.dart';
import 'package:ecommerceapp/Dart_lists/category_list_for_grocon.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:ecommerceapp/custom_widgets/custom_bars.dart';
import 'package:ecommerceapp/custom_widgets/custom_productCardForGrocon.dart';
import 'package:ecommerceapp/Dart_lists/products.dart';
import 'package:ecommerceapp/Screen_3/store_for_grocon.dart';
import 'package:ecommerceapp/sharedPreferencesFile.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:ecommerceapp/Search/searchClass.dart';

PageController pageController = PageController(
  viewportFraction: 1.0,
  initialPage: 0,
  keepPage: true,
);
User user = User();
String SERVER = "https://beliba.co/wp-json/wc/v3/";
String SERVER_KEY =
    "?consumer_key=ck_d0b31fb757972cd8784a5effb691d6221d23f0f5&consumer_secret=cs_d073c5818a9192fdb5aa582e86708b723c84102d";

class MainScreen extends StatefulWidget {
  _MainScreenState mainScreenState = _MainScreenState();
  MainScreen({this.myvalue});
  var myvalue = 0;
  static var val = 0;
  var lengthValue = "";
  static var cartlength = 0;
  setcartLength() {
    mainScreenState.getCartLength();
  }

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  getlengthValue() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    setState(() async {
      List length = await sharedPref.getStringList("cartids");
      MainScreen.cartlength = length.length;
    });
  }

  CartForGrocon cartForGrocon = CartForGrocon();
  SharedPrefernce sharedPrefernce = SharedPrefernce();
  UserProfileForGrocon userProfile = UserProfileForGrocon();
  int currentIndex = 0;
  bool loading = true;
  ProductService productService = ProductService();
  List allProducts = [];

  getApi() async {
    allProducts = await productService.getAllProducts();
    setState(() {
      loading = false;
    });
    cartForGrocon.sharedPrefgetIds(totalProducts: allProducts);
  }

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
                      style: TextStyle(color: productButtonColor),
                    )),
                FlatButton(
                    onPressed: () => exit(0),
                    child: Text(
                      "YES",
                      style: TextStyle(color: productButtonColor),
                    )),
              ],
            ));
  }

  @override
  void initState() {
    MainScreen.val = widget.myvalue;
    getApi();
    getlengthValue();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onwillPop,
      child: Scaffold(
        backgroundColor: Colors.white,
//        appBar: AppBar(
//          leading: Image.asset(""),
//          backgroundColor: Colors.white,
//          title: Image.asset(
//            "assets/MainLogo.png",
//            height: 35.0,
//          ),
//          centerTitle: false,
//          actions: <Widget>[
//            loading
//                ? Stack(
//                    children: [
//                      IconButton(
//                        icon: Icon(Icons.shopping_cart),
//                        onPressed: () {
//                          Fluttertoast.showToast(
//                              msg: "Please Wait!",
//                              gravity: ToastGravity.CENTER);
//                        },
//                        color: buttonColor,
//                      ),
//                      MainScreen.cartlength == 0
//                          ? Container()
//                          : Padding(
//                              padding: const EdgeInsets.fromLTRB(
//                                  20.0, 5.0, 0.0, 0.0),
//                              child: CircleAvatar(
//                                child: Center(
//                                  child: Text(
//                                    MainScreen.cartlength.toString(),
//                                    style: TextStyle(
//                                        color: Colors.white, fontSize: 10.0),
//                                  ),
//                                ),
//                                radius: 8.0,
//                                backgroundColor: Colors.pink[300],
//                              ),
//                            ),
//                    ],
//                  )
//                : Stack(
//                    children: [
//                      IconButton(
//                        icon: Icon(Icons.shopping_cart),
//                        onPressed: () async {
//                          var result = await Navigator.push(
//                              context,
//                              PageRouteBuilder(
//                                transitionDuration: Duration(milliseconds: 500),
//                                transitionsBuilder:
//                                    (context, animation, secAnimation, child) {
//                                  return ScaleTransition(
//                                    scale: animation,
//                                    alignment: Alignment.topRight,
//                                    child: child,
//                                  );
//                                },
//                                pageBuilder:
//                                    (context, animation, secAnimation) =>
//                                        CartForGrocon(
//                                  listofProducts: allProducts,
//                                ),
//                              ));
//
//                          setState(() {
//                            MainScreen.cartlength = result;
//                          });
//                        },
//                        color: buttonColor,
//                      ),
//                      MainScreen.cartlength == 0
//                          ? Container()
//                          : Padding(
//                              padding: const EdgeInsets.fromLTRB(
//                                  20.0, 5.0, 0.0, 0.0),
//                              child: CircleAvatar(
//                                child: Center(
//                                  child: Text(
//                                    MainScreen.cartlength.toString(),
//                                    style: TextStyle(
//                                        color: Colors.white, fontSize: 10.0),
//                                  ),
//                                ),
//                                radius: 8.0,
//                                backgroundColor: Colors.pink[300],
//                              ),
//                            ),
//                    ],
//                  ),
//            IconButton(
//                icon: Icon(
//                  Icons.notifications,
//                  color: iconColor,
//                ),
//                onPressed: () {
//                  print("Notification");
//                })
//          ],
//        ),
        body: PageView(
          physics: ScrollPhysics(
            parent: NeverScrollableScrollPhysics(),
          ),
          controller: pageController,
          onPageChanged: (int index) {
            setState(() {
              currentIndex = index;
            });
          },
          children: [
            MainScreen3(),
            CategoryScreen(),
            StoreGrocon(),
            UserProfileForGrocon(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index) async {
            if (index == 3) {
              var email = await sharedPrefernce.getEmail() ?? "";
              var pass = await sharedPrefernce.getPassword();
              var name = await sharedPrefernce.getName() ?? "";
              var postCode = await sharedPrefernce.getPostCode() ?? "";
              var address = await sharedPrefernce.getAddress() ?? "";
              setState(() {
                if (email == "" &&
                    pass == "" &&
                    name == "" &&
                    postCode == "" &&
                    address == "") {
                  UserProfileForGrocon.name = "Please Sign In";
                  UserProfileForGrocon.password = "Please Sign In";
                  UserProfileForGrocon.emailId = "Please Sign In";
                  UserProfileForGrocon.address = "Please Sign In";
                  UserProfileForGrocon.postCode = "Please Sign In";
                } else {
                  UserProfileForGrocon.emailId = email;
                  UserProfileForGrocon.password = pass;
                  UserProfileForGrocon.name = name;
                  UserProfileForGrocon.postCode = postCode;
                  UserProfileForGrocon.address = address;
                }
              });
            }
            setState(() {
              currentIndex = index;
              print(index);
              pageController.animateToPage(index,
                  duration: Duration(milliseconds: 1000), curve: Curves.ease);
            });
          },
          selectedItemColor: iconColor,
          unselectedItemColor: Colors.grey,
          currentIndex: currentIndex,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                title: Text("Home")),
            BottomNavigationBarItem(
                icon: Icon(Icons.category), title: Text("Categories")),
            BottomNavigationBarItem(
                icon: Icon(Icons.store), title: Text("Store")),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle_outlined),
                title: Text("Profile")),
          ],
        ),
      ),
    );
  }

  getCartLength() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    List length = [];
    length = await sharedPref.getStringList("cartids");
    setState(() {
      MainScreen.cartlength = length.length;
    });
  }
}

class MainScreen3 extends StatefulWidget {
  var result;
  int productTotal = 0;
  static int cartTotal = 0;
  var cartUpdate = 0;
  MainScreen mainScreen = MainScreen();
  @override
  _MainScreen3State createState() => _MainScreen3State();
}

class _MainScreen3State extends State<MainScreen3> {
  CategoryForGrocon categoryForGrocon = CategoryForGrocon();
  Products productlist = Products();
  ProductService productService = ProductService();
  bool loading = true;
  List featuredProduct = [];
  List allProducts = [];
  List categoriesList = [];
  getApi() async {
    allProducts = await productService.getAllProducts();
    categoriesList = await productService.getAllProductCategories();
    for (int i = 0; i < allProducts.length; i++) {
      if (allProducts[i]["featured"] == true) {
        featuredProduct.add(allProducts[i]);
      }
    }
    cartForGrocon.sharedPrefgetIds(totalProducts: allProducts);
    setState(() {
      loading = false;
    });
  }

  ProductAttributes productAttributes = ProductAttributes();
  CartForGrocon cartForGrocon = CartForGrocon();
  @override
  void initState() {
    getApi();
    MainScreen.val = CartList.cartlist.length;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset(""),
        backgroundColor: Colors.white,
        title: Image.asset(
          "assets/MainLogo.png",
          height: 35.0,
        ),
        centerTitle: false,
        actions: <Widget>[
          loading
              ? Stack(
                  children: [
                    IconButton(
                      icon: Icon(Icons.shopping_cart),
                      onPressed: () {
                        Fluttertoast.showToast(
                            msg: "Please Wait!", gravity: ToastGravity.CENTER);
                      },
                      color: buttonColor,
                    ),
                    MainScreen.cartlength == 0
                        ? Container()
                        : Padding(
                            padding:
                                const EdgeInsets.fromLTRB(20.0, 5.0, 0.0, 0.0),
                            child: CircleAvatar(
                              child: Center(
                                child: Text(
                                  MainScreen.cartlength.toString(),
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 10.0),
                                ),
                              ),
                              radius: 8.0,
                              backgroundColor: Colors.pink[300],
                            ),
                          ),
                  ],
                )
              : Stack(
                  children: [
                    IconButton(
                      icon: Icon(Icons.shopping_cart),
                      onPressed: () async {
                        var result = await Navigator.push(
                            context,
                            PageRouteBuilder(
                              transitionDuration: Duration(milliseconds: 500),
                              transitionsBuilder:
                                  (context, animation, secAnimation, child) {
                                return ScaleTransition(
                                  scale: animation,
                                  alignment: Alignment.topRight,
                                  child: child,
                                );
                              },
                              pageBuilder: (context, animation, secAnimation) =>
                                  CartForGrocon(
                                listofProducts: allProducts,
                              ),
                            ));

                        setState(() {
                          MainScreen.cartlength = result;
                        });
                      },
                      color: buttonColor,
                    ),
                    MainScreen.cartlength == 0
                        ? Container()
                        : Padding(
                            padding:
                                const EdgeInsets.fromLTRB(20.0, 5.0, 0.0, 0.0),
                            child: CircleAvatar(
                              child: Center(
                                child: Text(
                                  MainScreen.cartlength.toString(),
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 10.0),
                                ),
                              ),
                              radius: 8.0,
                              backgroundColor: Colors.pink[300],
                            ),
                          ),
                  ],
                ),
          IconButton(
              icon: Icon(
                Icons.notifications,
                color: iconColor,
              ),
              onPressed: () {
                print("Notification");
              })
        ],
      ),
//      floatingActionButton: CartList.cartlist.length == 0
//          ? Container()
//          : FloatingActionButton(
//              onPressed: () async {
//                widget.result = await Navigator.push(context,
//                    MaterialPageRoute(builder: (context) => CartForGrocon()));
//                print("Shopping Cart");
//                setState(() {
//                  MainScreen.val = widget.result;
//                });
//              },
//              child: Stack(
//                children: [
//                  Icon(Icons.shopping_cart, color: Colors.white),
//                  CartList.cartlist.length == 0
//                      ? Container()
//                      : Padding(
//                          padding:
//                              const EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),
//                          child: CircleAvatar(
//                            backgroundColor: Colors.white,
//                            radius: 10.0,
//                            child: Text(
//                              MainScreen.val.toString(),
//                              style:
//                                  TextStyle(color: iconColor, fontSize: 12.0),
//                            ),
//                          ),
//                        ),
//                ],
//              ),
//            ),
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: ListTile(
                                onTap: () {
                                  allProducts.isEmpty
                                      ? Fluttertoast.showToast(
                                          msg:
                                              "Please wait we are Fetching Data",
                                          gravity: ToastGravity.BOTTOM)
                                      : showSearch(
                                          context: context,
                                          delegate:
                                              Search(productList: allProducts));
                                },
                                leading: Icon(
                                  Icons.search,
                                  color: Colors.pink,
                                ),
                                title: Text("Search Products"),
                              ),
                            ),
//
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  height: 150.0,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        return loading
                            ? Image.asset("assets/empty.png")
                            : Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Container(
                                      height: 75.0,
                                      width: 85.0,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(40.0)),
                                      child: Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0)),
                                          elevation: 9.8,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: categoriesList[index]
                                                        ["image"] ==
                                                    null
                                                ? Image.asset(
                                                    "assets/empty.png")
                                                : Image.network(
                                                    categoriesList[index]
                                                        ["image"][0]["src"],
                                                  ),
                                          )),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(categoriesList[index]["name"],
                                        style: TextStyle()),
                                  ),
                                ],
                              );
                      },
                      itemCount: categoriesList.length),
                ),
                Container(
                  height: 200.0,
                  child: Carousel(
                    autoplay: true,
                    dotColor: Colors.grey,
                    dotIncreasedColor: iconColor,
                    dotBgColor: Colors.transparent,
                    dotSize: 5.0,
                    indicatorBgPadding: 10.0,
                    images: [
                      Container(
                        height: 180.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40.0)),
                        child: Card(
                          elevation: 9.8,
                          child: Image.asset("assets/baliba_carousel1.JPG",
                              fit: BoxFit.fill),
                        ),
                      ),
                      Container(
                        height: 180.0,
                        width: 100.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40.0)),
                        child: Card(
                          elevation: 9.8,
                          child: Image.asset("assets/baliba_carousel2.JPG",
                              fit: BoxFit.fill),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomRowBar(
                        mainAxisDirection: MainAxisAlignment.start,
                        padding: EdgeInsets.all(10.0),
                        text: "Recommended Products",
                        fontSize: 13.0,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding:
                            const EdgeInsets.fromLTRB(0.0, 10.0, 10.0, 0.0),
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            margin: EdgeInsets.only(left: 100.0),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(
                                    color: iconColor,
                                    style: BorderStyle.solid)),
                            child: CustomRowBar(
                              mainAxisDirection: MainAxisAlignment.end,
                              padding: EdgeInsets.all(7.0),
                              text: "See All",
                              color: iconColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 240.0,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                              padding: EdgeInsets.fromLTRB(50.0, 0.0, 0.0, 0.0),
                              child: Text("There are no Recommended products")),
                        ],
                      );
                    },
                    itemCount: 1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: Text(
                    "Top Category",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 90,
                          child: Card(
                            color: Colors.grey[200],
                            child: Row(
                              children: [
                                Expanded(
                                    child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("Powders"),
                                )),
                                Expanded(
                                    child: Image.asset("assets/empty.png")),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 90,
                          child: Card(
                            color: Colors.grey[200],
                            child: Row(
                              children: [
                                Expanded(
                                    child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("Pure\nOils"),
                                )),
                                Expanded(
                                    child: Image.asset("assets/empty.png")),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    "Featured Products",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          loading
              ? SliverList(
                  delegate: SliverChildListDelegate([
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Center(
                      child: Shimmer.fromColors(
                        child: CustomLoading(),
                        baseColor: Colors.pink,
                        highlightColor: Colors.white,
                        enabled: true,
                      ),
                    ),
                  )
                ]))
              : featuredProduct.isEmpty
                  ? SliverList(
                      delegate: SliverChildListDelegate([
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Center(
                          child: Text("There are no Featured Products."),
                        ),
                      )
                    ]))
                  : SliverGrid(
                      delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                        productAttributes =
                            ProductAttributes.fromMap(featuredProduct[index]);
                        return ProductCardForGrocon(
                            id: productAttributes.id,
                            imagePath: productAttributes.images,
                            title: productAttributes.name,
                            price: productAttributes.price,
                            onPressed: () {});
                      }, childCount: featuredProduct.length),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, childAspectRatio: 0.8)),
        ],
      ),
    );
  }
}

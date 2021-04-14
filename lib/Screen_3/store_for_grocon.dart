import 'package:ecommerceapp/ColorsForGrocon/colorsForGrocon.dart';
import 'package:ecommerceapp/Dart_lists/cart_list.dart';
import 'package:ecommerceapp/Dart_lists/products.dart';
import 'package:ecommerceapp/Screen_3/main_screen_3.dart';
import 'package:ecommerceapp/Screen_3/product_page_for_grocon.dart';
import 'package:ecommerceapp/custom_widgets/customLoadingWidget.dart';
import 'package:ecommerceapp/custom_widgets/custom_productCardForGrocon.dart';
import 'package:ecommerceapp/models/product_model_attributes.dart';
import 'package:ecommerceapp/providerLength.dart';
import 'package:ecommerceapp/services/product_services.dart';
import 'package:ecommerceapp/sharedPreferencesFile.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'cart_page_for_grocon.dart';

class StoreGrocon extends StatefulWidget {
  @override
  _StoreGroconState createState() => _StoreGroconState();
}

class _StoreGroconState extends State<StoreGrocon> {
  CartForGrocon cartForGrocon = CartForGrocon();
  getCartLength() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    myCartLength = await sharedPref.getInt("length");
    List length3 = [];
    length3 = await sharedPref.getStringList("cartids");
    setState(() {
      MainScreen.cartlength = length3.length;
    });
  }

  MainScreen mainScreen = MainScreen();
  var cartUpdate;
  bool found = false;
  ProductAttributes productAttributes = ProductAttributes();
  var result;
  Products productlist = Products();
  bool loading = true;
  List productList = [];
  List productListForDraft = [];
  List productImages = [];
  List<String> sharedPrefList = [];
  ProductService productService = ProductService();
  var myCartLength = 0;

  getApi() async {
    productListForDraft = await productService.getAllProducts();
    for (int i = 0; i < productListForDraft.length; i++) {
      productList.add(productListForDraft[i]);
    }
    setState(() {
      loading = false;
    });
    for (int i = 0; i < productList.length; i++) {
      sharedPrefList.add(productList[i]["id"].toString());
    }
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setStringList("cartlist2", sharedPrefList);
    var value = await sharedPreferences.getStringList("cartlist2");
    print(value);
    cartForGrocon.sharedPrefgetIds(totalProducts: productList);
  }

  @override
  void initState() {
    getApi();
    MainScreen.val = CartList.cartlist.length;
    getCartLength();
    super.initState();
  }

  bool addProducts(Map product) {
    productAttributes = ProductAttributes.fromMap(product);
    if (CartList.cartlist.isEmpty) {
      CartList.cartlist.add(productAttributes);
      Fluttertoast.showToast(
          msg: "Product Added to the cart", gravity: ToastGravity.BOTTOM);
    } else {
      for (int i = 0; i < CartList.cartlist.length; i++) {
        if (CartList.cartlist[i].id == productAttributes.id) {
          Fluttertoast.showToast(
              msg: "Product Already Exists", gravity: ToastGravity.BOTTOM);
        } else {
          CartList.cartlist.add(productAttributes);
          Fluttertoast.showToast(
              msg: "Product Added to the cart", gravity: ToastGravity.BOTTOM);
        }
      }
    }
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
                                listofProducts: productList,
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
//                result = await Navigator.push(
//                    context,
//                    PageRouteBuilder(
//                        transitionDuration: Duration(milliseconds: 600),
//                        transitionsBuilder: (BuildContext context,
//                            Animation<double> animation,
//                            Animation<double> secAnimation,
//                            Widget child) {
//                          secAnimation = CurvedAnimation(
//                              parent: animation, curve: Curves.bounceOut);
//                          animation = CurvedAnimation(
//                              parent: animation, curve: Curves.easeInCirc);
//                          return ScaleTransition(
//                              scale: secAnimation,
//                              alignment: Alignment.bottomRight,
//                              child: child);
//                        },
//                        pageBuilder: (BuildContext context,
//                                Animation<double> animation,
//                                Animation<double> secAnimation) =>
//                            CartForGrocon(
//                              listofProducts: productList,
//                            )));
//                print("Shopping Cart");
//                setState(() {
//                  MainScreen.val = result;
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
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerboxScrolled) {
          return <Widget>[
            SliverAppBar(
              leading: Icon(
                Icons.store,
                color: Colors.transparent,
              ),
              backgroundColor: appBarColor,
              expandedHeight: 180.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text(
                  "Store",
                  style: TextStyle(color: buttonColor),
                ),
                background: Image.asset("assets/logoforStore.jpg",
                    height: 10.0, width: 10.0),
              ),
            ),
          ];
        },
        body: loading
            ? Center(
                child: Shimmer.fromColors(
                    baseColor: Colors.pink,
                    highlightColor: Colors.white,
                    enabled: true,
                    child: CustomLoading()))
            : Container(
                height: MediaQuery.of(context).size.height,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 0.79),
                  itemBuilder: (BuildContext context, int index) {
                    print(found);
                    //TODO: Change price
                    productList[index]["price"] = "100";
                    var _indexes = productList[index]["id"];
                    return InkWell(onTap: () async {
                      productAttributes =
                          ProductAttributes.fromMap(productList[index]);
                      cartUpdate = await Navigator.push(
                        context,
                        PageRouteBuilder(
                          transitionDuration: Duration(milliseconds: 1000),
                          transitionsBuilder: (BuildContext context,
                              Animation<double> animation,
                              Animation<double> secanimation,
                              Widget child) {
                            animation = CurvedAnimation(
                                parent: animation, curve: Curves.bounceOut);
                            return ScaleTransition(
                              scale: animation,
                              child: child,
                              alignment: Alignment.center,
                            );
                          },
                          pageBuilder: (BuildContext context,
                                  Animation<double> animation,
                                  Animation<double> secanimation) =>
                              ProductPageGrocon(
                            productAttributes: productAttributes,
                            cartVal: MainScreen.val,
                          ),
                        ),
                      );
                      setState(() {
                        MainScreen.cartlength = cartUpdate;
                      });
                    }, child: Consumer<CartLength>(
                      builder: (context, cartLength, child) {
                        return ProductCardForGrocon(
                            id: productList[index]["id"],
                            imagePath: productList[index]["images"],
                            title: productList[index]["name"],
                            price: productList[index]["price"],
                            old_price: productList[index]["regular_price"],
                            onPressed: () async {
//                          addProducts(productList[index]);
                              if (CartList.cartlist.isEmpty) {
                                found = true;
                                int myprice =
                                    int.parse(productList[index]["price"]);
                                CartList.cartlist.add({
                                  "id": productList[index]["id"],
                                  "title": productList[index]["name"],
                                  "imagePath": productList[index]["images"],
                                  "price": myprice,
                                  "old_price": productList[index]
                                      ["regular_price"],
                                  "quantity": 1
                                });
                                setState(() {
                                  MainScreen.val = CartList.cartlist.length;
                                });
                                setState(() {
                                  MainScreen.cartlength =
                                      CartList.cartlist.length;
                                });
                                cartForGrocon.sharedPrefsetIds();
                                getCartLength();
                                mainScreen.setcartLength();
                              } else if (CartList.cartlist.isNotEmpty) {
                                found = false;
                                int id = productList[index]["id"];
                                print(CartList.cartlist.length);
                                for (int i = 0;
                                    i < CartList.cartlist.length;
                                    i++) {
                                  print(found);
                                  print(CartList.cartlist[i]["id"]);
                                  if (CartList.cartlist[i]["id"] == id) {
                                    found = true;
                                    print("Already Exists");
                                    Fluttertoast.showToast(
                                        msg: "Already Exists",
                                        gravity: ToastGravity.CENTER);
                                  }
                                }
                              }
                              if (!found) {
                                int myprice =
                                    int.parse(productList[index]["price"]);
                                CartList.cartlist.add({
                                  "id": productList[index]["id"],
                                  "title": productList[index]["name"],
                                  "imagePath": productList[index]["images"],
                                  "price": myprice,
                                  "old_price": productList[index]
                                      ["regular_price"],
                                  "quantity": 1
                                });
                                setState(() {
                                  MainScreen.val = CartList.cartlist.length;
//                              MainScreen.val = cartUpdate;
                                });
                                cartForGrocon.sharedPrefsetIds();
                                getCartLength();
                                mainScreen.setcartLength();
                                setState(() {});
                              }
                            });
                      },
                    ));
                  },
                  itemCount: productList.length,
                ),
              ),
      ),
    );
  }
}

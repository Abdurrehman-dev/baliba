import 'package:ecommerceapp/ColorsForGrocon/colorsForGrocon.dart';
import 'package:ecommerceapp/Dart_lists/category_list_for_grocon.dart';
import 'package:ecommerceapp/Screen_3/productOfCateories.dart';
import 'package:ecommerceapp/custom_widgets/customLoadingWidget.dart';
import 'package:ecommerceapp/models/Product_category_model_attributes.dart';
import 'package:ecommerceapp/services/product_services.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shimmer/shimmer.dart';

import 'cart_page_for_grocon.dart';
import 'main_screen_3.dart';

class CategoryScreen extends StatefulWidget {
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  ProductCategories productCategories = ProductCategories();
  CategoryForGrocon categoryForGrocon = CategoryForGrocon();
  bool loading = true;
  List categoriesList = [];
  List allProducts = [];
  ProductService productService = ProductService();
  getApi() async {
    categoriesList = await productService.getAllProductCategories();
    allProducts = await productService.getAllProducts();
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    getApi();
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
      body: loading
          ? Center(
              child: Shimmer.fromColors(
                  baseColor: Colors.pink,
                  highlightColor: Colors.white,
                  enabled: true,
                  child: CustomLoading()))
          : Container(
              height: MediaQuery.of(context).size.height,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4, childAspectRatio: 0.7),
                  itemBuilder: (BuildContext context, int index) {
                    productCategories =
                        ProductCategories.fromMap(categoriesList[index]);
                    return Scaffold(
                      body: Center(
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                        pageBuilder: (BuildContext context,
                                                Animation<double> animation,
                                                Animation<double>
                                                    secAnimation) =>
                                            ProductOfCategories(
                                              productsList: allProducts,
                                              CategoryID: categoriesList[index]
                                                  ["id"],
                                              name: categoriesList[index]
                                                  ["name"],
                                            )));
                              },
                              child: Card(
                                color: Color(0xF2F2F2F2),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: productCategories.image == null
                                      ? Image.asset("assets/empty.png")
                                      : Image.network(
                                          productCategories.image[0]["src"],
                                          height: 70.0,
                                        ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Text(
                                productCategories.name,
                                style: TextStyle(fontSize: 13.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: categoriesList.length,
                ),
              ),
            ),
    );
  }
}

import 'package:ecommerceapp/ColorsForGrocon/colorsForGrocon.dart';
import 'package:ecommerceapp/Dart_lists/cart_list.dart';
import 'package:ecommerceapp/Screen_3/main_screen_3.dart';
import 'package:ecommerceapp/Screen_3/product_page_for_grocon.dart';
import 'package:ecommerceapp/custom_widgets/custom_productCardForGrocon.dart';
import 'package:ecommerceapp/models/product_model_attributes.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProductOfCategories extends StatefulWidget {
  ProductOfCategories({this.productsList, this.CategoryID, this.name});
  List productsList;
  int CategoryID;
  String name;
  List allCategoryProducts = [];
  @override
  _ProductOfCategoriesState createState() => _ProductOfCategoriesState();
}

class _ProductOfCategoriesState extends State<ProductOfCategories> {
  ProductAttributes productAttributes = ProductAttributes();
  List categories = [];

  bool found = false;
  getCategoryProducts() {
    for (int i = 0; i < widget.productsList.length; i++) {
      categories = widget.productsList[i]["categories"];
      for (int j = 0; j < categories.length; j++) {
        print(widget.productsList[i]["categories"][j]["id"]);
        print(widget.CategoryID);
        print(widget.productsList.length);
        if (widget.CategoryID ==
            widget.productsList[i]["categories"][j]["id"]) {
          widget.allCategoryProducts.add(widget.productsList[i]);
        }
      }
    }
  }

  @override
  void initState() {
    getCategoryProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          widget.name,
          style: TextStyle(color: appBarTextColor),
        ),
        centerTitle: true,
        backgroundColor: appBarColor,
      ),
      body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, childAspectRatio: 0.8),
          itemBuilder: (BuildContext context, int index) {
            //TODO: change price
            widget.allCategoryProducts[index]["price"] = "100";

            return InkWell(
              onTap: () {
                productAttributes = ProductAttributes.fromMap(
                    widget.allCategoryProducts[index]);
                print("index is: " + "$index");
                Navigator.push(
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
                                Animation<double> secAnimation) =>
                            ProductPageGrocon(
                              productAttributes: productAttributes,
                              cartVal: MainScreen.val,
                            )));
              },
              child: ProductCardForGrocon(
                  title: widget.allCategoryProducts[index]["name"],
                  price: widget.allCategoryProducts[index]["price"],
                  id: widget.allCategoryProducts[index]["id"],
                  imagePath: widget.allCategoryProducts[index]["images"],
                  onPressed: () {
                    if (CartList.cartlist.isEmpty) {
                      found = true;
                      CartList.cartlist.add({
                        "id": widget.allCategoryProducts[index]["id"],
                        "title": widget.allCategoryProducts[index]["name"],
                        "imagePath": widget.allCategoryProducts[index]
                            ["images"],
                        "price": widget.allCategoryProducts[index]["price"],
                        "old_price": widget.allCategoryProducts[index]
                            ["regular_price"],
                      });
                      setState(() {
                        MainScreen.val = CartList.cartlist.length;
//                              MainScreen.val = cartUpdate;
                        MainScreen3.cartTotal += int.parse(
                            widget.allCategoryProducts[index]["price"]);
                        print(
                            "Total in cart" + MainScreen3.cartTotal.toString());
                      });
                    } else if (CartList.cartlist.isNotEmpty) {
                      found = false;
                      int id = widget.allCategoryProducts[index]["id"];
                      print(CartList.cartlist.length);
                      for (int i = 0; i < CartList.cartlist.length; i++) {
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
                      CartList.cartlist.add({
                        "id": widget.allCategoryProducts[index]["id"],
                        "title": widget.allCategoryProducts[index]["name"],
                        "imagePath": widget.allCategoryProducts[index]
                            ["images"],
                        "price": widget.allCategoryProducts[index]["price"],
                        "old_price": widget.allCategoryProducts[index]
                            ["regular_price"],
                      });
                      setState(() {
                        MainScreen.val = CartList.cartlist.length;
//                              MainScreen.val = cartUpdate;
                        MainScreen3.cartTotal += int.parse(
                            widget.allCategoryProducts[index]["price"]);
                        print(
                            "Total in cart" + MainScreen3.cartTotal.toString());
                      });
                      print(MainScreen3().cartUpdate);
                      setState(() {});
                    }
                  }),
            );
          },
          itemCount: widget.allCategoryProducts.length),
    );
  }
}

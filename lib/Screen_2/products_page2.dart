import 'package:ecommerceapp/Dart_lists/cart_list.dart';
import 'package:ecommerceapp/Screen_1/product_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ecommerceapp/Dart_lists/products.dart';
import 'package:ecommerceapp/custom_widgets/custom_productCard.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProductsPage2 extends StatefulWidget {
  @override
  _ProductsPage2State createState() => _ProductsPage2State();
}

class _ProductsPage2State extends State<ProductsPage2> {
  Products products = Products();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.add),
        elevation: 0.0,
        title: Text(
          "PRODUCTS",
          style: TextStyle(color: Colors.deepOrange),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: CustomScrollView(
        slivers: [
          SliverGrid(
              delegate:
                  SliverChildBuilderDelegate((BuildContext context, int index) {
                return Container(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductPage(
                            price: products.product_list[index]["price"],
                            old_price: products.product_list[index]
                                ["old_price"],
                            image: products.product_list[index]["images"],
                            name: products.product_list[index]["title"],
                            description: products.product_list[index]
                                ["description"],
                          ),
                        ),
                      );
                    },
                    child: CustomProductCard(
                      onTap: () {
                        Fluttertoast.showToast(
                            msg: "Added to cart",
                            textColor: Colors.white,
                            backgroundColor: Colors.orange,
                            gravity: ToastGravity.CENTER);
                        CartList.cartlist.add({
                          "name": products.product_list[index]["title"],
                          "image": products.product_list[index]["images"],
                          "price": products.product_list[index]["price"],
                          "old_price": products.product_list[index]
                              ["old_price"],
                        });
                        setState(() {
                          print(CartList.cartlist);
                        });
                      },
                      imagePath: products.product_list[index]["images"][0],
                      title: products.product_list[index]["title"],
                      price: products.product_list[index]["price"],
                      old_price: products.product_list[index]["old_price"],
                    ),
                  ),
                );
              }, childCount: products.product_list.length),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 0.7)),
        ],
      ),
    );
  }
}

// CustomProductCard(
// imagePath: products.product_list[0]["images"][0],
// title: products.product_list[0]["title"],
// price: products.product_list[0]["price"],
// old_price: products.product_list[0]["old_price"],
// );

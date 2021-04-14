import 'file:///F:/flutter_apps/Office_work/ecommerceapp/lib/Screen_1/product_page.dart';
import 'package:ecommerceapp/Dart_lists/products.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import '../Dart_lists/category_list2.dart';
//my imports

import '../Dart_lists/category_list.dart';

//creating Product class Object
Products products = Products();
//creating Category class Object
Category2 category = Category2();

class AppBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //we use only one container as a parent with no height and width
    return Container(
      //we use costumeScrollView instead of listView and use slivers SliverList and SliverGrid to achieve this task.
      child: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            //SliverChildDelegate use list of widgets
            delegate: SliverChildListDelegate(
              [
                SizedBox(
                  height: 150.0,
                  child: Carousel(
                    autoplay: false,
                    indicatorBgPadding: 5.0,
                    dotSize: 5.0,
                    dotColor: Colors.orange,
                    dotBgColor: Colors.transparent,
                    images: [
                      Image.asset("assets/pic1.jpg", fit: BoxFit.cover),
                      Image.asset("assets/pic2.jpg", fit: BoxFit.cover),
                      Image.asset("assets/pic3.jpg", fit: BoxFit.cover),
                    ],
                  ),
                ),
                Container(
                  height: 100.0,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        width: 90.0,
                        child: Card(
                          child: Padding(
                            padding: EdgeInsets.only(top: 10.0),
                            child: Column(
                              children: <Widget>[
                                Expanded(
                                    child: category.category2_list[index]
                                        ["icon"]),
                                Expanded(
                                    child: Text(
                                        category.category2_list[index]["title"],
                                        textAlign: TextAlign.center))
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: category.category2_list.length,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
              ],
            ),
          ),
          //SliverGrid
          SliverGrid(
            delegate:
                //we use SLiverChildBuilderDelegate instead of SliverChildListDelegate because we need context and also index for product list.
                SliverChildBuilderDelegate((BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductPage(
                        price: products.product_list[index]["price"],
                        old_price: products.product_list[index]["old_price"],
                        image: products.product_list[index]["images"],
                        name: products.product_list[index]["title"],
                        description: products.product_list[index]
                            ["description"],
                      ),
                    ),
                  );
                },
                child: Card(
                  elevation: 3.8,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        flex: 9,
                        //adding carousel in products view.
                        // child: products.product_list[index]["images"][0],
                        child: Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: Carousel(
                            dotBgColor: Colors.transparent,
                            dotSize: 2.0,
                            indicatorBgPadding: 10.0,
                            dotColor: Colors.orange,
                            images: [
                              Image.asset(
                                  products.product_list[index]["images"][0]),
                              Image.asset(
                                  products.product_list[index]["images"][1]),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 3.0),
                        child: Text(
                          products.product_list[index]["title"],
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      // Text(
                      //   products.product_list[index]["description"],
                      //   overflow: TextOverflow.ellipsis,
                      // ),
                      Expanded(
                          flex: 2,
                          child: Padding(
                            padding:
                                const EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 3.0),
                            child: Text(
                                "Price: " +
                                    products.product_list[index]["price"] +
                                    " Rs",
                                style: TextStyle(
                                    color: Colors.orange,
                                    fontWeight: FontWeight.bold)),
                          )),
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 3.0),
                          child: Text(
                            products.product_list[index]["old_price"] + " Rs",
                            style: TextStyle(
                                decoration: TextDecoration.lineThrough),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }, childCount: products.product_list.length),
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          ),
        ],
      ),
    );
  }
}

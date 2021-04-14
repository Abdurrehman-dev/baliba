import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:ecommerceapp/Screen_3/main_screen_3.dart';

class ProductService {
  static String PRODUCT_LIST = SERVER + "products" + SERVER_KEY;
  static String CATEGORIES_LIST = SERVER + "products/categories" + SERVER_KEY;

  Future<dynamic> getAllProducts() async {
    List<dynamic> productsList = [];
    var header = {
      "Content-Type": "application/json",
    };

    Response response = await get(PRODUCT_LIST, headers: header);
//        .timeout(Duration(milliseconds: 1000), onTimeout: () {
//      return null;
//    });

    var responseBody = jsonDecode(response.body);
    if (response.statusCode == 200) {
      productsList = responseBody;
//      var testList = responseBody["data"];
//      if (response.body == null) {
//        productsList[0] = Center(child: Text("API Not Working"));
//        return productsList[0];
//      }
      return productsList;
    } else {
      String responseMsg = responseBody["message"];
      Fluttertoast.showToast(msg: "$responseMsg");
      return [];
    }
  }

  Future<dynamic> getAllProductCategories() async {
    List<dynamic> categoryList = [];
    var header = {
      "Content-Type": "application/json",
    };
    Response response = await get(CATEGORIES_LIST, headers: header);
    var responseBody = jsonDecode(response.body);
    if (response.statusCode == 200) {
      categoryList = responseBody;
      return categoryList;
    } else {
      String responseMsg = responseBody["message"];
      Fluttertoast.showToast(msg: "$responseMsg");
      return [];
    }
  }
}

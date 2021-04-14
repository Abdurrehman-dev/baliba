import 'dart:convert';
import 'package:ecommerceapp/Screen_3/billing_details.dart';
import 'package:ecommerceapp/Screen_3/check_out_page.dart';
import 'package:ecommerceapp/Screen_3/main_screen_3.dart';
import 'package:ecommerceapp/Screen_3/shipping_details.dart';
import 'package:ecommerceapp/models/User_model_attributes.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';

class CreateOrder {
  static String ORDERS = SERVER + "orders" + SERVER_KEY;

  Future createOrder({billing, shipping, line_item}) async {
    var body = jsonEncode({
      "billing": billing,
      "shipping": shipping,
      "line_items": line_item,
    });
    var header = {"Content-Type": "application/json"};
    Response response = await post(ORDERS, body: body, headers: header);
    var responseBody = jsonDecode(response.body);
    if (response.statusCode == 201) {
      user = User.fromMap(responseBody);
      return true;
    } else {
      Fluttertoast.showToast(
          msg: responseBody["message"], toastLength: Toast.LENGTH_LONG);
      return false;
    }
  }
}

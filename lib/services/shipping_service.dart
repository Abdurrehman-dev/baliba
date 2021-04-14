import 'dart:convert';

import 'package:ecommerceapp/Screen_3/main_screen_3.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';

class ShippingService {
  static String SHIPPING = SERVER + "shipping/zones/1/methods" + SERVER_KEY;

  Future getShippingProperties() async {
    List shipping = [];
    var header = {
      "Content-Type": "application/json",
    };
    Response response = await get(SHIPPING, headers: header);
    var responseBody = jsonDecode(response.body);
    if (response.statusCode == 200) {
      shipping = responseBody;
      return shipping;
    } else {
      String msg = responseBody["message"];
      Fluttertoast.showToast(msg: msg);
    }
  }
}

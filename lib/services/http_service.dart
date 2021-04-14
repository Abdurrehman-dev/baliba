import 'dart:convert';

import 'package:ecommerceapp/Screen_3/main_screen_3.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:ecommerceapp/models/User_model_attributes.dart';

class HttpService {
  static String CUSTOMERS = SERVER + "customers" + SERVER_KEY;
  List Users = [];

  Future<dynamic> register(first_name, last_name, email) async {
    var body = jsonEncode(
        {"email": email, "first_name": first_name, "last_name": last_name});
    var header = {"Content-Type": "application/json"};
    Response response = await post(CUSTOMERS, body: body, headers: header);
    var responseBody = jsonDecode(response.body);
    if (response.statusCode == 201) {
      user = User.fromMap(responseBody);
      return true;
    } else {
      Fluttertoast.showToast(
          msg: responseBody["message"], toastLength: Toast.LENGTH_LONG);
    }
  }

  Future<dynamic> login({email}) async {
    var params = {"email": email};
    Uri uri = Uri.parse(CUSTOMERS);
    var url = CUSTOMERS;
//    final newUri = uri.replace(queryParameters: params);
//    var body = jsonEncode(({"email": email}));
    var header = {"Content-Type": "application/json"};
    Response response = await get(url, headers: header);
    var responseBody1 = jsonDecode(response.body);
    if (response.statusCode == 200) {
      Users = responseBody1;
      return Users;
    } else {
      Fluttertoast.showToast(
          msg: responseBody1["message"], toastLength: Toast.LENGTH_LONG);
    }
  }
}

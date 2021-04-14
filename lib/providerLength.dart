import 'package:ecommerceapp/Screen_3/main_screen_3.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartLength extends ChangeNotifier {
  getLength() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    List cartLength = [];
    cartLength = await sharedPref.getStringList("cartids");
    MainScreen.cartlength = cartLength.length;
    notifyListeners();
  }
}

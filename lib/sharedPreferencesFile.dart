import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefernce {
  var name, email, password, address, postCode;
  Future getName() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    name = await sharedPref.getString("username");
    return name;
  }

  Future getEmail() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    email = await sharedPref.getString("useremail");
    return email;
  }

  Future getPassword() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    password = await sharedPref.getString("userPass");
    return password;
  }

  Future getAddress() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    address = await sharedPref.getString("address1");
    return address;
  }

  Future getPostCode() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    postCode = await sharedPref.getString("phone");
    return postCode;
  }
}

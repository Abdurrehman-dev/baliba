import 'dart:io';
import 'package:ecommerceapp/ColorsForGrocon/colorsForGrocon.dart';
import 'package:ecommerceapp/Screen_3/LoginPageForGrocon.dart';
import 'package:ecommerceapp/Screen_3/billing_details.dart';
import 'package:ecommerceapp/Screen_3/main_screen_3.dart';
import 'package:ecommerceapp/custom_widgets/customFieldsForCheckOutGrocon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfileForGrocon extends StatefulWidget {
  static String emailId = "";
  static String password = "";
  static String name = "";
  static String postCode = "";
  static String address = "";
  static String image = "";

  @override
  _UserProfileForGroconState createState() => _UserProfileForGroconState();
}

class _UserProfileForGroconState extends State<UserProfileForGrocon> {
//  File _image;
//  _setPickture() async {
//    SharedPreferences shared = await SharedPreferences.getInstance();
//    final images = ImagePicker();
//    var Image = await images.getImage(source: ImageSource.gallery);
//
//    setState(() {
//      _image = File(Image.path);
//    });
//    await shared.setString("profilePic", Image.path);
//    print("");
//  }
//
//  _getPicture() async {
//    SharedPreferences shared = await SharedPreferences.getInstance();
//    var Image = await shared.getString("profilePic") ?? "";
//    if (Image == "") {
//      _image = null;
//    } else {
//      _image = File(Image);
//    }
//    print("");
//  }

  @override
  void initState() {
//    _getPicture();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
          style: TextStyle(color: buttonTextColor),
        ),
        centerTitle: true,
        backgroundColor: buttonColor,
      ),
      backgroundColor: scaffoldBackgroundColor,
      body: Container(
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(blurRadius: 1.5, spreadRadius: 1.0, color: Colors.grey)
        ]),
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Divider(color: Colors.transparent),
              CustomFieldsForCheckOut(
                  title: "Name: " + UserProfileForGrocon.name),
              CustomFieldsForCheckOut(
                  title: "Email: " + UserProfileForGrocon.emailId),
              CustomFieldsForCheckOut(
                  title: "Address: " + UserProfileForGrocon.address),
              CustomFieldsForCheckOut(
                  title: "Phone no: " + UserProfileForGrocon.postCode),
              UserProfileForGrocon.emailId == ""
                  ? FlatButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPageForGrocon()));
                      },
                      child: Text("SignIn"),
                      color: productButtonColor,
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FlatButton(
                          onPressed: () async {
                            SharedPreferences sharedPref =
                                await SharedPreferences.getInstance();
                            await sharedPref.remove("username");
                            await sharedPref.remove("useremail");
                            await sharedPref.remove("phone");
                            await sharedPref.remove("address1");
                            await sharedPref.remove("profilePic");
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MainScreen()));
                          },
                          child: Text("Logout"),
                          color: productButtonColor,
                          textColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0)),
                        ),
                        VerticalDivider(width: 10.0),
                        FlatButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BillingDetails()));
                          },
                          child: Text("Update"),
                          color: productButtonColor,
                          textColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0)),
                        )
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }

  _getUserName() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    var value = sharedPref.get("email");
    return value;
  }
}

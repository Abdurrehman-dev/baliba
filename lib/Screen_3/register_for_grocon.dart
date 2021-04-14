import 'package:ecommerceapp/ColorsForGrocon/colorsForGrocon.dart';
import 'package:ecommerceapp/Screen_3/LoginPageForGrocon.dart';
import 'package:ecommerceapp/Screen_3/check_out_page.dart';
import 'package:ecommerceapp/Screen_3/main_screen_3.dart';
import 'package:ecommerceapp/custom_widgets/customTextFieldsForRegister.dart';
import 'package:ecommerceapp/services/http_service.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

class RegisterForGrocon extends StatefulWidget {
  @override
  _RegisterForGroconState createState() => _RegisterForGroconState();
}

class _RegisterForGroconState extends State<RegisterForGrocon>
    with SingleTickerProviderStateMixin {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  HttpService httpService = HttpService();

  var secNameController = TextEditingController();
  TabController controller;
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    controller = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      appBar: AppBar(
        leading: Icon(
          Icons.arrow_back_ios,
          color: Colors.transparent,
        ),
        title: Text(
          "Register",
          style: TextStyle(color: appBarTextColor),
        ),
        centerTitle: true,
        backgroundColor: appBarColor,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Shimmer.fromColors(
                baseColor: Colors.pink,
                highlightColor: Colors.white,
                child: Image.asset(
                  "assets/loadingLogo.png",
                  height: 150.0,
                  width: 150.0,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(blurRadius: 2.0, color: Colors.grey),
                  ],
                ),
                width: 300.0,
                height: 390.0,
                child: Column(
                  children: <Widget>[
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          TextFieldForRegister(
                            validator: "Please Enter Name",
                            hintText: "Enter First Name",
                            prefixIcon: Icon(
                              Icons.drive_file_rename_outline,
                              color: Colors.black,
                            ),
                            controller: nameController,
                          ),
                          TextFieldForRegister(
                            validator: "Please Enter Last Name",
                            hintText: "Enter Last Name",
                            prefixIcon: Icon(
                              Icons.drive_file_rename_outline,
                              color: Colors.black,
                            ),
                            controller: secNameController,
                          ),
                          TextFieldForRegister(
                            validator: "Please Enter Email",
                            hintText: "Enter Email",
                            prefixIcon: Icon(
                              Icons.email,
                              color: Colors.black,
                            ),
                            controller: emailController,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(19.0),
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                        onPressed: () async {
                          if (formKey.currentState.validate()) {
                            if (nameController.text == "" &&
                                emailController.text == "") {
                              return Fluttertoast.showToast(
                                  msg: "Please fill All Fields",
                                  backgroundColor: toastColor,
                                  textColor: toastTextColor,
                                  gravity: ToastGravity.BOTTOM,
                                  toastLength: Toast.LENGTH_SHORT);
                            }

                            bool response = await httpService.register(
                                nameController.text,
                                secNameController.text,
                                emailController.text);
                            if (response) {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MainScreen()));
                              Fluttertoast.showToast(
                                  msg: "Register Successful");
                            }
                          }
                        },
                        child: Text("Register"),
                        color: productButtonColor,
                        textColor: Colors.white,
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already a user"),
                        InkWell(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        LoginPageForGrocon()));
                          },
                          child: Text(
                            " SignIn ",
                            style: TextStyle(
                                color: buttonColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text("here!")
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

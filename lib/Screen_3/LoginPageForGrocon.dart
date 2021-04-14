import 'package:ecommerceapp/ColorsForGrocon/colorsForGrocon.dart';
import 'package:ecommerceapp/Dart_lists/cart_list.dart';
import 'package:ecommerceapp/Screen_3/cart_page_for_grocon.dart';
import 'package:ecommerceapp/Screen_3/check_out_page.dart';
import 'package:ecommerceapp/Screen_3/main_screen_3.dart';
import 'package:ecommerceapp/Screen_3/register_for_grocon.dart';
import 'package:ecommerceapp/services/http_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

class LoginPageForGrocon extends StatefulWidget {
  @override
  _LoginPageForGroconState createState() => _LoginPageForGroconState();
}

class _LoginPageForGroconState extends State<LoginPageForGrocon>
    with SingleTickerProviderStateMixin {
  HttpService httpService = HttpService();
  AnimationController animationController;
  double value = 0.0;
  bool loading = false;
  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );
    super.initState();
    animationController.repeat(reverse: true);
    animationController.addListener(() {
      setState(() {
        value = animationController.value;
      });
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  List usersList = [];
  Map newUser = {};
  String useremail;
  var email, password;
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context, CartList.cartlist.length);
      },
      child: Scaffold(
        backgroundColor: scaffoldBackgroundColor,
        appBar: AppBar(
          leading: Icon(
            Icons.arrow_back_ios,
            color: Colors.transparent,
          ),
          backgroundColor: appBarColor,
          title: Text(
            "Login",
            style: TextStyle(color: appBarTextColor),
          ),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Transform.rotate(
                angle: 0.0, //value - 0.5,
                child: Shimmer.fromColors(
                  baseColor: Colors.pink,
                  highlightColor: Colors.white,
                  child: Image.asset(
                    "assets/loadingLogo.png",
                    height: 150.0,
                    width: 150.0,
                  ),
                ),
              ),
              Center(
                child: Container(
                  height: 250.0,
                  width: 300.0,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey,
                            blurRadius: 1.0,
                            spreadRadius: 2.0)
                      ]),
                  child: Column(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 0.0),
                        child: Form(
                          key: formKey,
                          child: TextFormField(
                            validator: (val) {
                              if (val.isEmpty) {
                                return "Please Enter Email";
                              } else if (!val.contains("@") ||
                                  !val.contains(".")) {
                                return "Please Enter valid Email";
                              }
                            },
                            cursorColor: Colors.black,
                            controller: emailController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      style: BorderStyle.solid,
                                      color: Colors.black),
                                  borderRadius: BorderRadius.circular(15.0)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      style: BorderStyle.solid,
                                      color: Colors.pink,
                                      width: 2.5),
                                  borderRadius: BorderRadius.circular(15.0)),
                              hintText: "Enter Email",
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: loading
                                ? Center(child: CircularProgressIndicator())
                                : FlatButton(
                                    onPressed: () async {
                                      SharedPreferences shared =
                                          await SharedPreferences.getInstance();
                                      if (formKey.currentState.validate()) {
                                        setState(() {
                                          loading = true;
                                        });

                                        usersList = await httpService.login(
                                            email: emailController.text);
                                        for (int i = 0;
                                            i < usersList.length;
                                            i++) {
                                          if (emailController.text ==
                                              usersList[i]["email"]) {
                                            newUser = usersList[i];
                                            shared.setString(
                                                "useremail", newUser["email"]);
                                            shared.setString("username",
                                                newUser["username"]);
                                            print("email " + newUser["email"]);
                                            print("username " +
                                                newUser["username"]);
                                          }
                                        }
                                        setState(() {
                                          loading = false;
                                        });

                                        if (newUser.isNotEmpty) {
//                                    loading = false;
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      MainScreen()));
                                          Fluttertoast.showToast(
                                              msg: "Login Successful");
                                        } else {
                                          Fluttertoast.showToast(
                                              msg: "Email Not Found");
                                          setState(() {
                                            loading = false;
                                          });
                                        }
                                      }
                                    },
                                    child: Text("Login"),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0)),
                                    color: buttonColor,
                                    textColor: Colors.white),
                          ),
                          Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: FlatButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MainScreen()));
                                },
                                child: Text("Guest"),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0)),
                                color: productButtonColor,
                                textColor: Colors.white,
                              )),
                        ],
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("Not a User"),
                            InkWell(
                              onTap: () {
                                print("signUp");
                              },
                              child: InkWell(
                                onTap: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => RegisterForGrocon(),
                                    ),
                                  );
                                },
                                child: Text(
                                  " SignUp ",
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: productButtonColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Text("here!")
                          ])
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future setUserEmail() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    sharedPref.setString("email", emailController.text);
  }

  Future setUserPassword() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    sharedPref.setString("password", passwordController.text);
  }
}

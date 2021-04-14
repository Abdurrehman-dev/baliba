import 'package:ecommerceapp/ColorsForGrocon/colorsForGrocon.dart';
import 'package:ecommerceapp/Screen_1/checkout_page.dart';
import 'package:ecommerceapp/Screen_3/check_out_page.dart';
import 'package:ecommerceapp/custom_widgets/Custom_TextFieldForBillingGrocon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ecommerceapp/models/customer_billing_properties.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BillingDetails extends StatefulWidget {
  static Map mapvarforBilling = {};

  @override
  _BillingDetailsState createState() => _BillingDetailsState();
}

class _BillingDetailsState extends State<BillingDetails> {
  TextEditingController firstNameController = TextEditingController();

  TextEditingController lastNameController = TextEditingController();

  TextEditingController cityController = TextEditingController();

  TextEditingController address1Controller = TextEditingController();

  TextEditingController address2Controller = TextEditingController();

  TextEditingController stateController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  setFields() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    sharedPref.setString("first_name", firstNameController.text);
    sharedPref.setString("last_name", lastNameController.text);
    sharedPref.setString("city", cityController.text);
    sharedPref.setString("address1", address1Controller.text);
    sharedPref.setString("address2", address2Controller.text);
    sharedPref.setString("state", stateController.text);
    sharedPref.setString("email", emailController.text);
    sharedPref.setString("phone", phoneController.text);

    Fluttertoast.showToast(
        msg: "Fields Updated!", gravity: ToastGravity.CENTER);
  }

  getFields() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    firstNameController.text = await sharedPref.getString("first_name");
    lastNameController.text = await sharedPref.getString("last_name");
    cityController.text = await sharedPref.getString("city");
    address1Controller.text = await sharedPref.getString("address1");
    address2Controller.text = await sharedPref.getString("address2");
    stateController.text = await sharedPref.getString("state");
    emailController.text = await sharedPref.get("email");
    phoneController.text = await sharedPref.getString("phone");
  }

  @override
  void initState() {
    getFields();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios, color: Colors.black, size: 28.0)),
        title: Text(
          "Billing Details",
          style: TextStyle(color: appBarTextColor),
        ),
        centerTitle: true,
        backgroundColor: appBarColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
              child: Container(
                  height: 540,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey,
                            spreadRadius: 1.0,
                            blurRadius: 1.0)
                      ],
                      borderRadius: BorderRadius.circular(20.0)),
                  child: Column(
                    children: <Widget>[
                      CustomTextFieldForBilling(
                        controller: firstNameController,
                        icon: Icon(
                          Icons.account_box_outlined,
                          color: Colors.black,
                        ),
                        hintText: "First Name",
                      ),
                      CustomTextFieldForBilling(
                        controller: lastNameController,
                        icon: Icon(
                          Icons.account_box_outlined,
                          color: Colors.black,
                        ),
                        hintText: "Last Name",
                      ),
                      CustomTextFieldForBilling(
                        controller: emailController,
                        icon: Icon(
                          Icons.email,
                          color: Colors.black,
                        ),
                        hintText: "Email address",
                      ),
                      CustomTextFieldForBilling(
                        controller: phoneController,
                        icon: Icon(
                          Icons.phone,
                          color: Colors.black,
                        ),
                        hintText: "Mobile No.",
                      ),
                      CustomTextFieldForBilling(
                        controller: cityController,
                        icon: Icon(
                          Icons.location_city,
                          color: Colors.black,
                        ),
                        hintText: "City/Town",
                      ),
                      CustomTextFieldForBilling(
                        controller: address1Controller,
                        icon: Icon(
                          Icons.location_on,
                          color: Colors.black,
                        ),
                        hintText: "Street Address",
                      ),
                      CustomTextFieldForBilling(
                        controller: address2Controller,
                        icon: Icon(
                          Icons.location_on,
                          color: Colors.black,
                        ),
                        hintText: "Near by Location",
                      ),
                      CustomTextFieldForBilling(
                        controller: stateController,
                        icon: Icon(
                          Icons.account_balance_sharp,
                          color: Colors.black,
                        ),
                        hintText: "State/Country",
                      ),
                    ],
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FlatButton(
                onPressed: () async {
                  print(BillingDetails.mapvarforBilling);
                  if (firstNameController.text == "" ||
                      lastNameController.text == "" ||
                      emailController.text == "" ||
                      phoneController.text == "" ||
                      cityController.text == "" ||
                      address1Controller.text == "" ||
                      address2Controller.text == "" ||
                      stateController.text == "") {
                    Fluttertoast.showToast(
                        msg: "Some Fields are missing",
                        gravity: ToastGravity.CENTER);
                  } else {
                    await setFields();
                    BillingDetails.mapvarforBilling = BillingProperties(
                      first_name: firstNameController.text,
                      last_name: lastNameController.text,
                      email: emailController.text,
                      phone: phoneController.text,
                      city: cityController.text,
                      address_1: address1Controller.text,
                      address_2: address2Controller.text,
                      state: stateController.text,
                    ).toMap();
                    Navigator.pop(context);
                  }
                },
                child: Text("Proceed"),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                color: productButtonColor,
                textColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

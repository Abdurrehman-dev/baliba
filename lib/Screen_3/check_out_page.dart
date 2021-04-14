import 'package:ecommerceapp/ColorsForGrocon/colorsForGrocon.dart';
import 'package:ecommerceapp/Screen_3/billing_details.dart';
import 'package:ecommerceapp/Screen_3/pay_screen.dart';
import 'package:ecommerceapp/Screen_3/shipping_details.dart';
import 'package:ecommerceapp/custom_widgets/customFieldsForCheckOutGrocon.dart';
import 'package:ecommerceapp/models/customer_billing_properties.dart';
import 'package:ecommerceapp/services/createOrder_service.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckOutPage extends StatefulWidget {
  static List line_item = [];
  @override
  _CheckOutPageState createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  getbillingDetails() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    BillingDetails.mapvarforBilling = BillingProperties(
      first_name: await sharedPref.getString("first_name"),
      last_name: await sharedPref.getString("last_name"),
      email: await sharedPref.get("email"),
      phone: await sharedPref.getString("phone"),
      city: await sharedPref.getString("city"),
      address_1: await sharedPref.getString("address1"),
      address_2: await sharedPref.getString("address2"),
      state: await sharedPref.getString("state"),
    ).toMap();
  }

  bool loading = false;
  CreateOrder createorder = CreateOrder();
  var email;
  var password;
  @override
  void initState() {
    getbillingDetails();
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
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 30.0,
          ),
        ),
        backgroundColor: appBarColor,
        centerTitle: true,
        title: Text(
          "Check Out",
          style: TextStyle(color: appBarTextColor),
        ),
      ),
      body: Column(
        children: <Widget>[
          CustomFieldsForCheckOut(
              title: "Billing Details",
              icon: Icon(
                Icons.add,
                size: 26.0,
              ),
              onpressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => BillingDetails()));
              }),
          CustomFieldsForCheckOut(
              title: "Shipping Details",
              icon: Icon(
                Icons.add,
                size: 26.0,
              ),
              onpressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ShippingDetails()));
              }),
          CustomFieldsForCheckOut(
            title: "Delivery Methods",
          ),
          CustomFieldsForCheckOut(
            title: "Payment Method(s)",
          ),
          loading
              ? Center(child: CircularProgressIndicator())
              : FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                  color: Colors.pink,
                  textColor: Colors.white,
                  onPressed: () async {
                    if (BillingDetails.mapvarforBilling["first_name"] == null) {
                      Fluttertoast.showToast(
                          msg: "Please fill first Billing Details");
                    } else {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => PayToGo()));
                      //TODO: create order service function
//                      setState(() {
//                        loading = true;
//                      });
//                      bool response = await createorder.createOrder(
//                          line_item: CheckOutPage.line_item,
//                          billing: BillingDetails.mapvarforBilling,
//                          shipping: ShippingDetails.mapvarforShipping);
//                      if (response) {
//                        Fluttertoast.showToast(msg: "Order Created");
//                        setState(() {
//                          loading = false;
//                        });
//                      } else {
//                        setState(() {
//                          loading = false;
//                        });
//                      }
                    }
                  },
                  child: Text("Proceed to Pay"),
                ),
        ],
      ),
    );
  }
}

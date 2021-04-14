import 'package:ecommerceapp/Screen_3/product_page_for_grocon.dart';
import 'package:ecommerceapp/models/product_model_attributes.dart';
import 'package:flutter/material.dart';

class Search extends SearchDelegate {
  List productList;
  bool result = false;
  List<ProductAttributes> mylist = [];
  ProductAttributes productAttributes = ProductAttributes();
  Search({this.productList});

  @override
  List<Widget> buildActions(BuildContext context) {
    if (result == false) {
      for (int i = 0; i < productList.length; i++) {
        mylist.add(ProductAttributes.fromMap(productList[i]));
      }
    }
    result = true;
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back_ios, color: Colors.black),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text("");
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<ProductAttributes> suggestionList = query.isEmpty
        ? []
        : mylist.where((ProductAttributes productAttributes) {
            String _name = productAttributes.name.toLowerCase();
            int id = productAttributes.id;
            bool nameMatch = _name.contains(query);
            return nameMatch;
          }).toList();
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        //TODO change price
        suggestionList[index].price = "100";
        return ListTile(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductPageGrocon(
                    productAttributes: suggestionList[index],
                  ),
                ));
          },
          title: Text(suggestionList[index].name),
          trailing: Text("Price: " + suggestionList[index].price),
          leading: Container(
            child: suggestionList[index].images.isEmpty
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset("assets/empty.png"),
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:
                        Image.network(suggestionList[index].images[0]["src"]),
                  ),
          ),
        );
      },
      itemCount: suggestionList.length,
    );
  }
}

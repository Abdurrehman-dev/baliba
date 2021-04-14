import 'package:flutter/material.dart';
//my imports
import '../Dart_lists/category_list.dart';

//creating Category class object
Category category = Category();

class CategoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text("Categories"),
      ),
      body: Container(
        child: GridView.builder(
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {},
              child: Card(
                child: Column(
                  children: <Widget>[
                    Expanded(child: category.category_list[index]["icon"]),
                    Expanded(
                        child: Text(category.category_list[index]["title"])),
                  ],
                ),
              ),
            );
          },
          itemCount: category.category_list.length,
        ),
      ),
    );
  }
}

import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

class ProviderCartList extends ChangeNotifier {
  List<dynamic> providerCartList = [];

  void addToList({title, imagePath, price, old_price}) {
    providerCartList.add({
      "title": title,
      "image": imagePath,
      "price": price,
      "old_price": old_price
    });
  }

  String accessPrice(int index) {
    String price;
    price = providerCartList[index]["price"];
    notifyListeners();
    return price;
  }

  int lengthOfList() {
    notifyListeners();
    return providerCartList.length;
  }

  void removeProduct(int index) {
    providerCartList.removeAt(index);
    notifyListeners();
  }
}

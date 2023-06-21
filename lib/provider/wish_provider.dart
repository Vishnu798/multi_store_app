import 'package:flutter/material.dart';

import 'product_cart.dart';

class Wish extends ChangeNotifier {
  final List<Product> _list = [];
  List<Product> get getWishItems {
    return _list;
  }

  int? get count {
    return _list.length;
  }

  void addWishitems(String name, double price, int qty, int qntty,
      List imagesUrl, String documentId, String suppId) {
    final product = Product(
        name: name,
        price: price,
        qty: qty,
        qntty: qntty,
        imagesUrl: imagesUrl,
        documentId: documentId,
        suppId: suppId);
    _list.add(product);
    notifyListeners();
  }

  void removeItem(Product product) {
    _list.remove(product);
    notifyListeners();
  }

  void clearWish() {
    _list.clear();
    notifyListeners();
  }

  void removeThis(String id){
    _list.removeWhere((element) => element.documentId==id);
    notifyListeners();
  }
}

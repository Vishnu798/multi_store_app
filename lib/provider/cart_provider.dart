import 'package:flutter/material.dart';

import 'product_cart.dart';



class Cart extends ChangeNotifier {
final List<Product> _list=[];
List<Product> get getItems{
  return _list;
}

double get totalPrice{
  double total = 0.0;
  for(var item in _list){
    total += item.price * item.qty;
  }
  return total;
}

int? get count{
  return _list.length;
}
void additems(String name,
  double price,
  int qty,
  int qntty,
  List imagesUrl,
  String documentId,
  String suppId){
    final product = Product(name: name, price: price, qty: qty, qntty: qntty, imagesUrl: imagesUrl, documentId: documentId, suppId: suppId);
    _list.add(product);
    notifyListeners();
  }
  void increment(Product product){
    product.increase();
    notifyListeners();
  }
  void decrement(Product product){
    product.decrease();
    notifyListeners();
  }

  void removeItem(Product product){
    _list.remove(product);
    notifyListeners();
  }
  void clearCart(){
    _list.clear();
    notifyListeners();
  }
}


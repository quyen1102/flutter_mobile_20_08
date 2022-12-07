import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/cartModel.dart';
import '../models/luxuryProduct.dart';

class CartProvider with ChangeNotifier {
  CollectionReference cartProductRef =
      FirebaseFirestore.instance.collection('cartProduct');
  int _counter = 0;
  int _quantity = 1;

  int get counter => _counter;
  int get quantity => _quantity;

  double _totalPrice = 0.0;
  double get totalPrice => _totalPrice;

  List<LuxuryProduct> cartList = [];
  changeListCart(List<LuxuryProduct> cartListNew) {
    cartList = cartListNew;
    notifyListeners();
  }

  List<LuxuryProduct> getCartList() {
    cartProductRef.get().then(
      (QuerySnapshot querySnapshot) {
        List<LuxuryProduct> listData = [];
        for (var element in querySnapshot.docs) {
          LuxuryProduct product = LuxuryProduct.fromJson(element.data());
          listData.add(product);
        }
        cartList = listData;
      },
      onError: (e) => print("Error completing: $e"),
    );
    notifyListeners();
    return cartList;
  }

  void addCounter() {
    _counter++;
    notifyListeners();
  }

  void changeCounterCart(int counterUpdate) {
    _counter = counterUpdate;
    notifyListeners();
  }

  void removeCounter() {
    _counter--;
    notifyListeners();
  }

  void addQuantity(int id) {
    final index = cartList.indexWhere((element) => element.id == id);
    cartList[index].quantity!.value =
        cartList[index].quantity!.value + 1; // so luong cua mot san pham
    notifyListeners();
  }

  void deleteQuantity(int id) {
    final index = cartList.indexWhere((element) => element.id == id);
    final currentQuantity = cartList[index].quantity!.value;
    if (currentQuantity <= 1) {
      currentQuantity == 1;
    } else {
      cartList[index].quantity!.value = currentQuantity - 1;
    }
    notifyListeners();
  }

  int getCounter() {
    return _counter;
  }

  int getQuantity(int quantity) {
    return _quantity;
  }

  void removeItem(int id) {
    final index = cartList.indexWhere((element) => element.id == id);
    cartList.removeAt(index);
    notifyListeners();
  }

  void addTotalPrice(double productPrice) {
    _totalPrice = _totalPrice + productPrice;
    notifyListeners();
  }

  void removeTotalPrice(double productPrice) {
    _totalPrice = _totalPrice - productPrice;
    notifyListeners();
  }
}

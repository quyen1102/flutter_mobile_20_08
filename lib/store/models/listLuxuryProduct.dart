import 'package:flutter/material.dart';
import 'package:flutter_mobile_20_08/store/models/luxuryProduct.dart';

class ListLuxuryProduct extends ChangeNotifier {
  late List<LuxuryProduct> _list = [];
  List<LuxuryProduct> get list => _list;

  int get totalItem {
    return _list.length;
  }

  //constructor
  ListLuxuryProduct(List<LuxuryProduct> listLuxuryProduct) {
    _list = listLuxuryProduct;
  }

  void add(LuxuryProduct product) {
    _list.add(product);
    notifyListeners();
  }

  void removeAll() {
    _list.clear();
    notifyListeners();
  }

  Map<String, dynamic> toJson() => {
        'listLuxuryProduct': _list,
      };

  static ListLuxuryProduct fromJson(dynamic jsons) {
    List<LuxuryProduct> list = [];
    if (jsons == null) {
      return ListLuxuryProduct(list);
    }
    for(var i in jsons['listLuxuryProduct']){
      list.add(LuxuryProduct.fromJson(i));
    }
    return  ListLuxuryProduct(list);
  }
}

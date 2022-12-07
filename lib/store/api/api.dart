import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/luxuryProduct.dart';

CollectionReference cartProductRef =
    FirebaseFirestore.instance.collection('cartProduct');
CollectionReference luxuryProductRef =
    FirebaseFirestore.instance.collection('luxuryProduct');

//method
Future<List<LuxuryProduct>> getCartListFB() async {
  List<LuxuryProduct> listData = [];
  await cartProductRef.get().then(
    (QuerySnapshot querySnapshot) {
      for (var element in querySnapshot.docs) {
        LuxuryProduct product = LuxuryProduct.fromJson(element.data());
        listData.add(product);
      }
    },
    onError: (e) => print("Error completing: $e"),
  );
  return listData;
}

Future<List<LuxuryProduct>> getLuxuryListFB() async {
  List<LuxuryProduct> listData = [];
  await luxuryProductRef.get().then(
    (QuerySnapshot querySnapshot) {
      for (var element in querySnapshot.docs) {
        LuxuryProduct product = LuxuryProduct.fromJson(element.data());
        listData.add(product);
      }
    },
    onError: (e) => print("Error completing: $e"),
  );
  return listData;
}

Future<List<LuxuryProduct>> getCartFB() async {
  List<LuxuryProduct> listData = [];
  await cartProductRef.get().then(
    (QuerySnapshot querySnapshot) {
      for (var element in querySnapshot.docs) {
        LuxuryProduct product = LuxuryProduct.fromJson(element.data());
        listData.add(product);
      }
    },
    onError: (e) => print("Error completing: $e"),
  );
  return listData;
}

Future<bool> deleteProduct(String id) async {
  bool status = false;
  await cartProductRef.doc(id).delete().then((value) {
    status = true;
  }, onError: (e) {
    status = false;
    print("Error deleting: $e");
  });
  return status;
}

Future<bool> updateOneField({String? id, dataUpdate}) async {
  bool status = false;
  print("idđ : ${id}");
  luxuryProductRef
      .doc(id)
      .set(dataUpdate, SetOptions(merge: true))
      .then((value) {
    status = true;
    print("update successfully");
  }).catchError((error) => print("errorr: $error"));
  return status;
}

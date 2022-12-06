import 'package:flutter/material.dart';

class Cart {
  late final String? id;
  final String? productId;
  final String? productName;
  final int? initialPrice;
  final int? productPrice;
  final ValueNotifier<int>? quantity;
  final String? unitTag;
  final String? image;

  Cart(
      {required this.id,
      required this.productId,
      required this.productName,
      required this.initialPrice,
      required this.productPrice,
      required this.quantity,
      required this.unitTag,
      required this.image});

  static Cart fromJson(dynamic json) {
    if (json == null) {
      return Cart(
        id: "",
        productId: "",
        productName: "",
        initialPrice: 0,
        productPrice: 0,
        quantity: ValueNotifier(0),
        unitTag: "",
        image: "",
      );
    }
    Cart cart = Cart(
      id: json["id"] ?? "",
      productId: json["productId"] ?? "",
      productName: json["productName"] ?? "",
      initialPrice: json["initialPrice"] ?? 0,
      productPrice: json["productPrice"] ?? 0,
      quantity: json["quantity"] ?? 0,
      unitTag: json["unitTag"] ?? "",
      image: json["image"] ?? "",
    );
    return cart;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productId': productId,
      'productName': productName,
      'initialPrice': initialPrice,
      'productPrice': productPrice,
      'quantity': quantity?.value,
      'unitTag': unitTag,
      'image': image,
    };
  }
}

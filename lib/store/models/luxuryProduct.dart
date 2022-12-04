import 'package:flutter/material.dart';

@immutable
class LuxuryProduct {
  final String id;
  final String name;
  final String brandName;
  final String image;
  final double currentPrice;
  final double lastPrice;
  final String description;
  final String useType;
  final String scent;
  final int liquidVolume;
  final double rateStar;
  final int quantityPurchased;
  late bool isLiked;
  late int numberCountProduct;

  LuxuryProduct({
    required this.id,
    required this.name,
    required this.brandName,
    required this.image,
    required this.currentPrice,
    required this.lastPrice,
    required this.description,
    required this.useType,
    required this.scent,
    required this.liquidVolume,
    required this.rateStar,
    required this.quantityPurchased,
    required this.isLiked,
    required this.numberCountProduct,
  });
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "brandName": brandName,
        "image": image,
        "currentPrice": currentPrice,
        "lastPrice": lastPrice,
        "description": description,
        "useType": useType,
        "scent": scent,
        "liquidVolume": liquidVolume,
        "rateStar": rateStar,
        "quantityPurchased": quantityPurchased,
        "isLiked": isLiked,
        "numberCountProduct": numberCountProduct,
      };
  static LuxuryProduct fromJson(dynamic json) {
    if (json == null) {
      return LuxuryProduct(
        id: "",
        name: "",
        brandName: "",
        image: "",
        currentPrice: -1,
        lastPrice: -1,
        description: "",
        useType: "",
        scent: "",
        liquidVolume: -1,
        rateStar: -1,
        quantityPurchased: -1,
        isLiked: false,
        numberCountProduct: -1,
      );
    }
    LuxuryProduct luxuryProduct = LuxuryProduct(
      id: json['id'] ?? "",
      name: json['name'] ?? "",
      brandName: json['brandName'] ?? "",
      image: json['image'] ?? "",
      currentPrice: json['currentPrice'] ?? 0 as double,
      lastPrice: json['lastPrice'] ?? 0 as double,
      description: json['description'] ?? "",
      useType: json['useType'] ?? "",
      scent: json['scent'] ?? "",
      liquidVolume: json['liquidVolume'] ?? 0,
      rateStar: json['rateStar'] ?? 0 as double,
      quantityPurchased: json['quantityPurchased'] ?? 0,
      isLiked: json['isLiked'] ?? false,
      numberCountProduct: json['numberCountProduct'] ?? "" as int,
    );
    return luxuryProduct;
  }
}

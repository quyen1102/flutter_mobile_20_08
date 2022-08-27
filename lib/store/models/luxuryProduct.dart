import 'package:flutter/material.dart';

class LuxuryProduct {
  final int id;
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
  });
}

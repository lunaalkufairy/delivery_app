import 'dart:ui';

import 'package:delivery_app/constants/AppColors.dart';

class Storeproducts {
  final String productName;
  final int productId;
  final String description;
  final int quantity;
  final String price;
  final String image;
  Color heartColor;
  String favoraiteId;
  Storeproducts({
    required this.productName,
    required this.productId,
    required this.description,
    required this.quantity,
    required this.price,
    required this.image,
    required this.favoraiteId,
    required this.heartColor,
  });

  // Factory method to create a Product from JSON
  factory Storeproducts.fromJson(Map<String, dynamic> json) {
    return Storeproducts(
      productName: json['name'] ?? 'Unknown Product',
      productId: json['id'] ?? -1,
      description: json['pivot']['description'] ?? 'No description',
      quantity: json['pivot']['quantity'] ?? 0,
      price: json['pivot']['price'] ?? '0.00',
      image: json['pivot']['image'] ?? 'no_image.png',
      favoraiteId: '0',
      heartColor: grey,
    );
  }
}

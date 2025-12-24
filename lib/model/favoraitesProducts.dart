import 'dart:ui';

import 'package:delivery_app/constants/AppColors.dart';

class FavoriteProduct {
  final String productName;
  final String storeName;
  final String price;
  final String description;
  final int productId;
  final int quantity;
  final int storeId;
  Color heartColor;

  FavoriteProduct({
    required this.productName,
    required this.storeName,
    required this.price,
    required this.description,
    required this.productId,
    required this.quantity,
    required this.storeId,
    required this.heartColor,
  });

  // Factory method to create FavoriteProduct from JSON
  factory FavoriteProduct.fromJson(Map<String, dynamic> json) {
    return FavoriteProduct(
      productName: json['product']['name'] ?? 'Unknown Product',
      storeName: json['store_product']['image'],
      price: json['store_product']['price'] ?? '0.00',
      description: json['store_product']['description'] ?? 'No description',
      productId: json['id'] ?? -1,
      quantity: json['store_product']['quantity'] ?? 0,
      storeId: json['store_product']['store_id'] ?? -1,
      heartColor: grey,
    );
  }
}

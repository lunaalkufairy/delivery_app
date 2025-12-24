// Define Product Model
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:delivery_app/constants/AppColors.dart';

class ProductsModel {
  final String productName;
  final String storeName;
  final int productId;
  final int storeId;
  final String description;
  int quantity;
  final String price;
  final String? image;
  Color heartColor;
  String favoraiteId;

  ProductsModel({
    required this.productName,
    required this.storeName,
    required this.productId,
    required this.storeId,
    required this.description,
    required this.quantity,
    required this.price,
    required this.heartColor,
    this.image,
    required this.favoraiteId,
  });

  // Factory method to create a Product from JSON
  factory ProductsModel.fromJson(
    Map<String, dynamic> product,
    Map<String, dynamic> store,
  ) {
    return ProductsModel(
      productName: product['name'] ?? 'Unknown Product',
      storeName: store['name'] ?? 'Unknown Store',
      productId: product['id'] ?? -1,
      storeId: store['pivot']?['store_id'] ?? -1,
      description: store['pivot']?['description'] ?? 'No description',
      quantity: store['pivot']?['quantity'] ?? 0,
      price: store['pivot']?['price'] ?? '0.00',
      image: store['pivot']?['image'] ?? 'no_image.jpg',
      heartColor: grey,
      favoraiteId: '0',
    );
  }
}

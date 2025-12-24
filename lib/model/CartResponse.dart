import 'package:delivery_app/model/CartModel.dart';

/// Cart response model

class CartResponse {
  List<CartModel> items;
  double totalPrice;

  CartResponse({required this.items, required this.totalPrice});

  factory CartResponse.fromJson(Map<String, dynamic> json) {
    return CartResponse(
      items: (json['items'] as List)
          .map((item) => CartModel.fromJson(item))
          .toList(),
      totalPrice: double.parse(json['total_price'].toString()),
    );
  }
}

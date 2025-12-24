import 'package:delivery_app/model/Order.dart';

class OrderResponse {
  List<Order> orders;

  OrderResponse({required this.orders});

  factory OrderResponse.fromJson(Map<String, dynamic> json) {
    return OrderResponse(
      orders: (json['data'] as List)
          .map((item) => Order.fromJson(item))
          .toList(),
    );
  }
}

import 'OrderItem.dart'; // تأكد من استيراد كلاس OrderItem

class Order {
  final int id;
  final int userId;
  final int storeid;
  final double totalPrice;
  final String status;
  final String paymentMethod;
  final String message;
  final DateTime createdAt;
 List<OrderItem> orderItems;

  Order({
    required this.id,
    required this.userId,
    required this.storeid,
    required this.totalPrice,
    required this.status,
    required this.paymentMethod,
    required this.message,
    required this.createdAt,
    required this.orderItems,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'] != null ? int.tryParse(json['id'].toString()) ?? 0 : 0,
      userId: json['user_id'] != null
          ? int.tryParse(json['user_id'].toString()) ?? 0
          : 0,
      storeid: json['store_id'] != null
          ? int.tryParse(json['store_id'].toString()) ?? 0
          : 0,
      totalPrice: json['total_price'] != null
          ? double.tryParse(json['total_price'].toString()) ?? 0.0
          : 0.0,
      status: json['status'] ?? 'Unknown',
      paymentMethod: json['payment_method'] ?? 'Unknown',
      message: json['status'] ?? 'Unknown',
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),
      orderItems: (json['order_items'] as List?)
              ?.map((item) => OrderItem.fromJson(item))
              .toList() ??
          [],
    );
 
  }
  //   Map<String, dynamic> toJson() {
  //   return {
  //     'id': id,
  //     'user_id': userId,
  //     'store_id': storeid,
  //     'total_price': totalPrice,
  //     'status': status,
  //     'payment_method': paymentMethod,
  //     'message': message,
  //     'created_at': createdAt.toIso8601String(),
  //     'order_items': orderItems.map((item) => item.toJson()).toList(),
  //   };
  // }
}

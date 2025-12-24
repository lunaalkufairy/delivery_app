import 'package:delivery_app/model/PivotDetailsModel.dart'; // تأكد من استيراد كلاس PivotDetails
import 'package:delivery_app/model/product.dart'; // تأكد من استيراد كلاس Product
import 'package:delivery_app/model/stores.dart'; // تأكد من استيراد كلاس Stores

class OrderItem {
  final int id;
  final int orderId;
  final int productId;
  final int storeId;
  int quantity;
  final double price;
  // final DateTime createdAt;
  final PivotDetails pivotDetails;
  final String productImage;
  final Product product;
  final Stores store;

  OrderItem({
    required this.id,
    required this.orderId,
    required this.productId,
    required this.storeId,
    required this.quantity,
    required this.price,
    // required this.createdAt,
    required this.pivotDetails,
    required this.productImage,
    required this.product,
    required this.store,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      id: json['id'] != null ? int.tryParse(json['id'].toString()) ?? 0 : 0,
      orderId: json['order_id'] != null
          ? int.tryParse(json['order_id'].toString()) ?? 0
          : 0,
      productId: json['product_id'] != null
          ? int.tryParse(json['product_id'].toString()) ?? 0
          : 0,
      storeId: json['store_id'] != null
          ? int.tryParse(json['store_id'].toString()) ?? 0
          : 0,
      quantity: json['quantity'] != null
          ? int.tryParse(json['quantity'].toString()) ?? 0
          : 0,
      price: json['price'] != null
          ? double.tryParse(json['price'].toString()) ?? 0.0
          : 0.0,
      // createdAt: DateTime.parse(json['created_at']),
      pivotDetails: PivotDetails.fromJson(json['pivot_details']),
      productImage: json['product_image'] ?? '',
      product: Product.fromJson(json['product']),
      store: Stores.fromJson(json['store']),
    );
  }

  // تحويل الكائن إلى JSON
}

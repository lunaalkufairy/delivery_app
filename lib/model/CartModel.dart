import 'package:delivery_app/model/PivotDetailsModel.dart';
import 'package:delivery_app/model/product.dart';
import 'package:delivery_app/model/stores.dart';

class CartModel {
  int id;
  int userId;
  int productId;
  int? storeProductId;
  int? variantId;
  int storeId;
  int quantity;
  double price;
  Product product;
  Stores store;
  PivotDetails? pivotDetails;
  String? storeProductImage;
  List<dynamic> productImages; // Assuming product_images is a list.

  CartModel({
    required this.id,
    required this.userId,
    required this.productId,
    this.storeProductId,
    this.variantId,
    required this.storeId,
    required this.quantity,
    required this.price,
    required this.product,
    required this.store,
    this.pivotDetails,
    this.storeProductImage,
    required this.productImages,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['id'],
      userId: json['user_id'],
      productId: json['product_id'],
      storeProductId: json['store_product_id'],
      variantId: json['variant_id'],
      storeId: json['store_id'],
      quantity: json['quantity'],
      price: double.parse(json['price'].toString()),
      product: Product.fromJson(json['product']),
      store: Stores.fromJson(json['store']),
      pivotDetails: json['pivot_details'] != null
          ? PivotDetails.fromJson(json['pivot_details'])
          : null,
      storeProductImage: json['store_product_image'],
      productImages: json['product_images'] ?? [],
    );
  }
}

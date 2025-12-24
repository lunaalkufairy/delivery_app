
class PivotDetails {
  int id;
  int storeId;
  int productId;
  String description;
  String price;
  String image;
  int quantity;

  PivotDetails({
    required this.id,
    required this.storeId,
    required this.productId,
    required this.description,
    required this.price,
    required this.image,
    required this.quantity,
  });

  factory PivotDetails.fromJson(Map<String, dynamic> json) {
    return PivotDetails(
      id: json['id'],
      storeId: json['store_id'],
      productId: json['product_id'],
      description: json['description'],
      price: json['price'],
      image: json['image'],
      quantity: json['quantity'],
    );
  }
}

class Stores {
  final int storeId;
  final String storeName;
  final String description;
  final String storeImage;

  Stores({
    required this.storeId,
    required this.storeName,
    required this.description,
    required this.storeImage,
  });

  // Factory method to create a Store from JSON
  factory Stores.fromJson(Map<String, dynamic> json) {
    return Stores(
      storeId: json['id'] ?? -1,
      storeName: json['name'] ?? 'Unknown Store',
      description: json['description'] ?? 'No description',
      storeImage: json['image'] ?? 'default_image.png',
    );
  }
}

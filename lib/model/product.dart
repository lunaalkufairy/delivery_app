class Product {
  int id;
  String name;
  int categoryId;
 
 

  Product(
      {required this.id,
      required this.name,
      required this.categoryId,
    
      });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      categoryId: json['category_id'],
   
     
    );
  }
}

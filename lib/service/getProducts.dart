import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:delivery_app/model/ProductList.dart';

import 'package:delivery_app/model/productsmodel.dart';

Future<List<ProductsModel>> fetchProducts(String token) async {
  const String url = "http://10.0.2.2:8000/api/v1/user/products";
  final headers = {
    'Authorization': 'Bearer $token',
    'Content-Type': 'application/json',
  };

  try {
    final response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      // Check if data is valid
      if (data == null || data['data'] == null || !(data['data'] is List)) {
        throw Exception('Invalid data format');
      }

      // Process products
      final List<ProductsModel> productList = [];

      for (var product in data['data']) {
        if (product['stores'] != null && product['stores'] is List) {
          for (var store in product['stores']) {
            productList.add(ProductsModel.fromJson(product, store));
          }
        }
      }

      return productList;
    } else {
      throw Exception('Failed to fetch products: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Error fetching products: $e');
  }
}

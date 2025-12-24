// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:delivery_app/model/storeProducts.dart';

// // Method to fetch products by store ID
// Future<List<Storeproducts>> fetchProductsByStore(
//     String token, int storeId) async {
//   final response = await http.get(
//     Uri.parse('http://10.0.2.2:8000/api/v1/user/stores/products'),
//     headers: {
//       'Authorization': 'Bearer $token',
//       'Content-Type': 'application/json',
//       'Accept': 'application/json',
//     },
//     body = jsonEncode(storeId);
//   );
//   print(response.statusCode);
//   print(jsonDecode(response.body));
//   // Parse the JSON response
//   List<dynamic> data = json.decode(response.body);

//   // Map each JSON object to the Product model
//   List<Storeproducts> products =
//       data.map((json) => Storeproducts.fromJson(json)).toList();
//   print(products.length);
//   return products;
// }

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:delivery_app/model/storeProducts.dart';
// Assuming the Product model is in this file

// Method to fetch products by store ID using a GET request with a body
Future<List<Storeproducts>> fetchProductsByStore(
  String token,
  int storeId,
) async {
  final uri = Uri.parse('http://10.0.2.2:8000/api/v1/user/stores/products');

  // Custom HTTP request to send a GET request with a body
  final request = http.Request('GET', uri)
    ..headers.addAll({
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    })
    ..body = json.encode({'store_id': storeId});

  final streamedResponse = await request.send();

  if (streamedResponse.statusCode == 200) {
    final responseBody = await streamedResponse.stream.bytesToString();
    List<dynamic> data = json.decode(responseBody);

    // Map each JSON object to the Product model
    List<Storeproducts> products = data
        .map((json) => Storeproducts.fromJson(json))
        .toList();
    print(products);
    return products;
  } else {
    throw Exception('Failed to load products');
  }
}

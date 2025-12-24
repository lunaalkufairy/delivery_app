import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:delivery_app/model/favoraitesProducts.dart';

Future<List<FavoriteProduct>> fetchFavoriteProducts(String token) async {
  try {
    // API endpoint for fetching favorite products
    final url = Uri.parse('http://10.0.2.2:8000/api/v1/user/favorites');

    // HTTP GET request
    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer $token', 'Accept': 'application/json'},
    );

    // Log the response for debugging
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      // Parse the JSON response into a Map
      final Map<String, dynamic> responseBody =
          json.decode(response.body) as Map<String, dynamic>;

      // Extract the 'items' list from the response
      final List<dynamic> items = responseBody['items'] ?? [];

      // Convert the List of dynamic to FavoriteProduct objects
      return items.map((item) {
        return FavoriteProduct.fromJson(item as Map<String, dynamic>);
      }).toList();
    } else {
      // Handle non-successful HTTP status codes
      throw Exception(
        'Failed to load favorite products: ${response.statusCode} - ${response.body}',
      );
    }
  } catch (e) {
    // Log and rethrow any errors encountered
    print('Error fetching favorite products: $e');
    throw Exception('Error fetching favorite products: $e');
  }
}

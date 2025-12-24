import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:delivery_app/model/stores.dart';

Future<List<Stores>> fetchStores(String token) async {
  try {
    final response = await http.get(
      Uri.parse('http://10.0.2.2:8000/api/v1/user/stores'),
      headers: {'Authorization': 'Bearer $token', 'Accept': 'application/json'},
    );

    if (response.statusCode == 200) {
      // Parse the JSON response
      final Map<String, dynamic> responseBody = json.decode(response.body);
      List<dynamic> data = responseBody['data'];

      // Map each JSON object to the Stores model and update the image URL
      List<Stores> stores = data.map((json) {
        json['image'] = _updateImageIP(json['image']);
        return Stores.fromJson(json);
      }).toList();

      return stores;
    } else {
      throw Exception('Failed to load stores');
    }
  } catch (e) {
    throw Exception('Error fetching stores: $e');
  }
}

String _updateImageIP(String imageUrl) {
  try {
    if (imageUrl.startsWith('http')) {
      // If the URL is already absolute, replace the host
      final uri = Uri.parse(imageUrl);
      final newUri = uri.replace(host: '10.0.2.2');
      return newUri.toString();
    } else {
      // If the URL is relative, prepend the base URL
      return 'http://10.0.2.2:8000$imageUrl';
    }
  } catch (e) {
    throw Exception('Invalid image URL format: $e');
  }
}

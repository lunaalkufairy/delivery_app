import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:delivery_app/model/Order.dart';
import 'package:delivery_app/model/OrderItem.dart';
import 'package:delivery_app/model/OrderResponse.dart';

class OrderService {
  static Future<List<Order>> fetchOrders(String token) async {
    try {
      final response = await http.get(
        Uri.parse('http://10.0.2.2:8000/api/v1/user/orders'), // تحقق من الرابط
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        // طباعة الاستجابة للتأكد
        print('Response Data: $jsonData');

        // افترض أن مفتاح البيانات يحتوي على قائمة الطلبات
        if (jsonData['data'] != null) {
          return (jsonData['data'] as List)
              .map((item) => Order.fromJson(item))
              .toList();
        } else {
          throw Exception('Orders field is missing in response');
        }
      } else {
        throw Exception('Failed to load orders: ${response.reasonPhrase}');
      }
    } catch (e) {
      // طباعة الخطأ للتصحيح
      print('Error fetching orders: $e');
      throw Exception('Error fetching orders: $e');
    }
  }

  // Cancel order
  static Future<bool> cancelOrder(String token, int orderId) async {
    var headers = {'Authorization': 'Bearer $token'};
    var request = http.Request(
      'PUT',
      Uri.parse('http://10.0.2.2:8000/api/v1/user/orders/$orderId/cancel'),
    );
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      return true;
    } else {
      print('Error: ${response.reasonPhrase}');
      return false;
    }
  }

  static Future<bool> putyara({
    required String token,
    required int orderId,
    required int productId,
    required int storeId,
    required int quantity,
  }) async {
    final url = Uri.parse('http://10.0.2.2:8000/v1/user/orders/$orderId');

    // Create the request body
    final body = json.encode({
      "product_id": productId,
      "store_id": storeId,
      "quantity": quantity,
    });

    // Define the headers
    final headers = {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };

    try {
      // Send the PUT request
      final response = await http.put(url, headers: headers, body: body);

      // Check for success status codes
      if (response.statusCode == 200 || response.statusCode == 204) {
        print("Product updated successfully: ${response.body}");
        return true;
      } else {
        // Handle failure based on response reason phrase
        print("Failed to update product: ${response.reasonPhrase}");
        return false;
      }
    } catch (e) {
      // Handle errors during the request
      print("Error while updating product: $e");
      return false;
    }
  }
}

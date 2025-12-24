import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'package:http/http.dart' as http;
import 'package:delivery_app/model/CartResponse.dart';

class CartService {
  static Future<CartResponse> fetchCartProducts(String token) async {
    final response = await http.get(
      Uri.parse('http://10.0.2.2:8000/api/v1/user/cart'),
      headers: {'Authorization': 'Bearer $token', 'Accept': 'application/json'},
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return CartResponse.fromJson(jsonData);
    } else {
      final jsonData = json.decode(response.body);
      return CartResponse.fromJson(jsonData);
      // throw Exception('Failed to load cart products');
    }
  }

  /// Add a product to the cart using productId, storeId, and quantity
  static Future<void> addToCart({
    required String token,
    required int productId,
    required int storeId,
    required int quantity,
  }) async {
    final url = Uri.parse('http://10.0.2.2:8000/api/v1/user/cart');

    // Create the request body
    final body = json.encode({
      'product_id': productId,
      'store_id': storeId,
      'quantity': quantity,
    });

    final headers = {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("Product added to cart successfully: ${response.body}");
      } else {
        print("Failed to add product to cart: ${response.reasonPhrase}");
        throw Exception('Failed to add product to cart');
      }
    } catch (e) {
      print("Error while adding product to cart: $e");
      throw Exception('Error while adding product to cart');
    }
  }

  // romve from the cart
  static Future<void> removeFromCart({
    required String token,
    required int IdCart,
  }) async {
    final url = Uri.parse('http://10.0.2.2:8000/api/v1/user/cart');

    // طلب الحذف يحتوي على `IdCart` في البودي
    final body = json.encode({'cartItem_id': IdCart});

    final headers = {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };

    try {
      final response = await http.delete(url, headers: headers, body: body);

      if (response.statusCode == 200 || response.statusCode == 204) {
        print("Product removed successfully: ${response.body}");
      } else {
        print("Failed to remove product: ${response.reasonPhrase}");
        throw Exception('Failed to remove product');
      }
    } catch (e) {
      print("Error while removing product: $e");
      throw Exception('Error while removing product');
    }
  }

  // put in the cart
  static Future<bool> saveChanges({
    required String token,
    required int productId,
    required int storeId,
    required int quantity,
  }) async {
    final url = Uri.parse('http://10.0.2.2:8000/api/v1/user/cart');

    // Create the request body
    final body = json.encode({
      "product_id": productId,
      "store_id": storeId,
      "quantity": quantity,
    });

    final headers = {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };

    try {
      final response = await http.put(url, headers: headers, body: body);

      if (response.statusCode == 200 || response.statusCode == 204) {
        print("Product updated successfully: ${response.body}");
        return true;
      } else {
        print("Failed to update product: ${response.reasonPhrase}");
        return false;
      }
    } catch (e) {
      print("Error while updating product: $e");
      return false;
    }
  }

  // Clear the cart
  static Future<void> clearCart({required String token}) async {
    final url = Uri.parse(
      'http://10.0.2.2:8000/api/v1/user/cart/clear',
    ); // تعديل URL إذا كان endpoint مختلفًا

    final headers = {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    };

    try {
      final response = await http.delete(url, headers: headers);

      if (response.statusCode == 200 || response.statusCode == 204) {
        print("Cart cleared successfully");
      } else {
        print("Failed to clear cart: ${response.reasonPhrase}");
        throw Exception('Failed to clear cart');
      }
    } catch (e) {
      print("Error while clearing cart: $e");
      throw Exception('Error while clearing cart');
    }
  }

  /// Submit the order for the items in the cart
  static Future<void> submitOrder({
    required String token,
    required List<Map<String, dynamic>> items,
    required String payment_method,
  }) async {
    final url = Uri.parse('http://10.0.2.2:8000/api/v1/user/orders');
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'items': items, 'payment_method': payment_method}),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      // الطلب تم بنجاح، ويمكنك معالجة الاستجابة هنا
      print('Order submitted successfully: ${response.body}');
    } else {
      // في حال وجود خطأ، ارمي استثناء مع رسالة الخطأ
      throw Exception('Failed to submit order: ${response.body}');
    }
  }
}

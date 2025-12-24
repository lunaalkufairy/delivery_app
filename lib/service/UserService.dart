// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:delivery_app/model/user.dart';

// class UserService {
//   final String baseUrl;

//   UserService(this.baseUrl);

//   Future<UserProfileResponse> getUserProfile(String token) async {
//     final response = await http.get(headers: {
//       'Authorization': 'Bearer $token',
//       'Content-Type': 'application/json'
//     }, Uri.parse('$baseUrl/user/profile'));
//     print('Status Code: ${response.statusCode}');
//     print('Response Body: ${response.body}');
//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//       return UserProfileResponse.fromJson(data);
//     } else {
//       throw Exception('Failed to load user profile');
//     }
//   }
// }

// String usarBaseUrl = 'http://10.0.2.2:8000/api/v1/user/profile';

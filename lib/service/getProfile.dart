import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:delivery_app/model/profile.dart';

// Fetch the profile data
Future<Profile> fetchProfile(String token) async {
  const String url = "http://10.0.2.2:8000/api/v1/user/profile";
  final headers = {
    'Authorization': 'Bearer $token',
    'Content-Type': 'application/json',
  };
  final response = await http.get(Uri.parse(url), headers: headers);

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return Profile.fromJson(data['profile']);
  } else {
    throw Exception('Failed to load profile');
  }
} // Update the profile data

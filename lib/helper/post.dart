import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<dynamic> posts(
    {required String url, @required dynamic body, String? token}) async {
  Map<String, String> headers = {"Accept": "application/json"};

  if (token != null) {
    headers.addAll({'Authorization': 'Bearer $token'});
  }

  http.Response response = await http.post(
    Uri.parse(url),
    body: body,
    headers: headers,
  );

  return response;
}

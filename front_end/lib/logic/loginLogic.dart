import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:front_end/logic/jwtLogic.dart';

// LOGIN button function
Future<bool> sendLoginRequest(String email, String password) async {
  final Map<String, dynamic> dataToSend = {
    'email': email,
    'password': password,
  };

  final Uri url = Uri.http('localhost:8080', '/login');

  try {
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(dataToSend),
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      print("Login Successfully ${response.body}");
      storeJwtCookie(response.body);
      return true;
    }
  } catch (e) {
    print(e);
  }
  return false;
}

Future<void> appEntryPoint(BuildContext context) async {
  String cookie = await readJwtCookie();
  if (cookie.contains("empty")) {
    Navigator.pushNamed(context, '/login');
    print("empty");
    return;
  }
  final response = await http.post(
    Uri.parse('http://localhost:8080/login'),
    headers: {'Cookie': 'jwToken=${cookie}'},
  );
  print("response: ${response.statusCode}");
  if (response.statusCode == 401) {
    print("401\n");
    Navigator.pushNamed(context, '/login');
    return;
  }
  Navigator.pushNamed(context, '/main');
}

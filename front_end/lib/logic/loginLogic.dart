import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:front_end/logic/userSingleTon.dart';
import 'package:front_end/model/user.dart';
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
      String cookie = response.body;
      storeJwtCookie(cookie);

      final userRequest = await http.get(
        Uri.parse('http://localhost:8080/users'),
        headers: {'Cookie': 'jwToken=$cookie'},
      );
      Map<String, dynamic> userJson = jsonDecode(userRequest.body);
      UserSingleton.setUser(User.fromJson(userJson));

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
  final response = await http.get(
    Uri.parse('http://localhost:8080/users'),
    headers: {'Cookie': 'jwToken=$cookie'},
  );

  print("response: ${response.statusCode}");
  if (response.statusCode == 401) {
    print("401\n");
    Navigator.pushNamed(context, '/login');
    return;
  }

  Map<String, dynamic> userJson = jsonDecode(response.body);
  UserSingleton.setUser(User.fromJson(userJson));
  Navigator.pushNamed(context, '/main');
}

import 'package:http/http.dart' as http;
import 'package:front_end/model/user.dart';
import 'dart:convert';

Future<User> getUser(int userId) async {
    final response = await http.get(Uri.http(
      'localhost:8080', 'users/$userId'
    ));

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<User> getUserName(int userId) async {
    final response = await http.get(Uri.http(
      'localhost:8080', 'users/$userId/name'
    ));

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('Failed to load data');
    }
  }
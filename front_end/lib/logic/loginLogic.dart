import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:front_end/logic/jwtLogic.dart';

// LOGIN button function
Future<void> sendLoginRequest() async {
  final response = await http.post(
    Uri.parse('http://localhost:8080/send'),
  );
}

Future<void> appEntryPoint(BuildContext context) async {
  storeJwtCookie("notEmpty");
  String cookie = await readJwtCookie();
  if(cookie.contains("empty")){
      //TODO: baga-l pe login
      //Navigator.pushNamed(context, '/signup');
      print("empty123123");
      return;
  }
  final response = await http.post(
    Uri.parse('http://localhost:8080/login'),
      headers: {'Cookie': 'jwToken=${cookie}'},
  );
  print("response: ${response.statusCode}");
  if(response.statusCode == 401) {
    print("401\n");
    //Navigator.pushNamed(context, '/login');
    return;
  }
  Navigator.pushNamed(context, '/main');
  // if NO stay on login page

  // if YES make req

  // if cookie EXP stay on login (maybe inform user)

  // if req stat == 200 GOTO main
}

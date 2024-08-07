import 'package:flutter/material.dart';
import 'package:front_end/model/user.dart';
import 'package:front_end/logic/httpReq.dart';

FutureBuilder<User> UserShower(int userNo) {
  return FutureBuilder<User>(
    future: getUser(userNo),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const CircularProgressIndicator();
      } else if (snapshot.hasData) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ShaderMask(shaderCallback: (bounds) =>
              const LinearGradient(
                colors: [
                  Colors.green,
                  Colors.black,
                ]
              ).createShader(bounds),
              child: Text(
                  'Name: ${snapshot.data?.full_name}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            ),
            Text(
              'Email: ${snapshot.data?.email}',
              style: const TextStyle(
                fontWeight: FontWeight.bold
              ),
            ),
            Text(
              'Phone number: ${snapshot.data?.phone_number}',
              style: const TextStyle(
                fontWeight: FontWeight.bold
              ),
            ),
          ],
        );
      } else if (snapshot.hasError) {
        return Text('Error: ${snapshot.error}');
      } else {
        return Text('No data found');
      }
    },
  );
}

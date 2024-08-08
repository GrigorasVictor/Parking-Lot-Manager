import 'package:flutter/material.dart';
import 'package:front_end/model/user.dart';
import 'package:front_end/logic/httpReq.dart';
import 'card.dart';

FutureBuilder<User> UserShower(int userNo) {
  const double cardWidth = 500;
  const double cardHeight = 75;

  return FutureBuilder<User>(
    future: getUser(userNo),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const CircularProgressIndicator();
      } else if (snapshot.hasData) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CustomCard(
              title: 'Name',
              content: snapshot.data?.full_name ?? 'name not found',
              width: cardWidth,
              height: cardHeight,
            ),
            CustomCard(
              title: 'Email',
              content: snapshot.data?.email ?? 'email not found',
              width: cardWidth,
              height: cardHeight,
            ),
            CustomCard(
              title: 'Phone Number',
              content: snapshot.data?.phone_number ?? 'phone number not found',
              width: cardWidth,
              height: cardHeight,
            ),
            // TODO: Also show the number plates in a separate column
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

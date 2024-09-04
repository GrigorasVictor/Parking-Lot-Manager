import 'package:flutter/material.dart';
import 'package:front_end/model/user.dart';
import 'package:front_end/logic/httpReq.dart';
import 'card.dart';

FutureBuilder<User> UserShower(int userNo) {
  const double cardWidth = double.infinity;
  const double cardHeight = 50;

  return FutureBuilder<User>(
    future: getUser(userNo),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const CircularProgressIndicator();
      } else if (snapshot.hasData) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CustomCard(
              title: 'Name',
              content: snapshot.data?.fullName ?? 'name not found',
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
              content: snapshot.data?.phoneNumber ?? 'phone number not found',
              width: cardWidth,
              height: cardHeight,
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(25, 0, 0, 0),
              child: Text(
                  style: TextStyle(fontWeight: FontWeight.bold),
                  'Registered licence plates:'),
            ),
            for (var registration in snapshot.data!.registrations)
              CustomCard(
                content: registration.licencePlate,
                width: cardWidth - 100,
                height: cardHeight,
              )
            // TODO: Also show the number plates in a separate column
          ],
        );
      } else if (snapshot.hasError) {
        return Text('Error: ${snapshot.error}');
      } else {
        return const Text('No data found');
      }
    },
  );
}

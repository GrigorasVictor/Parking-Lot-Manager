import 'package:flutter/material.dart';
import 'package:front_end/model/user.dart';
import 'package:front_end/logic/httpReq.dart';
import 'card.dart';
import 'dart:async';

FutureBuilder<User> UserShower(int userNo) {
  const double cardWidth = 500;
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
              GestureDetector(
                onSecondaryTap: () {
                  // Right-click will trigger the delete dialog on desktop
                  _showDeleteDialog(context, registration.licencePlate, userNo);
                },
                onTapDown: (details) {
                  Timer(Duration(milliseconds: 500), () {
                    _showDeleteDialog(
                        context, registration.licencePlate, userNo);
                  });
                },
                child: CustomCard(
                  content: registration.licencePlate,
                  width: cardWidth - 100,
                  height: cardHeight,
                ),
              ),
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

void _showDeleteDialog(BuildContext context, String licencePlate, int userNo) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Delete Licence Plate"),
        content: Text("Are you sure you want to delete $licencePlate?"),
        actions: <Widget>[
          TextButton(
            child: const Text("Cancel"),
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
          ),
          TextButton(
            child: const Text("Delete"),
            onPressed: () {
              _deleteLicencePlate(context, licencePlate,
                  userNo); // Call the delete function and pass context
              Navigator.of(context).pop(); // Close the dialog after deletion
            },
          ),
        ],
      );
    },
  );
}

Future<void> _deleteLicencePlate(
    BuildContext context, String licencePlate, int userNo) async {
  try {
    await deleteLicencePlate(licencePlate,
        userNo); // Assuming you have a function like this in httpReq
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text('Licence plate $licencePlate deleted successfully')),
    );
    // Optionally refresh the user data here, if necessary
  } catch (error) {
    // Show error message using a snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error deleting licence plate: $error')),
    );
  }
}

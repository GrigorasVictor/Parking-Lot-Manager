import 'package:flutter/material.dart';
import 'package:front_end/model/user.dart';
import 'package:front_end/logic/httpReq.dart';
import 'card.dart';
import 'dart:async';

class UserShower extends StatefulWidget {
  final int userNo;

  const UserShower({super.key, required this.userNo});

  @override
  _UserShowerState createState() => _UserShowerState();
}

class _UserShowerState extends State<UserShower> {
  late Future<User> _userFuture;

  @override
  void initState() {
    super.initState();
    _userFuture = getUser(widget.userNo);
  }

  @override
  Widget build(BuildContext context) {
    const double cardWidth = 500;
    const double cardHeight = 50;

    return FutureBuilder<User>(
      future: _userFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
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
                    _showDeleteDialog(context, registration.licencePlate, registration.registrationId);
                  },
                  onTapDown: (details) {
                    Timer(const Duration(milliseconds: 500), () {
                      _showDeleteDialog(context, registration.licencePlate, registration.registrationId);
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

  void _showDeleteDialog(BuildContext context, String licencePlate, int plateId) {
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
                Navigator.of(context).pop(); // Close the dialog
                _deleteLicencePlate(context, licencePlate, plateId);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteLicencePlate(BuildContext context, String licencePlate, int plateId) async {
    try {
      await deleteLicencePlate(licencePlate, plateId); 
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Licence plate $licencePlate deleted successfully')),
      );
      setState(() {
        _userFuture = getUser(widget.userNo); // Refresh the user data
      });
    } catch (error) {
      // Show error message using a snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting licence plate: $error')),
      );
    }
  }
}

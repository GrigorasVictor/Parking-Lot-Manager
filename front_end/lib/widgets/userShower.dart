import 'package:flutter/material.dart';
import 'package:front_end/logic/userSingleTon.dart';
import 'package:front_end/model/user.dart';
import 'package:front_end/widgets/card.dart'; // Assuming this is where your `CustomCard` widget is located.

class UserShower extends StatefulWidget {
  const UserShower({super.key});

  @override
  _UserShowerState createState() => _UserShowerState();
}

class _UserShowerState extends State<UserShower> {
  User? _user;

  @override
  void initState() {
    super.initState();
    _user = UserSingleton.getUser(); 
  }

  @override
  Widget build(BuildContext context) {
    const double cardWidth = 500;
    const double cardHeight = 50;

    if (_user == null) {
      return const Center(child: Text('No user data available'));
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildCustomCard('Name', _user!.fullName, Icons.person, cardWidth, cardHeight),
        _buildCustomCard('Email', _user!.email, Icons.email, cardWidth, cardHeight),
        _buildCustomCard('Phone Number', _user!.phoneNumber, Icons.phone, cardWidth, cardHeight),

        const Padding(
          padding: EdgeInsets.fromLTRB(25, 0, 0, 0), 
          child: Text(
            style: TextStyle(fontWeight: FontWeight.bold),
            'Registered Licence Plates:',
          ),
        ),

        if (_user!.registrations.isNotEmpty)
          for (var registration in _user!.registrations)
            GestureDetector(
              onTap: () {
                _showDeleteDialog(
                  context,
                  registration.licencePlate,
                  registration.registrationId,
                );
              },
              child: CustomCard(
                content: registration.licencePlate,
                width: cardWidth - 100,
                height: cardHeight,
              ),
            )
        else
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('No registered license plates found.'),
          ),
      ],
    );
  }

  // Function to build CustomCard with icon
  Widget _buildCustomCard(String title, String? content, IconData icon, double width, double height) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 24),
              const SizedBox(width: 8), 
              Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ],
          ),
          CustomCard(
            content: content ?? 'Not available',
            width: width,
            height: height,
          ),
        ],
      ),
    );
  }

  // Dialog to confirm deletion of a license plate
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
                Navigator.of(context).pop(); // Close dialog without action
              },
            ),
            TextButton(
              child: const Text("Delete"),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                //_deleteLicencePlate(licencePlate, plateId); // Perform deletion
              },
            ),
          ],
        );
      },
    );
  }
}

  


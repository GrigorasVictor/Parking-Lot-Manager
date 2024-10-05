import 'package:flutter/material.dart';
import 'package:front_end/logic/userSingleTon.dart';
import 'package:front_end/model/user.dart';
import 'package:front_end/widgets/carCard.dart';
import 'package:front_end/widgets/card.dart';

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
    const double cardHeight = 50;

    if (_user == null) {
      return const Center(child: Text('No user data available'));
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildCustomCard('Name', _user!.fullName, Icons.person, cardHeight),
        _buildCustomCard('Email', _user!.email, Icons.email, cardHeight),
        _buildCustomCard('Phone Number', _user!.phoneNumber, Icons.phone, cardHeight),

        const Padding(
          padding: EdgeInsets.fromLTRB(25, 0, 0, 0), 
          child: Text(
            'Registered Licence Plates:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),

        // Horizontal list for registered license plates
        if (_user!.registrations.isNotEmpty)
          SizedBox(
            height: 150, // Set a height for the sliding cards
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _user!.registrations.length,
              itemBuilder: (context, index) {
                final registration = _user!.registrations[index];
                return Padding(
                  padding: const EdgeInsets.only(right: 10.0), // Space between cards
                  child: CarCard(
                    descriptionText: registration.licencePlate,
                    onClose: () {
                      _showDeleteDialog(context, registration.licencePlate, registration.registrationId);
                    },
                  ),
                );
              },
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
  Widget _buildCustomCard(String title, String? content, IconData icon, double height) {
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
            width: double.infinity, // Use full width
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
                Navigator.of(context).pop(); 
              },
            ),
            TextButton(
              child: const Text("Delete"),
              onPressed: () {
                _deleteLicencePlate(plateId); 
                Navigator.of(context).pop(); 
              },
            ),
          ],
        );
      },
    );
  }

  void _deleteLicencePlate(int plateId) {
    setState(() {
      _user!.registrations.removeWhere((reg) => reg.registrationId == plateId);
    });
  }
}

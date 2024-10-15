import 'package:flutter/material.dart';
import 'package:front_end/widgets/parkingInfoList.dart';

class HelpPage extends StatefulWidget {
  const HelpPage({super.key});

  @override
  _HelpPageState createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  bool isActive = true; // Initial state of the parking info (active)
  int activeCars = 10; // Example value for active cars
  int totalSpots = 50; // Example value for total spots

  int? initialHours;
  int? initialMinutes;
  int? initialSeconds;

  // Toggle between active and inactive based on user input from dialog
  void onTap() {
    _showTimeInputDialog();
  }

  // Function to show input dialog and allow user to enter hours, minutes, and seconds
  Future<void> _showTimeInputDialog() async {
    int hours = 0, minutes = 0, seconds = 0;

    final result = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Enter Time for Parking Spot'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Please input hours, minutes, and seconds. Enter -1 to deactivate the parking spot.'),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: 'Hours'),
                      onChanged: (value) {
                        hours = int.tryParse(value) ?? 0;
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: 'Minutes'),
                      onChanged: (value) {
                        minutes = int.tryParse(value) ?? 0;
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: 'Seconds'),
                      onChanged: (value) {
                        seconds = int.tryParse(value) ?? 0;
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true); // Confirm the input
              },
              child: const Text('Confirm'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // Cancel
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );

    // If the user confirmed their input, update the state accordingly
    if (result == true) {
      setState(() {
        // Update the timer values to the input values or deactivate if -1 is input
        initialHours = hours;
        initialMinutes = minutes;
        initialSeconds = seconds;

        // If any value is -1, deactivate the spot
        isActive = !(hours == -1 || minutes == -1 || seconds == -1);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ParkingInfoList(
          parkingId: '3',
          onTap: onTap, // Set the toggle action for tapping
          activeCars: activeCars,
          totalSpots: totalSpots,
          initialHours: initialHours ?? -1, // Pass timer values to ParkingInfoList
          initialMinutes: initialMinutes ?? -1,
          initialSeconds: initialSeconds ?? -1,
        ),
      ),
    );
  }
}

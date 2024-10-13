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
    _showToggleDialog();
  }

  // Function to show input dialog and allow user to activate/deactivate parking spot
  Future<void> _showToggleDialog() async {
    bool deactivate = true;
    int hours = 0, minutes = 0, seconds = 0;

    final result = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Parking Spot Status'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                isActive
                    ? 'Parking spot is currently ACTIVE. Would you like to deactivate it?'
                    : 'Parking spot is currently INACTIVE. Please enter time to activate.',
              ),
              const SizedBox(height: 16),
              if (!isActive) ...[
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
              ]
            ],
          ),
          actions: <Widget>[
            if (isActive)
              TextButton(
                onPressed: () {
                  deactivate = true;
                  Navigator.of(context).pop(true);
                },
                child: const Text('Deactivate'),
              ),
            if (!isActive)
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true); // Confirm activation
                },
                child: const Text('Activate'),
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

    if (result == true && deactivate) {
      // If the result is deactivate, update the state to reflect the deactivation
      setState(() {
        initialHours = -1;
        initialMinutes = -1;
        initialSeconds = -1;
        isActive = false; // Now parking is inactive
      });
    } else if (result == true && !deactivate) {
      // If activating, do nothing to the timer state; it remains as is.
      setState(() {
        // Keep isActive true, but don't modify the initialHours, initialMinutes, or initialSeconds
        isActive = true;
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

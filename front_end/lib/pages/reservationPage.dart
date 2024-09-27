import 'package:flutter/material.dart';
import 'package:front_end/widgets/calendarCard.dart';

class ReservationPage extends StatefulWidget {
  final String parkingId;
  final String? parkingSpot;
  final bool isActive;

  ReservationPage({
    Key? key,
    required this.parkingId,
    this.parkingSpot,
    this.isActive = false,
  }) : super(key: key);

  @override
  State<ReservationPage> createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {
  DateTime _selectedDate = DateTime.now(); 
  String? _selectedParkingSpot;

  final List<String> _parkingSpots = ['A1', 'A2', 'A3', 'A4'];

  void onDateSelected(DateTime pickedDate) {
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Parking Lot #${widget.parkingId}',
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            Expanded(
              child: CalendarCard(onDateSelected: onDateSelected),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: DropdownButton<String>(
                value: _selectedParkingSpot,
                isExpanded: true,
                underline: const SizedBox(),
                hint: const Text('Select a Parking Spot'),
                items: _parkingSpots.map((spot) {
                  return DropdownMenuItem<String>(
                    value: spot,
                    child: Text(spot),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedParkingSpot = value;
                  });
                },
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(Icons.calendar_today, color: Colors.green), 
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Selected Date: ${_selectedDate.toLocal().toString().split(' ')[0]}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [
                  const BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(Icons.local_parking, color: Colors.green), 
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Selected Parking Spot: ${_selectedParkingSpot ?? "None"}', 
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_selectedParkingSpot != null) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Reservation Confirmed"),
                          content: Text(
                              'Parking reserved for ${_selectedDate.toLocal().toString().split(' ')[0]} at spot $_selectedParkingSpot'),
                          actions: <Widget>[
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop(); 
                                Navigator.of(context).pushNamed('/main'); 
                              },
                              child: const Text("OK", style: TextStyle(color: Colors.white)), 
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green, 
                                padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0), 
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0), 
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Please select a date and a parking spot')),
                    );
                  }
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    'Make The Reservation',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green, 
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

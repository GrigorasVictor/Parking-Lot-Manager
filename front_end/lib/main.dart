import 'package:flutter/material.dart';
import 'package:front_end/widgets/cardIcon.dart';
import 'package:front_end/widgets/parkingInfoList.dart';
import 'package:front_end/widgets/calendarCard.dart';
import 'package:front_end/widgets/constants.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(itemColorHighlighted)),
        useMaterial3: true, // Ensure your widgets are compatible with Material 3
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({super.key, required this.title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _hoursController = TextEditingController();
  final TextEditingController _minutesController = TextEditingController();
  final TextEditingController _secondsController = TextEditingController();
  ParkingInfoList? _parkingInfoList;

  DateTime _selectedDate = DateTime.now();

  @override
  void dispose() {
    _hoursController.dispose();
    _minutesController.dispose();
    _secondsController.dispose();
    super.dispose();
  }

  void _applyTime(int hours, int minutes, int seconds) {
    setState(() {
      _parkingInfoList = ParkingInfoList(
        parkingId: '3',
        parkingSpot: '4',
        onTap: () => print('ParkingInfoList tapped'),
        initialHours: hours,
        initialMinutes: minutes,
        initialSeconds: seconds,
      );
    });
  }

  void _stopTimer() {
    setState(() {
      _parkingInfoList = null; // Stop the timer by removing the widget
    });
  }

  void _onDateSelected(DateTime date) {
    setState(() {
      _selectedDate = date;
    });
    print('Selected Date: ${date.toString()}');
  }

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Calculate responsive dimensions
    final cardWidth = screenWidth * 0.9; // 80% of screen width
    final cardHeight = screenHeight * 0.6; // 60% of screen height

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CustomCardIcon(
                icon: Image.asset('lib/assets/icons/account.png'), 
                title: 'Account',
                height: 150,
                width: 125,
                onTap: () => print('Account tapped'),
              ),
              SizedBox(
                width: cardWidth,
                height: cardHeight,
                child: CalendarCard(
                  onDateSelected: _onDateSelected,
                ),
              ),
              if (_parkingInfoList != null) _parkingInfoList!,
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 50,
                      child: TextField(
                        controller: _hoursController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(labelText: 'Hours'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    SizedBox(
                      width: 50,
                      child: TextField(
                        controller: _minutesController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(labelText: 'Minutes'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    SizedBox(
                      width: 50,
                      child: TextField(
                        controller: _secondsController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(labelText: 'Seconds'),
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  final int hours = int.tryParse(_hoursController.text) ?? 0;
                  final int minutes = int.tryParse(_minutesController.text) ?? 0;
                  final int seconds = int.tryParse(_secondsController.text) ?? 0;
                  _applyTime(hours, minutes, seconds);
                },
                child: const Text('Set Timer'),
              ),
              ElevatedButton(
                onPressed: _stopTimer,
                child: const Text('Stop Timer'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

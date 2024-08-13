import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:front_end/logic/httpReq.dart';
import 'package:front_end/widgets/cardIcon.dart';
import 'package:front_end/widgets/constants.dart';
import 'package:front_end/widgets/parkingInfoList.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // List to keep track of whether each parking widget is active
  final List<bool> _parkingActive = [true, true, true, true];

  void _toggleParkingState(int index) {
    setState(() {
      _parkingActive[index] = !_parkingActive[index];
    });
  }

  ParkingInfoList _buildParkingInfoList(int id, bool isActive) {
    return ParkingInfoList(
      parkingId: id.toString(),
      parkingSpot: isActive ? 'A$id' : null,
      initialHours: isActive ? 0 : -1,
      initialMinutes: isActive ? 10 * id : -1,
      initialSeconds: isActive ? 0 : -1,
      onTap: () => _toggleParkingState(id - 1),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final cardIconHeight = screenWidth * 0.25;
    final cardIconWidth = (screenWidth - 131.8) * 0.33;

    return Scaffold(
      backgroundColor: const Color(backgroundColor),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            FutureBuilder(
              future: getUser(3),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      AutoSizeText(
                        'Error loading user data',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                        ),
                        maxLines: 1,
                      ),
                    ],
                  );
                } else if (snapshot.hasData) {
                  // Extract the surname from the full name
                  final fullName = snapshot.data?.fullName ?? '';
                  final surname = fullName.split(' ').last;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(
                        'Hi, $surname!',
                        style: const TextStyle(
                          fontSize: 26, // Large font size
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                        maxLines: 1,
                      ),
                      const AutoSizeText(
                        'Welcome Back!',
                        style: TextStyle(
                          fontSize: 44,
                          color: Colors.white,
                          fontWeight: FontWeight.w100
                        ),
                        maxLines: 1,
                      ),
                    ],
                  );
                } else {
                  return const AutoSizeText(
                    'Welcome Back!',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                    ),
                    maxLines: 1,
                  );
                }
              },
            ),
            const SizedBox(height: 40),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  // Rounded corners only at the top
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                padding: const EdgeInsets.all(2.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomCardIcon(
                          title: 'Account',
                          width: cardIconWidth,
                          height: cardIconHeight,
                          iconPath: 'lib/assets/icons/account.svg',
                          onTap: () => print('Pressed Account'),
                        ),
                        CustomCardIcon(
                          title: 'Privacy',
                          width: cardIconWidth,
                          height: cardIconHeight,
                          iconPath: 'lib/assets/icons/privacy.svg',
                          onTap: () => print('Pressed Privacy'),
                        ),
                        CustomCardIcon(
                          title: 'Help',
                          width: cardIconWidth,
                          height: cardIconHeight,
                          iconPath: 'lib/assets/icons/help.svg',
                          onTap: () => print('Pressed Help'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Container(
                      padding: const EdgeInsets.all(18),
                      child: const AutoSizeText(
                        'Available Parking Lot',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    // Ensure ListView takes all available space
                    Expanded(
                      child: ListView.builder(
                        itemCount: _parkingActive.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: _buildParkingInfoList(
                                index + 1, _parkingActive[index]),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

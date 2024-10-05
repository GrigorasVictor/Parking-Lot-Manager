import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:front_end/logic/httpReq.dart';
import 'package:front_end/logic/userSingleTon.dart';
import 'package:front_end/model/ParkingLot.dart';
import 'package:front_end/model/user.dart';
import 'package:front_end/widgets/cardIcon.dart';
import 'package:front_end/widgets/constants.dart';
import 'package:front_end/widgets/parkingInfoList.dart';
import 'package:front_end/logic/pageNavigationController.dart';
import 'package:front_end/pages/privacyPage.dart';
import 'package:front_end/pages/faqPage.dart';

class MainPage extends StatefulWidget {
  final PageNavigationController navigationController;
  final Function updateNavbar;

  const MainPage({
    super.key,
    required this.navigationController,
    required this.updateNavbar,
  });

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late List<bool> _parkingActive;
  late Future<List<ParkingLot>> futureParkingLots;

  @override
  void initState() {
    super.initState();
    futureParkingLots = getParkingLots(); 
    _parkingActive = []; 
  }

  void _toggleParkingState(int index) {
    setState(() {
      for (int i = 0; i < _parkingActive.length; i++) {
        _parkingActive[i] = i == index;
      }
    });
  }

  // Function to build parking info list dynamically
  ParkingInfoList _buildParkingInfoList(int id, bool isActive, int activeCars, int totalSpots) {
    return ParkingInfoList(
      parkingId: id.toString(),
      parkingSpot: isActive ? 'A$id' : null,
      initialHours: isActive ? 0 : -1,
      initialMinutes: isActive ? 10 * id : -1,
      initialSeconds: isActive ? 0 : -1,
      activeCars: activeCars,
      totalSpots: totalSpots,
      onTap: () => _toggleParkingState(id - 1),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardIconHeight = screenWidth * 0.25;
    final cardIconWidth = (screenWidth - 131.8) * 0.33;

    User? user = UserSingleton.getUser(); 
    final surname = user != null ? user.fullName.split(' ').last : 'User'; 

    return Scaffold(
      backgroundColor: const Color(backgroundColor),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),

            // Welcome Section
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AutoSizeText(
                  'Hi, $surname!',
                  style: const TextStyle(
                    fontSize: 26,
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
                    fontWeight: FontWeight.w100,
                  ),
                  maxLines: 1,
                ),
              ],
            ),
            const SizedBox(height: 40),

            // Main Content Section
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
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
                          onTap: () {
                            widget.updateNavbar(3);
                            widget.navigationController.navigateToPage(3);
                          },
                        ),
                        CustomCardIcon(
                          title: 'Privacy',
                          width: cardIconWidth,
                          height: cardIconHeight,
                          iconPath: 'lib/assets/icons/privacy.svg',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const PrivacyPage(),
                              ),
                            );
                          },
                        ),
                        CustomCardIcon(
                          title: 'Help',
                          width: cardIconWidth,
                          height: cardIconHeight,
                          iconPath: 'lib/assets/icons/help.svg',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HelpPage(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),

                    // Parking Lot Title
                    Container(
                      padding: const EdgeInsets.all(18),
                      child: const AutoSizeText(
                        'Available Parking Lots',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),

                    // Parking Info List
                    Expanded(
                      child: FutureBuilder<List<ParkingLot>>(
                        future: futureParkingLots,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(color: Colors.green),
                            );
                          }
                          if (snapshot.hasError || !snapshot.hasData) {
                            return const Center(
                              child: Text('Error loading parking lots'),
                            );
                          }

                          final List<ParkingLot> parkingLots = snapshot.data!;
                          print(parkingLots);
                          // Initialize _parkingActive list if it's not already
                          if (_parkingActive.isEmpty) {
                            _parkingActive = List<bool>.filled(parkingLots.length, false);
                            _parkingActive[0] = true; // Activate the first parking lot by default
                          }

                          return ListView.builder(
                            itemCount: parkingLots.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: _buildParkingInfoList(
                                  index + 1,
                                  _parkingActive[index],
                                  parkingLots[index].availableParkingSpaces ?? 0,
                                  parkingLots[index].totalParkingSpaces ?? 0
                                ),
                              );
                            },
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

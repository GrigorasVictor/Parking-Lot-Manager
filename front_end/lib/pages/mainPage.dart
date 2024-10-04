import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:front_end/logic/userSingleTon.dart';
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
                        'Available Parking Lot',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),

                    // Parking Info List
                    Expanded(
                      child: ListView.builder(
                        itemCount: _parkingActive.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: _buildParkingInfoList(
                              index + 1,
                              _parkingActive[index],
                            ),
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

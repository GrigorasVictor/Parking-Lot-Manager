import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:front_end/widgets/cardIcon.dart';
import 'package:front_end/widgets/constants.dart';
import 'package:front_end/widgets/parkingInfoList.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final cardIconHeight = screenHeight * 0.15;
    final cardIconWidth = screenWidth * 0.18; 

    return Scaffold(
      backgroundColor: const Color(backgroundColor),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            AutoSizeText(
              'Hi, Arthur!',
              style: const TextStyle(
                fontSize: 32, // Large font size
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              maxLines: 1,
            ),
            const AutoSizeText(
              'Welcome Back!',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
              ),
              maxLines: 1,
            ),
            const SizedBox(height: 40),

            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween, // Distributes cards evenly with less space
                    children: [
                      CustomCardIcon(
                        title: 'Account',
                        width: cardIconWidth, // Adjusted width
                        height: cardIconHeight,
                        iconPath: 'lib/assets/icons/account.svg',
                        onTap: () => print('Pressed Account'),
                      ),
                      CustomCardIcon(
                        title: 'Privacy',
                        width: cardIconWidth, // Adjusted width
                        height: cardIconHeight,
                        iconPath: 'lib/assets/icons/privacy.svg',
                        onTap: () => print('Pressed Privacy'),
                      ),
                      CustomCardIcon(
                        title: 'Help',
                        width: cardIconWidth, // Adjusted width
                        height: cardIconHeight,
                        iconPath: 'lib/assets/icons/help.svg',
                        onTap: () => print('Pressed Help'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  const AutoSizeText(
                    'Available Parking Lot',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    maxLines: 1,
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

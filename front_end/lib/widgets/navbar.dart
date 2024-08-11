import 'package:flutter/material.dart';
import 'package:front_end/pages/accountPage.dart';
import 'package:front_end/pages/mainPage.dart';
import 'package:front_end/pages/mapPage.dart';
import 'package:front_end/pages/subscriptionPage.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'constants.dart';
import 'package:front_end/logic/pageNavigationController.dart'; // Import the new controller

class Navbar extends StatefulWidget {
  const Navbar({Key? key}) : super(key: key);

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  final PageNavigationController _navigationController =
      PageNavigationController();

  @override
  void dispose() {
    _navigationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = _navigationController.indexPage % 2 == 0;  // Example: 
    int backgroundColorAppBar = isDarkMode ? backgroundColor : itemColor;
    Color textColor = isDarkMode ? Colors.white : Colors.black;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: Text(
          "P A R K W I S E",
          style: TextStyle(
            color: textColor, // Dynamically set the text color
          ),
        ),
        leading: SvgPicture.asset(
          'lib/assets/icons/logo.svg',
          color: textColor, // Set the icon color to match the text color
        ),
        backgroundColor: Color(backgroundColorAppBar), // Dynamically set the background color
      ),
      bottomNavigationBar: GNav(
        selectedIndex: _navigationController.indexPage,
        backgroundColor: const Color(backgroundColor),
        color: const Color(itemColor),
        activeColor: const Color(itemColorHighlighted),
        tabBackgroundColor: const Color(itemColorHighlightedTransparent),
        padding: const EdgeInsets.all(paddingValue),
        onTabChange: (indexPage) {
          _navigationController.navigateToPage(indexPage, setState);
        },
        tabs: const [
          GButton(
            icon: Icons.home,
            text: 'Home',
          ),
          GButton(
            icon: Icons.menu,
            text: 'Subscription',
          ),
          GButton(
            icon: Icons.location_pin,
            text: 'Location',
          ),
          GButton(
            icon: Icons.account_circle,
            text: 'Account',
          ),
        ],
      ),
      
      body: PageView(
        controller: _navigationController.pageController,
        physics: const NeverScrollableScrollPhysics(), // Disable swiping
        children: const [
          MainPage(),
          SubscriptionPage(),
          MapPage(),
          AccountPage(),
        ],
      ),
    );
  }
}

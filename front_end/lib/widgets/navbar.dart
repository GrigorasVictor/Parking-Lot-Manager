import 'package:flutter/material.dart';
import 'package:front_end/pages/accountPage.dart';
import 'package:front_end/pages/mainPage.dart';
import 'package:front_end/pages/mapPage.dart';
import 'package:front_end/pages/subscriptionPage.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'constants.dart';
import 'package:front_end/logic/pageNavigationController.dart'; 

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  final PageNavigationController _navigationController =
      PageNavigationController();

  final Map<int, List<Color>> _navbarColors = { // background and text
    0: [const Color(backgroundColor), Colors.white],      // Home
    1: [Colors.white, Colors.black],            // Subscription
    2: [const Color(backgroundColor), Colors.white],      // Location
    3: [const Color(backgroundColor), Colors.white],      // Account
  };

  @override
  void dispose() {
    _navigationController.dispose();
    super.dispose();
  }

  void updateNavbar(int newIndex) {
    setState(() {
      _navigationController.indexPage = newIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Get the colors for the current page
    List<Color> currentColors = _navbarColors[_navigationController.indexPage]!;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: Text(
          "P A R K W I S E",
          style: TextStyle(
            color: currentColors[1],  // Text color from the map
          ),
        ),
        leading: SvgPicture.asset(
          'lib/assets/icons/logo.svg',
          color: currentColors[1],   // Icon color from the map
        ),
        backgroundColor: currentColors[0], // Background color from the map
      ),
      bottomNavigationBar: GNav(
        selectedIndex: _navigationController.indexPage,
        backgroundColor: const Color(backgroundColor),
        color: const Color(itemColor),
        activeColor: const Color(itemColorHighlighted),
        tabBackgroundColor: const Color(itemColorHighlightedTransparent),
        padding: const EdgeInsets.all(paddingValue),
        onTabChange: (indexPage) {
          _navigationController.navigateToPage(indexPage);
          updateNavbar(indexPage);
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
        physics: const NeverScrollableScrollPhysics(),
        children: [
          MainPage(navigationController: _navigationController, updateNavbar: updateNavbar),
          const SubscriptionPage(),
          const MapPage(),
          const AccountPage(),
        ],
      ),
    );
  }
}

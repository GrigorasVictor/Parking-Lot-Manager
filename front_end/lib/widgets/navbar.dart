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
    List<bool> navbarColor = [true, false, true, true];
    int backgroundColorAppBar = navbarColor[_navigationController.indexPage] ? backgroundColor : itemColor;
    Color textColor = navbarColor[_navigationController.indexPage] ? Colors.white : Colors.black;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: Text(
          "P A R K W I S E",
          style: TextStyle(
            color: textColor, 
          ),
        ),
        leading: SvgPicture.asset(
          'lib/assets/icons/logo.svg',
          color: textColor, 
        ),
        backgroundColor: Color(backgroundColorAppBar), 
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
          MainPage(
            navigationController: _navigationController,
            updateNavbar: updateNavbar, // Passing the updateNavbar function here
          ),
          const SubscriptionPage(),
          const MapPage(),
          const AccountPage(),
        ],
      ),
    );
  }
}

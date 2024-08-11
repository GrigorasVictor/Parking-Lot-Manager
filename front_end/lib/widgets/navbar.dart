import 'package:flutter/material.dart';
import 'package:front_end/pages/accountPage.dart';
import 'package:front_end/pages/mainPage.dart';
import 'package:front_end/pages/mapPage.dart';
import 'package:front_end/pages/subscriptionPage.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'constants.dart';

class Navbar extends StatefulWidget {
  const Navbar({Key? key}) : super(key: key);

  @override
  State<Navbar> createState() => _Navbar();
}

class _Navbar extends State<Navbar> {
  int indexPage = 0;

    Widget _getPage() {
      switch (indexPage) {
        case 0:
          return const MainPage();
        case 1:
          return const SubscriptionPage();
        case 2:
          return const MapPage();
        case 3:
          return const AccountPage();
        default:
          return const MainPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: GNav(
        backgroundColor: const Color(backgroundColor),
        color: const Color(itemColor),
        activeColor: const Color(itemColorHighlighted),
        tabBackgroundColor: const Color(itemColorHighlightedTransparent),
        padding: const EdgeInsets.all(paddingValue),
        onTabChange: (index) {
          setState(() {
            indexPage = index;
          });
        }, // TODO: functions
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

      appBar: AppBar(
        toolbarHeight: 100,
        title: const Text(
          "P A R K W I S E",
          style: TextStyle(
            color: Colors.white, // Set the text color to white
          ),
        ),
        leading: SvgPicture.asset('lib/assets/icons/logo.svg'),
        backgroundColor: const Color(backgroundColor),
      ),

      body: _getPage()
    );
  }
}

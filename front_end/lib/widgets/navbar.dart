// TODO: NavBar *by Victor*
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

const backgroundColor = 0xFF33404F;
const itemColor = 0xFFFFFFFF;
const itemColorHighlighted = 0xFF00DDA3;
const itemColorHighlightedTransparent = 0x3300DDA3;
const double paddingValue = 19;

class Navbar extends StatefulWidget {
  const Navbar({Key? key}) : super(key: key);

  @override
  State<Navbar> createState() => _Navbar();
}

class _Navbar extends State<Navbar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: GNav(
        backgroundColor: const Color(backgroundColor),
        color: const Color(itemColor),
        activeColor: const Color(itemColorHighlighted),
        tabBackgroundColor: const Color(itemColorHighlightedTransparent),
        padding: const EdgeInsets.all(paddingValue),
        onTabChange: (index) {print(index);}, // TODO: functions
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
    );
  }
}

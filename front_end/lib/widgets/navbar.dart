import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:front_end/pages/accountPage.dart';
import 'package:front_end/pages/mainPage.dart';
import 'package:front_end/pages/mapPage.dart';
import 'package:front_end/pages/subscriptionPage.dart';
import 'package:front_end/logic/pageNavigationController.dart';
import 'constants.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  late final PageNavigationController _navigationController;

  @override
  void initState() {
    super.initState();
    _navigationController = PageNavigationController();
    _navigationController.addListener(_onPageChange);
  }

  @override
  void dispose() {
    _navigationController.removeListener(_onPageChange);
    _navigationController.dispose();
    super.dispose();
  }

  void _onPageChange() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = _navigationController.value % 2 == 0;
    int backgroundColorAppBar = isDarkMode ? backgroundColor : itemColor;
    Color textColor = isDarkMode ? Colors.white : Colors.black;

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
        selectedIndex: _navigationController.value,
        backgroundColor: const Color(backgroundColor),
        color: const Color(itemColor),
        activeColor: const Color(itemColorHighlighted),
        tabBackgroundColor: const Color(itemColorHighlightedTransparent),
        padding: const EdgeInsets.all(paddingValue),
        onTabChange: (indexPage) {
          _navigationController.navigateToPage(indexPage, () {
            // Optional: Handle state updates if needed
          });
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
          MainPage(navigationController: _navigationController),
          SubscriptionPage(),
          MapPage(),
          AccountPage(),
        ],
      ),
    );
  }
}

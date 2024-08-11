import 'package:flutter/material.dart';

class PageNavigationController {
  final PageController pageController = PageController();
  int indexPage = 0;
  void dispose() {
    pageController.dispose();
  }

  void navigateToPage(int index, Function setStateCallback) {
    indexPage=index;
    print(indexPage);
    setStateCallback(() {
      pageController.animateToPage(
          indexPage,
          duration: const Duration(milliseconds: 800),
          curve: Curves.fastEaseInToSlowEaseOut,
        );
    });
  }
}

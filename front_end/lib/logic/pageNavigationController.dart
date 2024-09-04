import 'package:flutter/material.dart';

class PageNavigationController extends ValueNotifier<int> {
  final PageController pageController = PageController();

  PageNavigationController() : super(0);

  void navigateToPage(int index, VoidCallback onUpdate) {
    value = index; // Update the index
    pageController.animateToPage(
      value,
      duration: const Duration(milliseconds: 800),
      curve: Curves.fastEaseInToSlowEaseOut,
    );
    onUpdate(); // Trigger the callback to update the UI
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}

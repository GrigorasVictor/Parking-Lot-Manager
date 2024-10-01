import 'dart:async'; 
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:front_end/logic/loginLogic.dart';

class EntryLoading extends StatefulWidget {
  const EntryLoading({super.key});

  @override
  _EntryLoadingState createState() => _EntryLoadingState();
}

class _EntryLoadingState extends State<EntryLoading> with SingleTickerProviderStateMixin {
  bool _showLoading = false;
  bool _showError = false; 
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    Timer(const Duration(seconds: 2), () {
      setState(() {
        _showLoading = true;
        _controller.forward();
        appEntryPoint(context);
      });
    });

    Timer(const Duration(seconds: 10), () {
      setState(() {
        _showError = true;
        _showLoading = false;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    double logoSize = width > height ? height * 0.6 : width * 0.6;

    return Scaffold(
      backgroundColor: const Color(0xFF33404F),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'lib/assets/icons/logo.svg',
              width: logoSize,
            ),
            const Text(
              "PARKWISE",
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            _showError
                ? const Text(
                    "Something went wrong. Please try again later.",
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                    ),
                  )
                : _showLoading
                    ? FadeTransition(
                        opacity: _animation,
                        child: const CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : const SizedBox.shrink(), // Empty space before showing anything
          ],
        ),
      ),
    );
  }
}

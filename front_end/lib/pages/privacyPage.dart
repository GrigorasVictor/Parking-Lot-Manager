import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PrivacyPage extends StatelessWidget {
  const PrivacyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black, 
      ),
      backgroundColor: Colors.white, 
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start, // Start from the top
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: constraints.maxWidth, 
                child: SvgPicture.asset(
                  'lib/assets/icons/securityBanner.svg',
                  width: constraints.maxWidth, 
                  fit: BoxFit.cover, 
                ),
              ),
              Expanded(
                child: Center(
                  child: Text('Additional Content Goes Here'),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
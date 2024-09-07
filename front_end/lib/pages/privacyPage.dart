import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:front_end/widgets/constants.dart';
import 'package:front_end/widgets/customListTile.dart'; // Import the custom ListTile widget

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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.stretch, // Stretch to full width
          children: [
            SvgPicture.asset(
              'lib/assets/icons/securityBanner.svg',
              width: MediaQuery.of(context).size.width, // Fill screen width
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Column(
                  children: [
                    AutoSizeText(
                      'Although we have excellent services, we want to extend these services by ensuring that your belongings, such as your car, remain safe.',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                      maxLines: 4,
                      textAlign: TextAlign.center,
                      minFontSize: 18,
                    ),
                    const SizedBox(height: 10),
                    AutoSizeText.rich(
                      TextSpan(
                        style: const TextStyle(
                          fontSize: 22,
                          color: Colors.black,
                        ),
                        children: [
                          const TextSpan(
                            text: 'Here are some ',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          TextSpan(
                            text: 'tips',
                            style: const TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const TextSpan(
                            text: ' for ',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          TextSpan(
                            text: 'protecting',
                            style: const TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const TextSpan(
                            text: ' your car from theft:',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      minFontSize: 18,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  CustomListTile(
                    icon: Icons.check_circle,
                    text: 'Always lock your car and close windows.',
                  ),
                  CustomListTile(
                    icon: Icons.check_circle,
                    text: 'Park in well-lit areas with visible surveillance.',
                  ),
                  CustomListTile(
                    icon: Icons.check_circle,
                    text: 'Use a steering wheel lock or alarm system.',
                  ),
                  CustomListTile(
                    icon: Icons.check_circle,
                    text:
                        'Never leave valuables in plain sight inside the car.',
                  ),
                  CustomListTile(
                    icon: Icons.check_circle,
                    text: 'Install a tracking device to locate your car.',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              height: 75,
              color: const Color(backgroundColor),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SvgPicture.asset(
                    'lib/assets/icons/securityLogosvg.svg',
                    width: 40, // Adjust width as needed
                    height: 40, // Adjust height as needed
                    fit: BoxFit.scaleDown, // Ensure the SVG fits within the given dimensions
                  ),
                  SvgPicture.asset(
                    'lib/assets/icons/securityLogosvg2.svg',
                    width: 40, // Adjust width as needed
                    height: 40, // Adjust height as needed
                    fit: BoxFit.scaleDown, // Ensure the SVG fits within the given dimensions
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

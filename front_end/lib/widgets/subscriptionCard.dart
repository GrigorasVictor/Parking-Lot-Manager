import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_svg/flutter_svg.dart'; 
import 'package:front_end/widgets/customButton.dart';
import 'package:intl/intl.dart'; // Import this to use DateFormat

class SubscriptionCard extends StatelessWidget {
  final double width;
  final double height;
  final String subscriptionText;
  final String expirationDate; // This will be in MM/dd/yyyy format
  final Color svgBackgroundColor;

  const SubscriptionCard({
    super.key,
    required this.width,
    required this.height,
    required this.subscriptionText,
    required this.expirationDate,
    required this.svgBackgroundColor,
  });

  // Function to calculate the days until expiration
  int calculateDaysUntilExpiration(DateTime expirationDate) {
    final today = DateTime.now();
    final difference = expirationDate.difference(today);
    return difference.inDays; // Return the difference in days
  }

  // Function to show the dialog
  void showExpirationDialog(BuildContext context) {
    // Parse the expiration date string to DateTime
    DateFormat dateFormat = DateFormat('MM/dd/yyyy');
    DateTime parsedExpirationDate;

    try {
      parsedExpirationDate = dateFormat.parse(expirationDate);
    } catch (e) {
      // Handle the error if parsing fails
      print('Error parsing date: $e');
      return; // Exit if date parsing fails
    }

    int daysLeft = calculateDaysUntilExpiration(parsedExpirationDate);

    // Show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey.shade300,
          title: const Text('Subscription Expiration'),
          content: Text(
            'Your subscription expires in $daysLeft days.',
            style: const TextStyle(fontSize: 16),
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, // Button color
              ),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('OK', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double backgroundContainerWidth = width * 0.4; 
    double svgSize = backgroundContainerWidth * 0.67; 
    double svgIconSize = svgSize * 0.67; 

    // Font and button sizes relative to the card's width
    double buttonWidth = width * 0.35; 
    double buttonHeight = height * 0.20; 
    double minButtonHeight = height * 0.20; 

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: Colors.grey.shade300,
          width: 1.0,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: backgroundContainerWidth,
            height: height,
            decoration: BoxDecoration(
              color: svgBackgroundColor, 
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(
                color: Colors.grey.shade400, 
                width: 1.0, 
              ),
            ),
            child: Center(
              child: Container(
                width: svgSize,
                height: svgSize,
                decoration: BoxDecoration(
                  color: svgBackgroundColor, 
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: SvgPicture.asset(
                    'lib/assets/icons/subsIcon.svg',
                    width: svgIconSize,
                    height: svgIconSize,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 30.0), 
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AutoSizeText(
                  subscriptionText,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4.0),
                AutoSizeText(
                  "Expires on $expirationDate",
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.grey,
                  ),
                  maxLines: 1,
                ),
                const SizedBox(height: 6.0),
                CustomElevatedButton(
                  width: buttonWidth,
                  height: buttonHeight,
                  minHeight: minButtonHeight,
                  fontSize: 2,
                  onPressed: () {
                    showExpirationDialog(context); // Show the dialog
                  },
                  label: "LEARN MORE",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_svg/flutter_svg.dart'; 
import 'package:front_end/widgets/customButton.dart';

class SubscriptionCard extends StatelessWidget {
  final double width;
  final double height;
  final String subscriptionText;
  final String expirationDate;
  final Color svgBackgroundColor;

  const SubscriptionCard({
    super.key,
    required this.width,
    required this.height,
    required this.subscriptionText,
    required this.expirationDate,
    required this.svgBackgroundColor,
  });

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
          const SizedBox(width: 5.0), 
          Expanded(
            child: 
              
              Column(
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
                      // maybe later
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

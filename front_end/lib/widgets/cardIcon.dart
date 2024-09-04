import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'constants.dart';

class CustomCardIcon extends StatefulWidget {
  const CustomCardIcon({
    super.key,
    required this.iconPath,
    this.title,
    this.height,
    this.width,
    required this.onTap,
  });

  final String iconPath; 
  final String? title;
  final double? width, height;
  final VoidCallback onTap;

  @override
  State<CustomCardIcon> createState() => _CustomCardIconState();
}

class _CustomCardIconState extends State<CustomCardIcon> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Calculate icon size based on screen dimensions
    double iconSize = screenWidth * 0.1; // 10% of screen width for icon size

    // Calculate font size based on screen dimensions
    double fontSize = screenWidth * 0.05; // 5% of screen width for font size

    return Container(
      margin: const EdgeInsets.all(16.0), // Adjust margin to your needs
      child: Center(
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.center, // Center the icon and text
          children: <Widget>[
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              elevation: 8,
              clipBehavior: Clip.hardEdge,
              child: InkWell(
                splashColor: const Color(itemColorHighlightedTransparent),
                onTap: widget.onTap,
                child: SizedBox(
                  width: widget.width ?? 200,
                  height: widget.height ?? 200,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        widget.iconPath,
                        height: iconSize,
                        width: iconSize,
                        fit: BoxFit
                            .contain, // Ensure the icon scales proportionally
                      ),
                      const SizedBox(height: 10), // Space between icon and text
                      AutoSizeText(
                        widget.title ?? 'error',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: fontSize,
                          fontWeight: FontWeight.w700,
                        ),
                        maxLines: 1, // Restricts the text to 1 line
                        overflow: TextOverflow
                            .ellipsis, // Handles text overflow with an ellipsis
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

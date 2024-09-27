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
    double iconSize = screenWidth * 0.1; 
    double fontSize = screenWidth * 0.05; 

    return Container(
      margin: const EdgeInsets.all(16.0), 
      child: Center(
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.center, 
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
                            .contain, 
                      ),
                      const SizedBox(height: 10), 
                      AutoSizeText(
                        widget.title ?? 'error',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: fontSize,
                          fontWeight: FontWeight.w700,
                        ),
                        maxLines: 1, 
                        overflow: TextOverflow
                            .ellipsis, 
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

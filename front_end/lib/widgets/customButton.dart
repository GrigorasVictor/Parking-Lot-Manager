import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart'; 

class CustomElevatedButton extends StatelessWidget {
  final double width;
  final double height;
  final double minHeight;
  final VoidCallback onPressed;
  final String label;
  final double fontSize; 

  const CustomElevatedButton({
    super.key,
    required this.width,
    required this.height,
    required this.minHeight,
    required this.onPressed,
    required this.label,
    this.fontSize = 3,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height > minHeight ? height : minHeight,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.teal,
          foregroundColor: Colors.white,
          minimumSize: Size(width, minHeight), 
        ),
        child: AutoSizeText(
          label,
          style: TextStyle(
            fontSize: fontSize, 
          ),
          maxLines: 1, 
        ),
      ),
    );
  }
}

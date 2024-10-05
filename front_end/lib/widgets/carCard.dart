import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CarCard extends StatelessWidget {
  final String descriptionText;
  final VoidCallback onClose;

  CarCard({
    Key? key,
    required this.descriptionText,
    required this.onClose,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final random = Random();
    final int randomNumber = random.nextInt(5) + 1; 
    double width = MediaQuery.of(context).size.width;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: Colors.white,
      child: Container(
        padding: const EdgeInsets.all(6),
        height: 150,
        width: width - 50,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: onClose,
                ),
              ),
            ),
            Center( // Center the content
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'lib/assets/carpacks/$randomNumber.svg', 
                    height: 80, 
                    width: 90, 
                  ),
                  const SizedBox(height: 10),
                  Container(
                    color: Colors.black54, 
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text(
                      descriptionText,
                      style: const TextStyle(
                        letterSpacing: 5,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, 
                        shadows: [
                          Shadow(
                            color: Color.fromARGB(200, 0, 0, 0),
                            offset: Offset(1, 1),
                            blurRadius: 3,
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 1, 
                      overflow: TextOverflow.ellipsis,
                    ),
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

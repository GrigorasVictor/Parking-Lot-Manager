import 'package:flutter/material.dart';

class CustomCardIcon extends StatefulWidget {
  const CustomCardIcon({
    Key? key,
    required this.icon,
    this.title,
    this.height,
    this.width,
    required this.onTap,
  }) : super(key: key);

  final Image? icon;
  final String? title;
  final double? width, height;
  final VoidCallback onTap;

  @override
  State<CustomCardIcon> createState() => _CustomCardIcon();
}

class _CustomCardIcon extends State<CustomCardIcon> {
  final double textSize = 50;
  final String font = 'Inter';
  final double iconSize = 60;

  @override
  Widget build(BuildContext context) {
    return GestureDetector( 
        onTap: widget.onTap, // TODO optional : probabil animatie sau ceva sa arate frumos cand apas
        child:
      Container(
      margin: const EdgeInsets.all(20),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Card(
              elevation: 8,
              child: SizedBox(
                  width: widget.width ?? 200,
                  height: widget.height ?? 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: iconSize,
                        width: iconSize,
                        child: widget.icon,
                      ),
                      Text(widget.title ?? 'error',
                          style: const TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 20,
                              fontWeight: FontWeight.w700)),
                    ],
                  )),
            ),
          ],
        ),
      ),
    ));
  }
}

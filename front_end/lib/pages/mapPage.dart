import 'package:flutter/material.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageIcon();
}

class _MapPageIcon extends State<MapPage> {
  final double textSize = 50;
  final String font = 'Inter';
  final double iconSize = 60;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: const Text('mappage'),
      ),
    );
  }
}

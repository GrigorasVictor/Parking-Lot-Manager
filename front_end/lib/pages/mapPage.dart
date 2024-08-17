import 'package:flutter/material.dart';
import 'package:front_end/widgets/constants.dart';
class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final double textSize = 50;
  final String font = 'Inter';
  final double iconSize = 60;

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(backgroundColor),
      body: Center(
        child: Text('mappage'),
      ),
    );
  }
}

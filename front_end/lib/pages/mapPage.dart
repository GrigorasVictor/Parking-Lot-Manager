import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart'; 
import 'package:front_end/widgets/constants.dart'; 
import 'package:auto_size_text/auto_size_text.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final double textSize = 50;
  final String font = 'Inter';
  final double iconSize = 60;

  // Coordinates for Cluj-Napoca
  final LatLng clujNapocaLatLng = LatLng(46.7712, 23.6236);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(backgroundColor), 
      body: Column(
        children: [
          // The map widget should take up most of the screen space
          Expanded(
            child: FlutterMap(
              options: MapOptions(
                initialCenter: clujNapocaLatLng, // Center map on Cluj-Napoca
                initialZoom: 13.0, 
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: ['a', 'b', 'c'],
                ),
              ],
            ),
          ),
          // The container with a height of 50
          Container(
            height: 15,
            color: Colors.grey[300], // You can change the color if needed
            child: const Center(
              child: AutoSizeText(
                "© OpenStreetMap contributors",
                style: TextStyle(fontSize: 16),
                maxLines: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

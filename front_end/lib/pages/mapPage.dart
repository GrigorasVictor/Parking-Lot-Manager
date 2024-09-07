import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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

  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(46.7712, 23.6236), // Cluj-Napoca
    zoom: 12, 
  );

  late GoogleMapController mapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(backgroundColor),
      body: GoogleMap(
        initialCameraPosition: _initialPosition,
        onMapCreated: (GoogleMapController controller) {
          mapController = controller;
        },
      ),
    );
  }

  @override
  void dispose() {
    mapController.dispose();
    super.dispose();
  }
}

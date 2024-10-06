import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:front_end/logic/httpReq.dart';
import 'package:front_end/model/parkingLot.dart';
import 'package:latlong2/latlong.dart'; 
import 'package:front_end/widgets/constants.dart'; 
import 'package:auto_size_text/auto_size_text.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final double iconSize = 40; 
  final LatLng clujNapocaLatLng = const LatLng(46.7712, 23.6236);

  // List to hold parking lots (waypoints)
  late Future<List<ParkingLot>> futureParkingLots;

  @override
  void initState() {
    super.initState();
    futureParkingLots = getParkingLots(); 
  }

  // Function to refresh parking lot data
  Future<void> _refreshParkingLots() async {
    setState(() {
      futureParkingLots = getParkingLots(); // Refresh the parking lot data
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(backgroundColor), 
      body: Column(
        children: [
          Expanded(
            // Wrap the map content with RefreshIndicator for pull-to-refresh functionality
            child: RefreshIndicator(
              onRefresh: _refreshParkingLots, // Refresh logic
              child: FutureBuilder<List<ParkingLot>>(
                future: futureParkingLots, 
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.green,
                      ),
                    );
                  }
                  final List<ParkingLot> parkingLots = snapshot.data!;

                  return FlutterMap(
                    options: MapOptions(
                      initialCenter: clujNapocaLatLng, 
                      initialZoom: 13.0,
                    ),
                    children: [
                      TileLayer(
                        urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                        subdomains: const ['a', 'b', 'c'],
                      ),
                      MarkerLayer(
                        markers: _createMarkers(parkingLots),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          Container(
            height: 15,
            color: Colors.grey[300], 
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

  // Function to create markers from the list of parking lots
  List<Marker> _createMarkers(List<ParkingLot> parkingLots) {
    return parkingLots.map((parkingLot) {
      return Marker(
        width: iconSize,
        height: iconSize,
        point: LatLng(parkingLot.lat, parkingLot.lng),
        child: Icon(
          Icons.location_on,
          color: Colors.red,
          size: iconSize,
        ),
      );
    }).toList();
  }
}

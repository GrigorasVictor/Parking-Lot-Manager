// lib/models/parking_lot.dart

class ParkingLot {
  final int id; 
  final String name;
  final String address;
  final double lat;
  final double lng;
  final int? totalParkingSpaces; 
  final int? availableParkingSpaces; 

  const ParkingLot({
    required this.id,
    required this.name,
    required this.address,
    required this.lat,
    required this.lng,
    required this.totalParkingSpaces,
    required this.availableParkingSpaces,
  });

  factory ParkingLot.fromJson(Map<String, dynamic> json) {
    return ParkingLot(
      id: json['id'] as int,
      name: json['name'] as String,
      address: json['address'] as String,
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
      totalParkingSpaces: json['totalParkingSpaces'] as int?,
      availableParkingSpaces: json['availableParkingSpaces'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'lat': lat,
      'lng': lng,
      'totalParkingSpaces': totalParkingSpaces,
      'availableParkingSpaces': availableParkingSpaces,
    };
  }

  @override
  String toString() {
    return 'ParkingLot(id: $id, name: "$name", address: "$address", '
        'lat: $lat, lng: $lng, totalParkingSpaces: $totalParkingSpaces, '
        'availableParkingSpaces: $availableParkingSpaces)';
  }
}

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
      totalParkingSpaces: json['total_parking_spaces'] as int?,
      availableParkingSpaces: json['available_parking_spaces'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'lat': lat,
      'lng': lng,
      'total_parking_spaces': totalParkingSpaces,
      'available_parking_spaces': availableParkingSpaces,
    };
  }
}

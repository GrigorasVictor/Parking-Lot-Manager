class VehicleRegistration {
  final int registrationId;
  final int userId;
  final String licencePlate;

  const VehicleRegistration({
    required this.registrationId,
    required this.userId,
    required this.licencePlate,
  });

  factory VehicleRegistration.fromJson(Map<String, dynamic> json) {
    return VehicleRegistration(
      registrationId: json['registrationId'] as int,
      userId: json['user_id'] as int,
      licencePlate: json['registration_number'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'registrationId': registrationId,
      'user_id': userId,
      'registration_number': licencePlate,
    };
  }
}

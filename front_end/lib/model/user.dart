import 'registration.dart';

class User {
  final int userId;
  final String fullName;
  final String image;
  final String email;
  final String phoneNumber;
  final List<VehicleRegistration> registrations;

  const User({
    required this.userId,
    required this.fullName,
    required this.image,
    required this.email,
    required this.phoneNumber,
    required this.registrations,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['userId'] as int,
      fullName: json['fullName'] as String,
      image: json['image'] as String,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String,
      registrations: (json['licencePlates'] as List<dynamic>)
          .map((item) =>
              VehicleRegistration.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'fullName': fullName,
      'image': image,
      'email': email,
      'phoneNumber': phoneNumber,
      'licencePlates':
          registrations.map((registration) => registration.toJson()).toList(),
    };
  }
}

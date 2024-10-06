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
      fullName: json['full_name'] as String,
      image: json['image'] as String,
      email: json['email'] as String,
      phoneNumber: json['phone_number'] as String,
      registrations: (json['licencePlates'] as List<dynamic>)
          .map((item) =>
              VehicleRegistration.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'full_name': fullName,
      'image': image,
      'email': email,
      'phone_number': phoneNumber,
      'licencePlates':
          registrations.map((registration) => registration.toJson()).toList(),
    };
  }
}

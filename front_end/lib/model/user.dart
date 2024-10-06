import 'package:front_end/model/subscription.dart';
import 'registration.dart';

class User {
  final int userId;
  final String fullName;
  final String? image;
  final String email;
  final String phoneNumber;
  final List<VehicleRegistration> registrations;
  final List<UserSubscription> subscriptions; 

  const User({
    required this.userId,
    required this.fullName,
    this.image,
    required this.email,
    required this.phoneNumber,
    required this.registrations,
    required this.subscriptions, // Added subscriptions parameter
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['userId'] as int,
      fullName: json['fullName'] as String,
      image: json['image'] as String?,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String,
      registrations: (json['licencePlates'] as List<dynamic>)
          .map((item) => VehicleRegistration.fromJson(item as Map<String, dynamic>))
          .toList(),
      subscriptions: (json['subscriptions'] as List<dynamic>) // Deserialize subscriptions
          .map((item) => UserSubscription.fromJson(item as Map<String, dynamic>))
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
      'subscriptions': subscriptions.map((subscription) => subscription.toJson()).toList(), // Serialize subscriptions
    };
  }
}

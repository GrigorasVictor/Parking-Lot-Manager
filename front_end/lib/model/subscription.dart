import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class UserSubscription {
  final int? subscriptionId;

  @JsonKey(name: 'user_id')
  final int userId;

  @JsonKey(name: 'subscription_type')
  final int subscriptionType;

  @JsonKey(name: 'start_date')
  final DateTime startDate;

  @JsonKey(name: 'end_date')
  final DateTime endDate;

  @JsonKey(name: 'parking_space')
  final int parkingSpace;

  UserSubscription({
    this.subscriptionId,
    required this.userId,
    required this.subscriptionType,
    required this.startDate,
    required this.endDate,
    required this.parkingSpace,
  });

  factory UserSubscription.fromJson(Map<String, dynamic> json) {
    return UserSubscription(
      subscriptionId: json['subscription_id'] as int?,
      userId: json['user_id'] as int,
      subscriptionType: json['subscription_type'] as int,
      startDate: DateTime.parse(json['start_date']),
      endDate: DateTime.parse(json['end_date']),
      parkingSpace: json['parking_space'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'subscription_id': subscriptionId,
      'user_id': userId,
      'subscription_type': subscriptionType,
      'start_date': startDate.toIso8601String(),
      'end_date': endDate.toIso8601String(),
      'parking_space': parkingSpace,
    };
  }

  @override
  String toString() {
    return 'UserSubscription(subscriptionId: $subscriptionId, userId: $userId, '
        'subscriptionType: $subscriptionType, startDate: $startDate, endDate: $endDate, '
        'parkingSpace: $parkingSpace)';
  }
}

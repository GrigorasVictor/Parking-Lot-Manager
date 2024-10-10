class SubscriptionPlan {
  final int id;
  final String name;
  final double price;
  final int timeLength;

  const SubscriptionPlan({
    required this.id,
    required this.name,
    required this.price,
    required this.timeLength,
  });

  // Factory constructor to create an Item from JSON
  factory SubscriptionPlan.fromJson(Map<String, dynamic> json) {
    return SubscriptionPlan(
      id: json['id'] as int,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      timeLength: json['timeLength'] as int,
    );
  }

  // Method to convert Item to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'time_length': timeLength,
    };
  }
}

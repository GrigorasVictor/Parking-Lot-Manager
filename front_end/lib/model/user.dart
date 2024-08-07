class User {
  final int userId;
  final String full_name;
  final String email;
  final String password;
  final String phone_number;

  const User({
    required this.userId,
    required this.full_name,
    required this.email,
    required this.password,
    required this.phone_number,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'userId': int userId,
        'full_name': String full_name,
        'email': String email,
        'password': String password,
        'phone_number': String phone_number,
      } => User(
          userId: userId,
          full_name: full_name,
          email: email,
          password: password,
          phone_number: phone_number,
        ),
      _ => throw const FormatException('Failed to load user.'),
    };
  }
}

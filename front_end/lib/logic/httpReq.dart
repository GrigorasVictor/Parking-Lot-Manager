import 'package:http/http.dart' as http;
import 'package:front_end/model/user.dart';
import 'dart:convert';

Future<User> getUser(int userId) async {
  final response = await http.get(Uri.http('localhost:8080', 'users/$userId'));

  if (response.statusCode == 200) {
    return User.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to load data');
  }
}

Future<User> getUserName(int userId) async {
  final response =
      await http.get(Uri.http('localhost:8080', 'users/$userId/name'));

  if (response.statusCode == 200) {
    return User.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to load data');
  }
}

Future<void> sendTransaction(
  int userId, String subscription, String price, DateTime startDate) async {
  final Uri url = Uri.http('localhost:8080', '/transactionRecord');

  // Remove the dollar sign and convert the price 
  int amountInDollars = double.parse(price.replaceAll('\$', '')).ceil();

  final Map<String, dynamic> dataToSend = {
    'userId': userId,
    'transaction_date': startDate.toIso8601String(),
    'amount': amountInDollars,
    'description': subscription,    
  };
  print(dataToSend);
  try {
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json', 
      },
      body: jsonEncode(dataToSend),
    );

    if (response.statusCode == 200) {
      print('Subscription sent successfully!');
      // Handle success (response.body contains the server response)
    } else {
      print('Failed to send subscription. Status code: ${response.statusCode}');
      // Handle error
    }
  } catch (e) {
    print('Error sending subscription: $e');
  }
}

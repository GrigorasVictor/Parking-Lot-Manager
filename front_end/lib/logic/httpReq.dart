import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:front_end/model/user.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

Future<User> getUser(int userId) async {
  final response = await http.get(Uri.http('localhost:8080', 'users/$userId'));

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

  DateFormat dateFormatter = DateFormat('yyyy-MM-dd');

  final Map<String, dynamic> dataToSend = {
    'user_id': userId,
    'transaction_date': dateFormatter.format(startDate),
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
      print('Transaction sent successfully!');
      // Handle success (response.body contains the server response)
    } else {
      print('Failed to send Transaction. Status code: ${response.statusCode}');
      // Handle error
    }
  } catch (e) {
    print('Error sending Transaction: $e');
  }
}

Future<void> sendSubscription(
    int userId, DateTime startDate, DateTime endDate, int parkingSpace) async {
  final Uri url = Uri.http('localhost:8080', '/userSubscriptions');

  DateFormat dateFormatter = DateFormat('yyyy-MM-dd');

  final Map<String, dynamic> dataToSend = {
    'user_id': userId,
    'start_date': dateFormatter.format(startDate),
    'end_date': dateFormatter.format(endDate),
    'parking_space': parkingSpace,
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

Future<void> sendNumberPlate(String numberPlate, int userId) async {
  //TODO: regex verification
  final Map<String, dynamic> dataToSend = {
    'user_id': userId,
    'registration_number': numberPlate,
  };

  final Uri url = Uri.http('localhost:8080', '/vehicleRegistration');

  try {
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(dataToSend),
    );
    if (response.statusCode == 200) {
      print('NumberPlate sent successfully!');
      // Handle success (response.body contains the server response)
    } else {
      print('Failed to send NumberPlate. Status code: ${response.statusCode}');
      // Handle error
    }
  } catch (e) {
    print('Error sending NumberPlate: $e');
  }
}

Future<void> deleteLicencePlate(String numberPlate, int userId) async {
  final String apiUrl = 'http://your-backend-api-url.com/users/$userId/licenceplates/$numberPlate';

  try {
    final response = await http.delete(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {

    } else {
      // Show error popup
    }
  } catch (e) {
    // Show error popup
  }
}
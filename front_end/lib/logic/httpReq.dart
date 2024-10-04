import 'dart:io';

import 'package:front_end/logic/jwtLogic.dart';
import 'package:front_end/logic/userSingleTon.dart';
import 'package:front_end/model/registration.dart';
import 'package:http/http.dart' as http;
import 'package:front_end/model/user.dart';
import 'package:http_parser/http_parser.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

User? user = UserSingleton.getUser();

Future<Map<String, String>> getHeaderCoockie() async {
  String cookie = await readJwtCookie();
  return {
    'Cookie': 'jwToken=$cookie',
  };
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

Future<bool> sendNumberPlate(String numberPlate) async {
  final Map<String, dynamic> dataToSend = {
    'user_id': user!.userId,
    'registration_number': numberPlate,
  };

  final Uri url = Uri.http('localhost:8080', '/vehicleRegistration');
  try {
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        ...await getHeaderCoockie(), // Spread the Map here
      },
      body: jsonEncode(dataToSend),
    );

    if (response.statusCode == 200) {
      VehicleRegistration regJson =
          VehicleRegistration.fromJson(jsonDecode(response.body));
      UserSingleton.addNumberPlate(regJson);
      return true;
    }
  } catch (e) {
    print('Error sending NumberPlate: $e');
  }
  return false;
}

Future<void> deleteLicencePlate(String numberPlate, int userId) async {
  final String apiUrl =
      'http://your-backend-api-url.com/users/$userId/licenceplates/$numberPlate';

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

Future<String> uploadImage(File image, int id) async {
  final uri = Uri.parse('https://your-server-url/upload/$id');
  final request = http.MultipartRequest('POST', uri)
    ..files.add(await http.MultipartFile.fromPath(
      'image',
      image.path,
      contentType: MediaType('image', 'jpeg'),
    ));

  try {
    final response = await request.send();
    if (response.statusCode == 200) {
      final responseData = await response.stream.bytesToString();
      final data = jsonDecode(responseData);
      return data['image_url'];
    } else {
      throw Exception('Failed to upload image: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Image upload failed: $e');
  }
}

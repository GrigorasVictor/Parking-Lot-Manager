import 'dart:io';

import 'package:front_end/logic/jwtLogic.dart';
import 'package:front_end/logic/userSingleTon.dart';
import 'package:front_end/model/parkingLot.dart';
import 'package:front_end/model/registration.dart';
import 'package:front_end/model/subscriptionPlan.dart';
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
        ...await getHeaderCoockie(),
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

Future<bool> sendSubscription(int userId, DateTime startDate, DateTime endDate, String subscriptionType) async {
  final Uri url = Uri.http('localhost:8080', '/userSubscriptions');

  DateFormat dateFormatter = DateFormat('yyyy-MM-dd');

  final Map<String, dynamic> dataToSend = {
    'user_id': userId,
    'start_date': dateFormatter.format(startDate),
    'end_date': dateFormatter.format(endDate),
    'subscription_type': subscriptionType
  };
  print(dataToSend);
  try {
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        ...await getHeaderCoockie(),
      },
      body: jsonEncode(dataToSend),
    );

    if (response.statusCode == 200) {
      return true;
    }
  } catch (e) {
    print('Error sending subscription: $e');
  }
  return false;
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
        ...await getHeaderCoockie(),
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

Future<bool> deleteLicencePlate(int id) async {
  final String apiUrl = 'http://localhost:8080/vehicleRegistration/$id';

  try {
    final response = await http.delete(
      Uri.parse(apiUrl),
      headers: {
        ...await getHeaderCoockie(),
      },
    );
    print(response.statusCode);
    if (response.statusCode == 200) return true;
  } catch (e) {}
  return false;
}

// Function to upload the image
Future<String> uploadImage(File image) async {
  final uri = Uri.parse(
      'http://localhost:8080/users/upload-photo'); 

  Map<String, String> headers = await getHeaderCoockie();

  final request = http.MultipartRequest('POST', uri)
    ..files.add(await http.MultipartFile.fromPath(
      'photo', 
      image.path,
      contentType: MediaType('image', 'png'),
    ))
    ..headers.addAll(headers);

  try {
    final response = await request.send();

    if (response.statusCode == 200) {
      final responseData = await response.stream.bytesToString();
      final data = jsonDecode(responseData);
      return data['url'];
    } else {
      throw Exception('Failed to upload image: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Image upload failed: $e');
  }
}

Future<List<ParkingLot>> getParkingLots() async {
  final Uri url = Uri.http('localhost:8080', '/parkingLot');
  try {
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        ...await getHeaderCoockie(),
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> parkingJson = jsonDecode(response.body);
      return parkingJson.map((json) => ParkingLot.fromJson(json)).toList();
    }
  } catch (e) {
    print('Error sending NumberPlate: $e');
  }
  return [];
}

Future<List<SubscriptionPlan>> getSubscriptionOptions() async { 
  final Uri url = Uri.http('localhost:8080', '/subscription-templates');
  try {
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        ...await getHeaderCoockie(),
      },
    );

    if (response.statusCode == 200) {
      print(response.body);
      List<dynamic> subscriptionPlanJSON = jsonDecode(response.body);
      return subscriptionPlanJSON.map((json) => SubscriptionPlan.fromJson(json)).toList();
    }
  } catch (e) {
    print('Error sending Subs: $e');
  }
  return [];
}

  /// Fetch photo from the server using cookies
  Future<File?> getPhoto() async {
    try {
      final Uri url = Uri.parse(user!.image!); // Ensure the image URL is valid
      final response = await http.get(
        url,
        headers: {
          ...await getHeaderCoockie(), // Add the cookie headers
        },
      );

      if (response.statusCode == 200) {
        // Save the image to a temporary file or use memory directly
        final bytes = response.bodyBytes;
        final dir = Directory.systemTemp; // Use a temporary directory
        final file = await File('${dir.path}/profile_image.png').writeAsBytes(bytes);
        return file; // Return the file
      } else {
        print('Failed to load image: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching photo: $e');
    }
    return null; // Return null if there was an error
  }
import 'package:http/http.dart' as http;

Future<void> sendRequestWithCookies(String cookies) async {
  print("aici");

  final response = await http.post(
    Uri.parse('http://localhost:8080/send'),
    headers: {'jwToken': 'successful'},
  );

  print("primit rsp");

  if (response.statusCode == 200) {
    // Handle response
    print(response.body);
  } else {
    // Handle error
    print('Request failed with status: ${response.statusCode}');
  }
}

import 'package:front_end/logic/jwtLogic.dart';
import 'package:http/http.dart' as http;

Future<void> sendRequestWithCookies(String cookies) async {
  final response = await http.post(
    Uri.parse('http://localhost:8080/send'),
    // headers: {'Cookie': 'jwToken=successful'},
  );

  print("cookies:\n");
  getJwtCookie(response.headers.values);

  if (response.statusCode == 200) {
    // Handle response
    print(response.body);
  } else {
    // Handle error
    print('Request failed with status: ${response.statusCode}');
  }
}

import 'package:front_end/logic/jwtLogic.dart';
import 'package:http/http.dart' as http;

Future<void> sendRequestWithCookies(String cookies) async {
  final response = await http.post(
    Uri.parse('http://localhost:8080/send'),
    // headers: {'Cookie': 'jwToken=successful'},
  );

  print("cookies:\n");
  String? cookie = getJwtCookie(response.headers.values);
  //storeJwtCookie(null);
  storeJwtCookie(cookie);
  String answer = await readJwtCookie();
  print("Read: ${answer}");

  if (response.statusCode == 200) {
    print(response.body);
  } else {
    print('Request failed with status: ${response.statusCode}');
  }
}

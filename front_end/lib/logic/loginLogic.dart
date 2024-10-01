import 'package:http/http.dart' as http;

// LOGIN button function
Future<void> sendLoginRequest() async {
  final response = await http.post(
    Uri.parse('http://localhost:8080/send'),
  );
}

void appEntryPoint() {
  // check if cookie

  // if NO stay on login page

  // if YES make req

  // if cookie EXP stay on login (maybe inform user)

  // if req stat == 200 GOTO main
}

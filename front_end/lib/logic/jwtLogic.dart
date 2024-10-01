import 'package:shared_preferences/shared_preferences.dart';

String? getJwtCookie(Iterable<String> cookies) {
  Iterator<String> it = cookies.iterator;
  String? curCookie;
  
  while (it.moveNext()) {
    RegExp regExp = RegExp(r"(?<=jwToken=)[^ ]*"); //match after the '=' and stop at the first ' '
    Iterable<RegExpMatch> parsedData = regExp.allMatches(it.current.toString());
    curCookie = parsedData.isNotEmpty ? parsedData.first.group(0) : null;
    if (curCookie != null) {
      break;
    }
  }
  return curCookie; 
}

void storeJwtCookie(String? cookie) async {
  if(cookie == null){
    print("The cookie trying to be stored is null\n");
    return;
  }
  
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('cookie', cookie);
}

Future<String> readJwtCookie() async{
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('cookie') ?? 'empty';
}

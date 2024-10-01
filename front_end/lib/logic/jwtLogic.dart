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

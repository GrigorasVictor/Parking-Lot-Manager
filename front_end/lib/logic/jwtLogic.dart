String? getJwtCookie(Iterable<String> cookies) {
  Iterator it = cookies.iterator;

  while (it.moveNext()) {
    String curCookie = it.current;
    print(curCookie);
  }
}

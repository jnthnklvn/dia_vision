class Utils {
  bool isValidEmail(String email) {
    if (email == null) return true;
    if (email.isEmpty) return false;
    String p =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$";
    RegExp regExp = new RegExp(p);
    final has = regExp.hasMatch(email);
    return has;
  }
}

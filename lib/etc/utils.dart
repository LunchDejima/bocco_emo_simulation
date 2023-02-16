class Utils {
  static final emailExp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  static bool validateEmail(String val) {
    return emailExp.hasMatch(val);
  }
}


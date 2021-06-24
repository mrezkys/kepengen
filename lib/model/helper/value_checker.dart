class ValueChecker {
  static bool isNullOrEmpty(dynamic value) {
    if (value == null || value == '') {
      return true;
    } else {
      return false;
    }
  }
}

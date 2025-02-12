extension Capitalize on String {
  ///Converts the first character of subject to upper case.
  ///If lowerRest is set to true, the rest of the string will be converted to lower case.
  String capitalize([bool lowerRest = false]) {
    if (length == 0) {
      return '';
    }

    if (lowerRest) {
      return this[0].toUpperCase() + substring(1).toLowerCase();
    } else {
      return this[0].toUpperCase() + substring(1);
    }
  }
}

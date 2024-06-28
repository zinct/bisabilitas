class StringUtils {
  static bool isValidEmail(String string) {
    // Null or empty string is invalid phone number
    if (string.isEmpty) {
      return false;
    }

    // You may need to change this pattern to fit your requirement.
    // I just copied the pattern from here: https://regexr.com/3c53v
    const pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    final regExp = RegExp(pattern);

    if (!regExp.hasMatch(string)) {
      return false;
    }
    return true;
  }

  static bool isValidPhoneNumber(String string) {
    // Null or empty string is invalid phone number
    if (string.isEmpty) {
      return false;
    }

    // You may need to change this pattern to fit your requirement.
    // I just copied the pattern from here: https://regexr.com/3c53v
    const pattern = r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$';
    final regExp = RegExp(pattern);

    if (!regExp.hasMatch(string)) {
      return false;
    }
    return true;
  }

  static String getCityName(String area) {
    var city = area;
    if (city.toLowerCase().startsWith('kota')) {
      city = city.substring(5);
    } else if (city.toLowerCase().startsWith('kabupaten')) {
      city = city.substring(10);
    }
    return city;
  }

  static void checkPhone(String value, Function check, Function reset) {
    if (value.startsWith('0') && (value.length == 4 || value.length >= 10)) {
      check();
    } else if (value.startsWith('+62') &&
        (value.length == 6 || value.length >= 12)) {
      check();
    } else if (value.startsWith('62') &&
        (value.length == 5 || value.length >= 11)) {
      check();
    } else if ((value.startsWith('62') && value.length < 5) ||
        (value.startsWith('+62') && value.length < 6) ||
        (value.startsWith('0') && value.length < 4)) {
      reset();
    }
  }

  static bool checkPhoneIsComplete(String value) {
    return ((value.startsWith('0') && (value.length >= 10)) ||
        (value.startsWith('+62') && (value.length >= 12)) ||
        (value.startsWith('62') && (value.length >= 11)));
  }

  static String getInitialFullName(String value) {
    final String fullName = value;
    final String firstNameInitial =
        fullName.isNotEmpty ? fullName[0].toUpperCase() : '';
    final String lastNameInitial = fullName.contains(' ')
        ? fullName[fullName.lastIndexOf(' ') + 1].toUpperCase()
        : '';
    return '$firstNameInitial$lastNameInitial';
  }
}

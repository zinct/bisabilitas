///
/// validator_utils.dart
/// lib/core/utils
///
/// Created by Indra Mahesa https://github.com/zinct
///

class ValidatorUtils {
  String? _value;
  String? _errorMessage;

  bool _isRequired = false;
  bool _isValidEmail = false;

  ValidatorUtils isRequired({String? errorMessage}) {
    _isRequired = true;

    if (_value == null || _value!.trim().isEmpty) {
      _errorMessage = errorMessage ?? 'Field ini tidak boleh kosong!';
    } else {
      _errorMessage = null;
    }

    return this;
  }

  ValidatorUtils isValidEmail({String? errorMessage}) {
    _isValidEmail = true;

    if (_value == null ||
        _value!.trim().isEmpty ||
        !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(_value!)) {
      _errorMessage = errorMessage ?? "Masukkan email dengan benar!";
    } else {
      _errorMessage = null;
    }

    return this;
  }

  String? validate(String? value) {
    _value = value;

    // Call All Chaining Method
    if (_isRequired) {
      isRequired();
    } else if (_isValidEmail) {
      isValidEmail();
    }

    return _errorMessage;
  }
}

///
/// string_extension.dart
/// lib/core/extensions
///
/// Created by Indra Mahesa https://github.com/zinct
///

extension StringExtension on String? {
  String preventNull() {
    return this ?? "";
  }

  String ifNull(String value) {
    return this ?? value;
  }
}

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';

  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');

  String jsonReadableFormat() =>
      split('_').map((element) => element.toCapitalized()).join(' ');
}

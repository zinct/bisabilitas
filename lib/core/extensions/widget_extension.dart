///
/// widget_extension.dart
/// lib/core/extensions
///
/// Created by Indra Mahesa https://github.com/zinct
///

import 'package:flutter/material.dart';

extension WidgetExtension on Widget {
  Widget debug(dynamic value) {
    debugPrint("Debug Widget From: $runtimeType");
    debugPrint(value);
    return this;
  }

  Widget isExecute(bool value) {
    return value ? this : Container();
  }
}

extension NullableWidgetExtension on Widget? {
  Widget preventNull() {
    return this ?? Container();
  }

  Widget ifNull(Widget value) {
    return this ?? value;
  }
}

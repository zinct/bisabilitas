///
/// debouncer_utils.dart
/// lib/core/utils
///
/// Created by Indra Mahesa https://github.com/zinct
///

import 'package:flutter/foundation.dart';
import 'dart:async';

class DebouncerUtils {
  Timer? _timer;

  DebouncerUtils();

  run(int milliseconds, VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}

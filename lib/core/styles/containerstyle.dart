import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../resources/colors.dart';

shadowTheme(BuildContext context) {
  return [
    BoxShadow(
      color: BaseColors.black.withOpacity(0.1),
      spreadRadius: 0.w,
      blurRadius: 4.w,
      offset: Offset(
        0.w,
        4.w,
      ),
    ),
  ];
}

shadowThemeReverse(BuildContext context) {
  return [
    BoxShadow(
      color: BaseColors.black.withOpacity(0.1),
      spreadRadius: 0.w,
      blurRadius: 4.w,
      offset: Offset(
        0.w,
        -4.w,
      ),
    ),
  ];
}

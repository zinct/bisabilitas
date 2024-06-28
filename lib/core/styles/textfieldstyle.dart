import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../resources/colors.dart';
import 'textstyles/elite_font_black.dart';
import 'textstyles/elite_font_custom.dart';

class EliteTextFieldTheme {
  final EdgeInsetsGeometry contentPadding;
  final TextStyle hintStyle, textStyle;
  final InputBorder border,
      focusedBorder,
      errorBorder,
      disabledBorder,
      focusedErrorBorder,
      enabledBorder;
  final Color? fillColor;

  const EliteTextFieldTheme({
    required this.contentPadding,
    required this.hintStyle,
    required this.textStyle,
    required this.border,
    required this.focusedBorder,
    required this.errorBorder,
    required this.disabledBorder,
    required this.focusedErrorBorder,
    required this.enabledBorder,
    this.fillColor,
  });
}

EliteTextFieldTheme defaultEliteTextFieldTheme({
  required BuildContext context,
  BorderRadius? radius,
  EdgeInsets? contentPadding,
}) {
  return EliteTextFieldTheme(
    contentPadding: contentPadding ??
        EdgeInsets.only(
          left: 15.w,
          top: 15.w,
          bottom: 15.w,
          right: 15.w,
        ),
    hintStyle: EliteFont.regular14(context, color: BaseColors.grey),
    textStyle: EliteFontBlack.regular14(context),
    border: OutlineInputBorder(
      borderRadius: radius ??
          BorderRadius.all(
            Radius.circular(8.w),
          ),
      borderSide: BorderSide(
        color: BaseColors.grey,
        width: 1.w,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: radius ??
          BorderRadius.all(
            Radius.circular(8.w),
          ),
      borderSide: BorderSide(
        color: BaseColors.primary,
        width: 1.w,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: radius ??
          BorderRadius.all(
            Radius.circular(8.w),
          ),
      borderSide: BorderSide(
        color: BaseColors.danger,
        width: 1.w,
      ),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: radius ??
          BorderRadius.all(
            Radius.circular(8.w),
          ),
      borderSide: BorderSide(
        color: BaseColors.grey,
        width: 1.w,
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: radius ??
          BorderRadius.all(
            Radius.circular(8.w),
          ),
      borderSide: BorderSide(
        color: BaseColors.primary,
        width: 1.w,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: radius ??
          BorderRadius.all(
            Radius.circular(8.w),
          ),
      borderSide: BorderSide(
        color: BaseColors.grey,
        width: 1.w,
      ),
    ),
  );
}

EliteTextFieldTheme primaryOutlinedTextFieldTheme({
  required BuildContext context,
  BorderRadius? radius,
  EdgeInsets? contentPadding,
}) {
  return EliteTextFieldTheme(
    contentPadding: contentPadding ??
        EdgeInsets.only(
          left: 15.w,
          top: 15.w,
          bottom: 15.w,
          right: 15.w,
        ),
    hintStyle: EliteFont.regular14(context, color: BaseColors.grey),
    textStyle: EliteFontBlack.regular14(context),
    border: UnderlineInputBorder(
      borderRadius: radius ??
          BorderRadius.all(
            Radius.circular(8.w),
          ),
      borderSide: BorderSide(
        color: BaseColors.grey,
        width: 1.w,
      ),
    ),
    focusedBorder: UnderlineInputBorder(
      borderRadius: radius ??
          BorderRadius.all(
            Radius.circular(8.w),
          ),
      borderSide: BorderSide(
        color: BaseColors.primary,
        width: 1.w,
      ),
    ),
    errorBorder: UnderlineInputBorder(
      borderRadius: radius ??
          BorderRadius.all(
            Radius.circular(8.w),
          ),
      borderSide: BorderSide(
        color: BaseColors.danger,
        width: 1.w,
      ),
    ),
    disabledBorder: UnderlineInputBorder(
      borderRadius: radius ??
          BorderRadius.all(
            Radius.circular(8.w),
          ),
      borderSide: BorderSide(
        color: BaseColors.grey,
        width: 1.w,
      ),
    ),
    focusedErrorBorder: UnderlineInputBorder(
      borderRadius: radius ??
          BorderRadius.all(
            Radius.circular(8.w),
          ),
      borderSide: BorderSide(
        color: BaseColors.primary,
        width: 1.w,
      ),
    ),
    enabledBorder: UnderlineInputBorder(
      borderRadius: radius ??
          BorderRadius.all(
            Radius.circular(8.w),
          ),
      borderSide: BorderSide(
        color: BaseColors.grey,
        width: 1.w,
      ),
    ),
  );
}

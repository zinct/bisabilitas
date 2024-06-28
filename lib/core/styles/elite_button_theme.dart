import 'package:flutter/material.dart';
import '../resources/colors.dart';
import 'textstyles/elite_font_primary.dart';
import 'textstyles/elite_font_white.dart';

class EliteButtonTheme {
  final Gradient? gradient;
  final BorderRadius radius;
  final TextStyle textStyle;
  final double borderWidth;
  final Color borderColor;
  final Color buttonColor;
  final List<BoxShadow>? boxShadow;

  const EliteButtonTheme({
    this.gradient,
    this.radius = const BorderRadius.all(Radius.circular(15)),
    this.textStyle = const TextStyle(
        fontSize: 12, color: Colors.white, fontWeight: FontWeight.w400),
    this.borderWidth = 0,
    this.borderColor = Colors.transparent,
    this.buttonColor = Colors.white,
    this.boxShadow,
  });
}

defaultButtonTheme({
  required BuildContext context,
  BorderRadius? radius,
  TextStyle? textStyle,
}) {
  return EliteButtonTheme(
    textStyle: textStyle ?? EliteFontWhite.medium14(context),
    radius: radius ?? const BorderRadius.all(Radius.circular(8)),
    borderWidth: 0,
    buttonColor: BaseColors.primary,
  );
}

defaultTransparentButtonTheme({
  required BuildContext context,
  BorderRadius? radius,
  TextStyle? textStyle,
}) {
  return EliteButtonTheme(
    textStyle: textStyle ?? EliteFontPrimary.medium14(context),
    radius: radius ?? const BorderRadius.all(Radius.circular(8)),
    borderWidth: 1,
    borderColor: BaseColors.primary,
    buttonColor: Colors.transparent,
  );
}

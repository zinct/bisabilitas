import 'package:flutter/material.dart';
import 'colors.dart';

class BaseGradients {
  static const primaryGradient = LinearGradient(
    colors: [
      BaseColors.primary,
      BaseColors.primaryLight,
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const primaryGradient2 = LinearGradient(
    colors: [
      BaseColors.primary,
      BaseColors.primaryLight,
    ],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
  );

  static const primaryGradient3 = LinearGradient(
    colors: [
      Color(0xFF50AE29),
      Color(0xFF81E05A),
    ],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
  );

  static const secondaryGradient = LinearGradient(
    colors: [
      BaseColors.secondary,
      BaseColors.secondaryLight,
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const secondaryGradient2 = LinearGradient(
    colors: [
      BaseColors.secondary,
      BaseColors.secondaryLight,
    ],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
  );
}

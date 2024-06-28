import 'package:flutter/material.dart';

class BaseShadows {
  static List<BoxShadow> primary = [
    BoxShadow(
      blurRadius: 4,
      offset: const Offset(0, 4),
      color: Colors.black.withOpacity(.05),
    ),
  ];

  static List<BoxShadow> topOnly = [
    BoxShadow(
        offset: Offset(0, 10),
        blurRadius: 8,
        spreadRadius: 9,
        color: Colors.black.withOpacity(.08)),
  ];

  static List<BoxShadow> debug = [
    const BoxShadow(
      blurRadius: 4,
      offset: Offset(10, 4),
      color: Colors.amber,
    ),
  ];
}

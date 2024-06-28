import 'package:flutter/material.dart';

import '../../resources/colors.dart';

class PrimaryProgressIndicator extends StatelessWidget {
  final Color? color;

  const PrimaryProgressIndicator({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      color: color ?? BaseColors.primary,
    );
  }
}

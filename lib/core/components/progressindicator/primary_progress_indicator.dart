import 'package:bisabilitas/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';

import '../../resources/colors.dart';

class PrimaryProgressIndicator extends StatelessWidget {
  final Color? color;

  const PrimaryProgressIndicator({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      color: color ?? const Color(0xFF995F25),
    );
  }
}

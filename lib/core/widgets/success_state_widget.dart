import 'package:flutter/material.dart';

class SuccessStateWidget extends StatelessWidget {
  final bool isEmpty;
  final WidgetBuilder emptyWidget;
  final WidgetBuilder child;

  const SuccessStateWidget({
    super.key,
    required this.isEmpty,
    required this.emptyWidget,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return isEmpty ? emptyWidget(context) : child(context);
  }
}

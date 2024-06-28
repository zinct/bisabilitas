import 'package:flutter/material.dart';

class TouchableOpacityWidget extends StatefulWidget {
  final Widget child;
  final Function() onTap;
  final Duration duration = const Duration(milliseconds: 50);
  final double opacity = 0.5;

  const TouchableOpacityWidget(
      {Key? key, required this.child, required this.onTap})
      : super(key: key);

  @override
  _TouchableOpacityWidgetState createState() => _TouchableOpacityWidgetState();
}

class _TouchableOpacityWidgetState extends State<TouchableOpacityWidget> {
  late bool isDown;

  @override
  void initState() {
    super.initState();
    setState(() => isDown = false);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => isDown = true),
      onTapUp: (_) => setState(() => isDown = false),
      onTapCancel: () => setState(() => isDown = false),
      onTap: widget.onTap,
      child: AnimatedOpacity(
        duration: widget.duration,
        opacity: isDown ? widget.opacity : 1,
        child: widget.child,
      ),
    );
  }
}

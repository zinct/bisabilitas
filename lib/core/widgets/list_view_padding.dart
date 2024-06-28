import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../extensions/double_extension.dart';

enum ListItemsPaddingType { horizontal, vertical }

class ListItemsPadding extends StatelessWidget {
  final int index;
  final Widget child;
  final ListItemsPaddingType type;
  final double? verticalPadding;
  final double? horizontalPadding;

  const ListItemsPadding({
    super.key,
    required this.index,
    required this.child,
    this.type = ListItemsPaddingType.vertical,
    this.verticalPadding,
    this.horizontalPadding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: type == ListItemsPaddingType.horizontal
          ? EdgeInsets.only(
              left: index == 0 ? 20.w : 0,
              right: horizontalPadding ?? 20.w,
            )
          : EdgeInsets.only(
              top: index == 0 ? verticalPadding.ifNull(0) : 20.w,
              bottom: verticalPadding.ifNull(0).w,
            ),
      child: child,
    );
  }
}

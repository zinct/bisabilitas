import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../resources/colors.dart';
import '../../styles/textstyles/elite_font_primary.dart';
import '../../widgets/touchable_opacity_widget.dart';

enum PrimaryOutlinedButtonType { adaptive, mini }

class PrimaryOutlinedButton extends StatelessWidget {
  final double width;
  final double? height;
  final GestureTapCallback onTap;
  final String text;
  final Widget? prefix;
  final double? prefixSpacing;
  final Widget? suffix;
  final PrimaryOutlinedButtonType type;
  final BorderRadius? borderRadius;
  final Border? border;
  final Color? backgroundColor;
  final Color? color;
  final List<BoxShadow>? boxShadow;
  final TextStyle? textStyle;
  final bool isLoading;

  const PrimaryOutlinedButton({
    Key? key,
    required this.onTap,
    required this.text,
    this.width = double.infinity,
    this.height,
    this.type = PrimaryOutlinedButtonType.adaptive,
    this.isLoading = false,
    this.prefix,
    this.suffix,
    this.prefixSpacing,
    this.borderRadius,
    this.border,
    this.backgroundColor,
    this.boxShadow,
    this.textStyle,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TouchableOpacityWidget(
      onTap: onTap,
      child: Container(
        width: type == PrimaryOutlinedButtonType.mini ? null : width,
        height: height,
        padding: EdgeInsets.symmetric(
          vertical: 9.w,
          horizontal: type == PrimaryOutlinedButtonType.mini ? 20.w : 0.0,
        ),
        decoration: BoxDecoration(
          borderRadius: borderRadius ?? BorderRadius.circular(8),
          border: border ??
              Border.all(
                color: backgroundColor ?? BaseColors.primary,
              ),
          color: backgroundColor ?? Colors.transparent,
          boxShadow: boxShadow,
        ),
        child: ClipRRect(
          borderRadius: borderRadius ?? BorderRadius.circular(8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Visibility(
                visible: prefix != null,
                child: Container(
                  margin: EdgeInsets.only(
                    right: prefixSpacing ?? 11.w,
                  ),
                  child: prefix,
                ),
              ),
              Text(
                text,
                style: textStyle ?? EliteFontPrimary.medium14(context),
              ),
              Visibility(
                visible: suffix != null,
                child: Container(
                  child: suffix,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

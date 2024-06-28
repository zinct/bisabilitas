import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../resources/colors.dart';
import '../../styles/textstyles/elite_font_white.dart';
import '../../widgets/touchable_opacity_widget.dart';
import '../progressindicator/primary_progress_indicator.dart';

enum PrimaryButtonType { adaptive, mini }

class PrimaryButton extends StatelessWidget {
  final double width;
  final double? height;
  final GestureTapCallback onTap;
  final String text;
  final Widget? prefix;
  final double? prefixSpacing;
  final Widget? suffix;
  final PrimaryButtonType type;
  final BorderRadius? borderRadius;
  final Border? border;
  final Color? backgroundColor;
  final Color? color;
  final List<BoxShadow>? boxShadow;
  final TextStyle? textStyle;
  final bool isLoading;
  final bool isDisabled;

  const PrimaryButton({
    Key? key,
    required this.onTap,
    required this.text,
    this.width = double.infinity,
    this.height,
    this.type = PrimaryButtonType.adaptive,
    this.isLoading = false,
    this.isDisabled = false,
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
      onTap: !isDisabled ? onTap : () {},
      child: Container(
        width: type == PrimaryButtonType.mini ? null : width,
        height: height,
        padding: EdgeInsets.symmetric(
          vertical: 9.w,
          horizontal: type == PrimaryButtonType.mini ? 20.w : 0.0,
        ),
        decoration: BoxDecoration(
          borderRadius: borderRadius ?? BorderRadius.circular(8),
          border: border,
          color: isDisabled
              ? backgroundColor?.withOpacity(.3) ??
                  BaseColors.primary.withOpacity(.3)
              : backgroundColor ?? BaseColors.primary,
          boxShadow: boxShadow,
        ),
        child: ClipRRect(
          borderRadius: borderRadius ?? BorderRadius.circular(8),
          child: type == PrimaryButtonType.mini
              ? IntrinsicWidth(
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
                      isLoading
                          ? Center(
                              child: SizedBox(
                                height: 20.w,
                                width: 20.w,
                                child: const PrimaryProgressIndicator(
                                  color: Colors.white,
                                ),
                              ),
                            )
                          : Text(
                              text,
                              style: textStyle ??
                                  EliteFontWhite.medium14(context).copyWith(
                                      color: color ?? BaseColors.white),
                            ),
                      Visibility(
                        visible: suffix != null,
                        child: Container(
                          child: suffix,
                        ),
                      ),
                    ],
                  ),
                )
              : Row(
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
                    isLoading
                        ? Center(
                            child: SizedBox(
                              height: 20.w,
                              width: 20.w,
                              child: const PrimaryProgressIndicator(
                                color: Colors.white,
                              ),
                            ),
                          )
                        : Text(
                            text,
                            style: textStyle ??
                                EliteFontWhite.medium14(context)
                                    .copyWith(color: color ?? BaseColors.white),
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

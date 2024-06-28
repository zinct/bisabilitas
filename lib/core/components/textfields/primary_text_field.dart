import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../extensions/widget_extension.dart';
import '../../resources/colors.dart';
import '../../styles/textfieldstyle.dart';
import '../../widgets/touchable_opacity_widget.dart';

class PrimaryTextField extends StatefulWidget {
  final GestureTapCallback? onTap;
  final String hintText;
  final bool isHidden, isMultiLine, enabled, readOnly;
  final TextInputType keyboardType;
  final Function(String? value)? onSaved;
  final Function(String value)? onChanged;
  final String? Function(String? value)? validator;
  final TextInputAction? textInputAction;
  final TextEditingController? controller;
  final Widget? prefix;
  final Widget? suffix;
  final EliteTextFieldTheme? theme;
  final TextAlign textAlign;
  final FocusNode? focusNode;

  const PrimaryTextField({
    Key? key,
    this.hintText = '',
    this.isHidden = false,
    this.isMultiLine = false,
    this.keyboardType = TextInputType.text,
    this.onSaved,
    this.onChanged,
    this.validator,
    this.textInputAction,
    this.controller,
    this.enabled = true,
    this.prefix,
    this.suffix,
    this.theme,
    this.textAlign = TextAlign.start,
    this.onTap,
    this.readOnly = false,
    this.focusNode,
  }) : super(key: key);

  @override
  State<PrimaryTextField> createState() {
    return _PrimaryTextFieldState();
  }
}

class _PrimaryTextFieldState extends State<PrimaryTextField> {
  bool isTextShown = false;
  Widget? sf;

  @override
  void initState() {
    super.initState();
    sf = widget.suffix;
    if (widget.isHidden) {
      isTextShown = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    EliteTextFieldTheme? theme;
    if (widget.theme != null) {
      theme = widget.theme;
    } else {
      theme = defaultEliteTextFieldTheme(context: context);
    }
    return TouchableOpacityWidget(
      onTap: () {},
      child: SizedBox(
        width: double.infinity,
        child: TextFormField(
          readOnly: widget.readOnly,
          onTap: widget.onTap,
          style: theme?.textStyle,
          textAlign: widget.textAlign,
          decoration: InputDecoration(
            isDense: true,
            filled: theme?.fillColor != null,
            fillColor: theme?.fillColor,
            border: theme?.border,
            focusedBorder: theme?.focusedBorder,
            errorBorder: theme?.errorBorder,
            disabledBorder: theme?.disabledBorder,
            focusedErrorBorder: theme?.focusedErrorBorder,
            enabledBorder: theme?.enabledBorder,
            hintText: widget.hintText,
            hintStyle: theme?.hintStyle,
            contentPadding: theme?.contentPadding,
            hintMaxLines: 1,
            prefixIcon: Padding(
              padding: EdgeInsets.only(
                right: 10.w,
                left: 10.w,
              ),
              child: widget.prefix,
            ),
            prefixIconConstraints: BoxConstraints(
              maxHeight: 30.w,
            ),
            suffixIcon: Padding(
              padding: EdgeInsets.only(right: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  widget.suffix.preventNull(),
                ],
              ),
            ),
            suffixIconConstraints: BoxConstraints(
              maxHeight: 18.w,
            ),
          ),
          obscureText: widget.isHidden,
          cursorColor: BaseColors.primary,
          maxLines: widget.isMultiLine ? 4 : 1,
          keyboardType: widget.keyboardType,
          onChanged: widget.onChanged,
          onSaved: widget.onSaved,
          validator: widget.validator,
          textInputAction: widget.textInputAction,
          controller: widget.controller,
          enabled: widget.enabled,
          focusNode: widget.focusNode,
        ),
      ),
    );
  }
}

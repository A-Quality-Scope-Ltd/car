import 'package:flutter/material.dart';
import '../model/color_app.dart';
import '../model/size_app.dart';

// ignore: must_be_immutable
class TextFieldApp extends StatelessWidget {
  String? labelText;
  String? hintText;
  double? width;
  double? height;
  TextStyle? style;
  TextStyle? hintStyle;
  double? labelFontSize;
  double? hintFontSize;
  Widget? prefixIcon;
  EdgeInsetsGeometry? margin;
  TextEditingController? controller;
  FocusNode? focusNode;
  TextInputType? keyboardType;
  TextAlign textAlign;
  int? maxLength;
  int? maxLines;
  int? minLines;
  Widget? suffixIcon;
  void Function(String)? onChanged;
  void Function()? onEditingComplete;
  String? Function(String?)? validator;

  TextFieldApp({
    super.key,
    this.labelText,
    this.hintText,
    this.width,
    this.height,
    this.style,
    this.hintStyle,
    this.margin,
    this.labelFontSize,
    this.hintFontSize,
    this.prefixIcon,
    this.controller,
    this.focusNode,
    this.keyboardType,
    this.textAlign = TextAlign.start,
    this.maxLength,
    this.maxLines,
    this.minLines,
    this.suffixIcon,
    this.onChanged,
    this.onEditingComplete,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      width: width ?? SizeApp.width * 0.05,
      child: TextFormField(
        onEditingComplete: onEditingComplete,
        cursorColor: bordarColor,
        textAlign: textAlign,
        style: style,
        maxLength: maxLength,
        maxLines: maxLines ?? 1,
        minLines: minLines,
        decoration: InputDecoration(
          contentPadding:
              EdgeInsets.fromLTRB(12, height ?? SizeApp.height * 0.02, 12, 0),
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          prefixIconColor: whiteColor,
          labelText: labelText,
          hintText: hintText,
          hintStyle: hintStyle ??
              TextStyle(
                fontSize: hintFontSize ?? SizeApp.textSize * 1.3,
              ),
          labelStyle: TextStyle(
            fontSize: labelFontSize ?? SizeApp.textSize * 0.08,
          ),
          errorStyle: TextStyle(
            fontSize: SizeApp.textSize * 0.9,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(SizeApp.buttonRadius),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(SizeApp.buttonRadius),
            ),
            borderSide: BorderSide(
              color: bordarColor.withOpacity(0.5),
              width: SizeApp.width * 0.002,
            ),
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(SizeApp.buttonRadius),
              ),
              borderSide: BorderSide(
                color: primaryColor,
                width: SizeApp.width * 0.002,
              )),
        ),
        keyboardType: keyboardType,
        controller: controller,
        focusNode: focusNode,
        onChanged: onChanged,
        validator: validator,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../model/size_app.dart';

// ignore: must_be_immutable
class ButtonApp extends StatelessWidget {
  final VoidCallback? onPressed;
  final String buttonText;
  final bool transparent;
  EdgeInsets? margin;
  final double? height;
  final double? width;
  final double? fontSize;
  final double radius;
  final double? elevation;
  final IconData? icon;
  final double? wordSpacing;
  final Color? color;
  final Color? colorText;
  FontWeight? fontWeight;

  ButtonApp({
    super.key,
    this.onPressed,
    required this.buttonText,
    required this.color,
    this.colorText,
    this.transparent = false,
    this.margin,
    this.width,
    this.height,
    this.fontSize,
    this.radius = 5,
    this.elevation,
    this.icon,
    this.wordSpacing = 0,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      backgroundColor: color,
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
    );

    return Card(
      elevation: elevation ?? 4,
      child: SizedBox(
          width: width ?? SizeApp.width * 0.8,
          height: height ?? SizeApp.height * 0.06,
          child: TextButton(
            onPressed: onPressed,
            style: flatButtonStyle,
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              icon != null
                  ? Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Icon(icon,
                          color: transparent
                              ? Theme.of(context).primaryColor
                              : Theme.of(context).cardColor),
                    )
                  : const SizedBox(),
              Text(buttonText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: transparent
                          ? Theme.of(context).primaryColor
                          : colorText ?? Theme.of(context).cardColor,
                      fontSize: fontSize ?? SizeApp.textSize * 2.1,
                      wordSpacing: wordSpacing,
                      fontWeight: fontWeight)),
            ]),
          )),
    );
  }
}

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class TextApp extends StatelessWidget {
  final String text;
  final double size;
  final FontWeight fontWeight;
  final Color color;
  final double wordSpacing;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int? maxLines;
  final VoidCallback? onClick;

  const TextApp({
    super.key,
    required this.text,
    required this.size,
    required this.fontWeight,
    required this.color,
    this.wordSpacing = 0,
    this.textAlign,
    this.overflow,
    this.maxLines,
    this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: onClick == null
          ? AutoSizeText(
              text,
              textAlign: textAlign,
              overflow: overflow,
              maxLines: maxLines,
              style: TextStyle(
                fontSize: size,
                fontWeight: fontWeight,
                color: color,
                wordSpacing: wordSpacing,
              ),
            )
          : TextButton(
              onPressed: () {
                onClick!.call();
              },
              child: Text(
                text,
                textAlign: textAlign,
                overflow: overflow,
                maxLines: maxLines,
                style: TextStyle(
                  fontSize: size,
                  fontWeight: fontWeight,
                  color: color,
                  wordSpacing: wordSpacing,
                ),
              ),
            ),
    );
  }
}

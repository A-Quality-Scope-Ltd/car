import 'package:flutter/material.dart';

class SizeApp {
  static double width = 0.0;
  static double height = 0.0;
  static double textSize = 0.0;
  static double iconSize = 0.0;
  static double dilogRadius = 20.0;
  static double cardRadius = 15.0;
  static double buttonRadius = 10.0;
  static double padding = 12.0;

  static void initializeSize(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    textSize = width * 0.04;
    iconSize = width * 0.07;
    buttonRadius = width * 0.025;
  }
}

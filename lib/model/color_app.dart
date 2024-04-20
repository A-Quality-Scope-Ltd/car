import 'package:flutter/material.dart';

Color splachScreenColor = const Color(0xff1AA7EC);
Color primaryColor = const Color(0xff3A9CC3);
Color redColor = const Color(0xff2D61AB);
Color bigTextColor = const Color(0xff000000);
Color smolleTextColor = const Color(0xff7C7C7C);
Color bordarColor = const Color(0xff7C7C7C).withOpacity(0.5);
Color whiteColor = const Color(0xffffffff);
Color whiteColorProduct = const Color(0xfff2f3f2);
ColorScheme appColor = ColorScheme.fromSeed(seedColor: primaryColor);
ThemeData appThemeData = ThemeData(fontFamily: 'Baloo Bhaijaan 2').copyWith(
  useMaterial3: true,
  colorScheme: appColor,
);

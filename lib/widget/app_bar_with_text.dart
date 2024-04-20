import 'package:flutter/material.dart';
import '../model/color_app.dart';
import '../model/size_app.dart';
import '../widget/text.dart';

// ignore: must_be_immutable
class AppBarWithText extends StatelessWidget {
  String title;
  AppBarWithText({
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeApp.width,
      height: SizeApp.height * 0.07,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                size: SizeApp.iconSize,
              )),
          TextApp(
              text: title,
              size: SizeApp.textSize * 2,
              fontWeight: FontWeight.normal,
              color: bigTextColor),
          SizedBox(width: SizeApp.width * 0.13),
        ],
      ),
    );
  }
}

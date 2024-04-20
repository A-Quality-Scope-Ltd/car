import 'package:flutter/material.dart';
import '../model/color_app.dart';
import '../model/size_app.dart';
import '../widget/text.dart';

// ignore: must_be_immutable
class TabBarApp extends StatelessWidget {
  String titleTab1;
  String titleTab2;
  String? titleTab3;
  String? titleTab4;
  double? size;

  TabBarApp({
    super.key,
    required this.titleTab1,
    required this.titleTab2,
    this.titleTab3,
    this.titleTab4,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return TabBar(
      indicatorColor: primaryColor,
      indicatorSize: TabBarIndicatorSize.tab,
      indicatorWeight: 5,
      dividerColor: whiteColor,
      tabs: [
        Tab(
          child: TextApp(
              text: titleTab1,
              size: size ?? SizeApp.textSize * 1.4,
              fontWeight: FontWeight.normal,
              textAlign: TextAlign.center,
              color: bigTextColor),
        ),
        Tab(
          child: TextApp(
              text: titleTab2,
              size: size ?? SizeApp.textSize * 1.4,
              fontWeight: FontWeight.normal,
              textAlign: TextAlign.center,
              color: bigTextColor),
        ),
        if (titleTab3 != null)
          Tab(
            child: TextApp(
                text: titleTab3!,
                size: size ?? SizeApp.textSize * 1.4,
                fontWeight: FontWeight.normal,
                textAlign: TextAlign.center,
                color: bigTextColor),
          ),
        if (titleTab4 != null)
          Tab(
            child: TextApp(
                text: titleTab4!,
                size: size ?? SizeApp.textSize * 1.4,
                fontWeight: FontWeight.normal,
                textAlign: TextAlign.center,
                color: bigTextColor),
          ),
      ],
    );
  }
}

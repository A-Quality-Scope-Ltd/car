import 'package:flutter/material.dart';
import '../model/size_app.dart';

// ignore: must_be_immutable
class AppBarWithButtonBack extends StatelessWidget {
  const AppBarWithButtonBack({
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
              ))
        ],
      ),
    );
  }
}

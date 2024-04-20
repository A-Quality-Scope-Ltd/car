import 'package:flutter/material.dart';

import '../../../model/size_app.dart';

class AppBarAdmin extends StatelessWidget {
  const AppBarAdmin({
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
                Scaffold.of(context).openDrawer();
              },
              icon: Icon(
                Icons.menu,
                size: SizeApp.iconSize,
              )),
          Image.asset('assets/images/logo.png', width: SizeApp.iconSize * 5),
        ],
      ),
    );
  }
}

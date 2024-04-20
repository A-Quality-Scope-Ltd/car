import 'package:flutter/material.dart';
import '../model/color_app.dart';
import '../model/size_app.dart';
import '../screens/search_page.dart';
import '../screens/sign_up.dart';
import '../widget/text.dart';

class AppBarSearch extends StatelessWidget {
  const AppBarSearch({
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
          GestureDetector(
            child: Container(
              margin: EdgeInsets.only(left: SizeApp.width * 0.02),
              padding: EdgeInsets.only(right: SizeApp.width * 0.02),
              height: SizeApp.height * 0.06,
              width: SizeApp.width * 0.75,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(SizeApp.cardRadius),
                color: Colors.grey.withOpacity(0.4),
              ),
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                SizedBox(
                  width: SizeApp.width * 0.02,
                ),
                Icon(Icons.search, size: SizeApp.iconSize),
                TextApp(
                    text: ' بحث',
                    size: SizeApp.textSize * 1.5,
                    fontWeight: FontWeight.normal,
                    color: smolleTextColor),
              ]),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SearchPage()),
              );
            },
          ),
          GestureDetector(
            child: CircleAvatar(
              radius: SizeApp.width * 0.07,
              backgroundColor: Colors.grey.withOpacity(0.4),
              child: Icon(Icons.person, size: SizeApp.width * 0.10),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SignUp()),
              );
            },
          ),
        ],
      ),
    );
  }
}

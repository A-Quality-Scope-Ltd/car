import 'package:flutter/material.dart';
import '../model/color_app.dart';
import '../model/sharedpreferances/sharedpreferances_keys_.dart';
import '../model/sharedpreferances/sharedpreferences_users.dart';
import '../model/size_app.dart';
import '../screens/search_product_page.dart';
import '../widget/text.dart';
import '../widget/text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<String> recentSearches = [];
  TextEditingController controller = TextEditingController();
  Future<void> loadListFromPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      recentSearches =
          prefs.getStringList(SharedPreferencesKeys.listSearches) ?? [];
    });
  }

  @override
  void initState() {
    loadListFromPrefs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool addToList = true;
    return Scaffold(
      backgroundColor: whiteColor,
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: EdgeInsets.fromLTRB(
              SizeApp.padding, SizeApp.height * 0.07, SizeApp.padding, 0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
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
                    TextFieldApp(
                      controller: controller,
                      width: SizeApp.width * 0.78,
                      hintText: 'بحث',
                      style: TextStyle(fontSize: SizeApp.textSize * 1.2),
                      keyboardType: TextInputType.text,
                      textAlign: TextAlign.start,
                      prefixIcon: Icon(
                        Icons.search,
                        color: bordarColor,
                        size: SizeApp.iconSize,
                      ),
                      onEditingComplete: () {
                        for (var i = 0; i < recentSearches.length; i++) {
                          if (recentSearches[i] == controller.text) {
                            addToList = false;
                          }
                        }
                        if (addToList && controller.text.isNotEmpty) {
                          recentSearches.add(controller.text);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SearchProductPage(
                                      textSearch: controller.text,
                                    )),
                          );
                          SharedPreferencesSignup()
                              .saveListSearches(value: recentSearches);
                          setState(() {});
                        }
                      },
                    ),
                  ],
                ),
                SizedBox(height: SizeApp.height * 0.03),
                Container(
                  height: SizeApp.height * 0.8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(SizeApp.dilogRadius),
                    border: Border.all(
                        color: bordarColor, width: SizeApp.width * 0.002),
                    color: whiteColor,
                  ),
                  child: Column(children: [
                    SizedBox(height: SizeApp.height * 0.02),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: SizeApp.width * 0.07),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextApp(
                              text: 'عمليات البحث الأخيرة',
                              size: SizeApp.textSize * 1.2,
                              fontWeight: FontWeight.normal,
                              color: bigTextColor),
                          TextApp(
                            text: 'مسح',
                            size: SizeApp.textSize * 1.2,
                            fontWeight: FontWeight.normal,
                            color: redColor,
                            onClick: () {
                              recentSearches.clear();
                              SharedPreferencesSignup()
                                  .saveListSearches(value: recentSearches);
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: SizeApp.height * 0.02),
                    ...recentSearches.reversed
                        .map((item) => Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: SizeApp.width * 0.07),
                              child: Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SearchProductPage(
                                                    textSearch: item,
                                                  )));
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        TextApp(
                                            text: item,
                                            size: SizeApp.textSize * 1.4,
                                            fontWeight: FontWeight.normal,
                                            color: smolleTextColor),
                                        Icon(
                                          Icons.arrow_outward_rounded,
                                          size: SizeApp.iconSize,
                                          color: bordarColor,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    color: bordarColor.withOpacity(0.3),
                                  ),
                                ],
                              ),
                            ))
                        .toList(),
                  ]),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

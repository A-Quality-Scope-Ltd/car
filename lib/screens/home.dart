import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../model/color_app.dart';
import '../model/data_information/product_info.dart';
import '../model/size_app.dart';
import '../screens/product.dart';
import '../screens/category_page.dart';
import '../widget/app_bar_search.dart';
import '../widget/product_item.dart';
import '../widget/text.dart';

// ignore: must_be_immutable
class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List categoryNames = [
    'الأكل الشعبي',
    'حلويات',
    'الأكل الصحي',
    'الأطباق المنوعة',
    'الحرف اليدوية',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: EdgeInsets.fromLTRB(
              SizeApp.padding, SizeApp.height * 0.07, SizeApp.padding, 0),
          child: Column(
            children: [
              const AppBarSearch(),
              Expanded(
                child: SizedBox(
                  height: SizeApp.height * 0.8,
                  child: SingleChildScrollView(
                    child: Column(children: [
                      categories(
                          context: context,
                          classification: categoryNames[0],
                          image: 'assets/images/logo.png',
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CategoryPage(title: categoryNames[0]),
                                ));
                          }),
                      categories(
                          context: context,
                          classification: categoryNames[1],
                          image: 'assets/images/logo.png',
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CategoryPage(title: categoryNames[1]),
                                ));
                          }),
                      categories(
                          context: context,
                          classification: categoryNames[2],
                          image: 'assets/images/logo.png',
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CategoryPage(title: categoryNames[2]),
                                ));
                          }),
                      categories(
                          context: context,
                          classification: categoryNames[3],
                          image: 'assets/images/logo.png',
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CategoryPage(title: categoryNames[3]),
                                ));
                          }),
                      categories(
                          context: context,
                          classification: categoryNames[4],
                          image: 'assets/images/logo.png',
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CategoryPage(title: categoryNames[4]),
                                ));
                          }),
                    ]),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget categories(
      {required String image,
      required String classification,
      required void Function() onTap,
      context}) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            margin: EdgeInsets.only(top: SizeApp.height * 0.01),
            height: SizeApp.height * 0.1,
            width: SizeApp.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(SizeApp.dilogRadius),
              color: splachScreenColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextApp(
                    text: classification,
                    size: SizeApp.textSize * 1.5,
                    fontWeight: FontWeight.normal,
                    color: bigTextColor),
                SizedBox(width: SizeApp.width * 0.03),
                Image.asset(image, width: SizeApp.width * 0.3),
                SizedBox(width: SizeApp.width * 0.02),
              ],
            ),
          ),
        ),
        SizedBox(
            height: SizeApp.height * 0.31,
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('Products')
                    .where('agree', isEqualTo: true)
                    .where('productClassification', isEqualTo: classification)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: Container(
                          alignment: Alignment.topCenter,
                          margin: const EdgeInsets.only(top: 20),
                          child: CircularProgressIndicator(
                            backgroundColor: smolleTextColor,
                            color: primaryColor,
                          )),
                    );
                  } else if (snapshot.data!.docs.isNotEmpty) {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.zero,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        ProductInfo searchResults = ProductInfo.fromJson(
                            snapshot.data!.docs[index].data());
                        return Container(
                          margin: const EdgeInsets.only(left: 15),
                          child: ProductItem(
                              data: searchResults,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Product(
                                            resultsProduct: searchResults,
                                          )),
                                );
                              }),
                        );
                      },
                    );
                  } else {
                    return Center(
                      child: TextApp(
                          text: 'لاتوجد منتجات',
                          size: SizeApp.textSize * 1.5,
                          fontWeight: FontWeight.normal,
                          textAlign: TextAlign.center,
                          color: bigTextColor),
                    );
                  }
                }))
      ],
    );
  }
}

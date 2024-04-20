import 'dart:io';
import 'package:car/screens/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../model/color_app.dart';
import '../model/data_information/product_info.dart';
import '../model/provider_app.dart';
import '../model/size_app.dart';
import '../widget/app_bar_with_text.dart';
import '../widget/product_item.dart';
import '../widget/text.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class CategoryPage extends StatelessWidget {
  String title;
  CategoryPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    ProviderApp dataProvide = Provider.of<ProviderApp>(context);
    return Scaffold(
      backgroundColor: whiteColor,
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: EdgeInsets.fromLTRB(0, SizeApp.height * 0.07, 0, 0),
          child: Column(
            children: [
              Padding(
                padding:
                    EdgeInsets.fromLTRB(SizeApp.padding, 0, SizeApp.padding, 0),
                child: AppBarWithText(title: title),
              ),
              SizedBox(height: SizeApp.height * 0.015),
              Expanded(
                  flex: 2,
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('Products')
                        .where('agree', isEqualTo: true)
                        .where('productClassification', isEqualTo: title)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Align(
                          alignment: snapshot.data!.docs.length == 1
                              ? Alignment.topRight
                              : Alignment.topCenter,
                          child: SingleChildScrollView(
                            child: Wrap(
                              children: List.generate(
                                  snapshot.data!.docs.length, (index) {
                                if (dataProvide.phone != '' &&
                                    !dataProvide.userType) {
                                  for (int i = 0;
                                      i <
                                          dataProvide
                                              .accountInfo.favorites!.length;
                                      i++) {
                                    if (dataProvide.accountInfo.favorites![i] ==
                                        snapshot.data!.docs[index].id) {
                                    } else {}
                                  }
                                }
                                ProductInfo searchResults =
                                    ProductInfo.fromJson(
                                        snapshot.data!.docs[index].data());
                                return Container(
                                  margin: const EdgeInsets.all(5),
                                  padding: EdgeInsets.only(
                                      right: snapshot.data!.docs.length == 1
                                          ? SizeApp.width * 0.03
                                          : 0),
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
                                    },
                                  ),
                                );
                              }),
                            ),
                          ),
                        );
                      } else {
                        return TextApp(
                            text: 'لاتوجد منتجات',
                            size: SizeApp.textSize * 1.5,
                            fontWeight: FontWeight.normal,
                            textAlign: TextAlign.center,
                            color: bigTextColor);
                      }
                    },
                  ))
            ],
          ),
        ),
      ),
      bottomNavigationBar: Platform.isIOS
          ? SizedBox(
              height: SizeApp.height * 0.03,
            )
          : null,
    );
  }
}

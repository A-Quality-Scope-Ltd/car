import 'package:car/screens/admin_screens/widgets_admin/products_item_admin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../model/color_app.dart';
import '../../model/data_information/product_info.dart';

import '../../model/size_app.dart';

import '../../widget/tab_bar_app.dart';
import '../../widget/text.dart';
import '../../widget/text_field.dart';

import 'widgets_admin/app_bar_admin.dart';
import 'widgets_admin/drawer_admin.dart';

class ProductsTabBar extends StatefulWidget {
  const ProductsTabBar({super.key});

  @override
  State<ProductsTabBar> createState() => _ProductsState();
}

class _ProductsState extends State<ProductsTabBar> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            drawer: DrawerAdmin(
              screens: 'المنتجات',
            ),
            backgroundColor: whiteColor,
            body: Padding(
              padding: EdgeInsets.fromLTRB(0, SizeApp.height * 0.07, 0, 0),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        SizeApp.padding, 0, SizeApp.padding, 0),
                    child: const AppBarAdmin(),
                  ),
                  SizedBox(height: SizeApp.height * 0.03),
                  TabBarApp(
                    titleTab1: 'المنتجات',
                    titleTab2: 'المنتجات الجديدة',
                  ),
                  const Expanded(
                    child: TabBarView(children: [
                      ProductsAllow(),
                      NewProductsNotAllow(),
                    ]),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}

class ProductsAllow extends StatefulWidget {
  const ProductsAllow({super.key});

  @override
  State<ProductsAllow> createState() => _ProductsAllowState();
}

class _ProductsAllowState extends State<ProductsAllow> {
  final TextEditingController _search = TextEditingController();

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Directionality(
        textDirection: TextDirection.ltr,
        child: Padding(
          padding: EdgeInsets.fromLTRB(
              SizeApp.padding, SizeApp.height * 0.02, SizeApp.padding, 0),
          child: Column(
            children: [
              TextFieldApp(
                hintText: 'بحث عن المنتج',
                width: SizeApp.width,
                height: SizeApp.height * 0.025,
                style: TextStyle(fontSize: SizeApp.textSize * 1.3),
                keyboardType: TextInputType.name,
                textAlign: TextAlign.right,
                suffixIcon: const Icon(Icons.search),
                controller: _search,
                onChanged: (value) {
                  setState(() {
                    _search.text = value;
                  });
                },
              ),
              SizedBox(height: SizeApp.height * 0.015),
              Expanded(
                  child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('Products')
                    .where('agree', isEqualTo: true)
                    .orderBy('phone')
                    .startAt([_search.text]).snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          ProductInfo searchResults = ProductInfo.fromJson(
                              snapshot.data!.docs[index].data());
                          return ProductsItemAdmin(
                            page: 'المنتجات',
                            data: searchResults,
                          );
                        });
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
                },
              ))
            ],
          ),
        ),
      ),
    );
  }
}

class NewProductsNotAllow extends StatefulWidget {
  const NewProductsNotAllow({super.key});

  @override
  State<NewProductsNotAllow> createState() => _NewProductsNotAllowState();
}

class _NewProductsNotAllowState extends State<NewProductsNotAllow> {
  final TextEditingController _search = TextEditingController();

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Directionality(
        textDirection: TextDirection.ltr,
        child: Padding(
          padding: EdgeInsets.fromLTRB(
              SizeApp.padding, SizeApp.height * 0.02, SizeApp.padding, 0),
          child: Column(
            children: [
              TextFieldApp(
                hintText: 'بحث عن المنتج',
                width: SizeApp.width,
                height: SizeApp.height * 0.025,
                style: TextStyle(fontSize: SizeApp.textSize * 1.3),
                keyboardType: TextInputType.name,
                textAlign: TextAlign.right,
                suffixIcon: const Icon(Icons.search),
                controller: _search,
                onChanged: (value) {
                  setState(() {
                    _search.text = value;
                  });
                },
              ),
              SizedBox(height: SizeApp.height * 0.015),
              Expanded(
                  child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('Products')
                    .where('agree', isEqualTo: false)
                    .orderBy('phone')
                    .startAt([_search.text]).snapshots(),
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
                        padding: EdgeInsets.zero,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          ProductInfo searchResults = ProductInfo.fromJson(
                              snapshot.data!.docs[index].data());
                          searchResults.id = snapshot.data!.docs[index].id;
                          return ProductsItemAdmin(
                            page: 'المنتجات الجديدة',
                            data: searchResults,
                          );
                        });
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
                },
              ))
            ],
          ),
        ),
      ),
    );
  }
}

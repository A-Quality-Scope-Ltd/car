import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../model/color_app.dart';
import '../../model/data_information/seller_registration_info.dart';

import '../../model/size_app.dart';

import '../../widget/tab_bar_app.dart';
import '../../widget/text.dart';
import '../../widget/text_field.dart';

import 'widgets_admin/app_bar_admin.dart';
import 'widgets_admin/drawer_admin.dart';
import 'widgets_admin/seller_item.dart';

// ignore: must_be_immutable
class SellersTabBar extends StatefulWidget {
  const SellersTabBar({
    super.key,
  });

  @override
  State<SellersTabBar> createState() => _SellersTabBarState();
}

class _SellersTabBarState extends State<SellersTabBar> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            drawer: DrawerAdmin(
              screens: 'البائعين',
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
                  SizedBox(
                    height: SizeApp.height * 0.03,
                  ),
                  TabBarApp(
                    titleTab1: 'البائعين',
                    titleTab2: 'البائعين الجدد',
                  ),
                  const Expanded(
                    child: TabBarView(children: [
                      SellerTabAllow(),
                      SellerTabNotAllow(),
                      // MyTagTab(),
                    ]),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}

class SellerTabAllow extends StatefulWidget {
  const SellerTabAllow({
    super.key,
  });

  @override
  State<SellerTabAllow> createState() => _SellerTabAllowState();
}

class _SellerTabAllowState extends State<SellerTabAllow> {
  List<SellerRegistrationInfo> searchResults = [];
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
              SizeApp.padding, SizeApp.height * 0.03, SizeApp.padding, 0),
          child: Column(
            children: [
              TextFieldApp(
                hintText: 'بحث عن البائع',
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
                    .collection('Sellers')
                    .where('allow', isEqualTo: true)
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
                          SellerRegistrationInfo searchResults =
                              SellerRegistrationInfo.fromJson(
                                  snapshot.data!.docs[index]);
                          return SellerItem(
                            tab: 'tab 1',
                            name: searchResults.fullName!,
                            phone: searchResults.phone!,
                            location: searchResults.location!,
                            statement: searchResults.statement,
                          );
                        });
                  } else {
                    return Center(
                      child: TextApp(
                          text: 'لايوجد بيانات',
                          size: SizeApp.textSize * 1,
                          fontWeight: FontWeight.normal,
                          textAlign: TextAlign.center,
                          color: bigTextColor),
                    );
                  }
                },
              )),
            ],
          ),
        ),
      ),
    );
  }
}

class SellerTabNotAllow extends StatefulWidget {
  const SellerTabNotAllow({
    super.key,
  });

  @override
  State<SellerTabNotAllow> createState() => _SellerTabNotAllowState();
}

class _SellerTabNotAllowState extends State<SellerTabNotAllow> {
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
              SizeApp.padding, SizeApp.height * 0.03, SizeApp.padding, 0),
          child: Column(
            children: [
              TextFieldApp(
                  hintText: 'بحث عن البائع',
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
                  }),
              SizedBox(height: SizeApp.height * 0.015),
              Expanded(
                  child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('Sellers')
                    .where('allow', isEqualTo: false)
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
                          SellerRegistrationInfo searchResults =
                              SellerRegistrationInfo.fromJson(
                                  snapshot.data!.docs[index]);
                          return SellerItem(
                            tab: 'tab 2',
                            name: searchResults.fullName!,
                            phone: searchResults.phone!,
                            location: searchResults.location!,
                            statement: searchResults.statement,
                          );
                        });
                  } else {
                    return Center(
                      child: TextApp(
                          text: 'لايوجد بائعين جدد',
                          size: SizeApp.textSize * 1.5,
                          fontWeight: FontWeight.normal,
                          textAlign: TextAlign.center,
                          color: bigTextColor),
                    );
                  }
                },
              )),
            ],
          ),
        ),
      ),
    );
  }
}

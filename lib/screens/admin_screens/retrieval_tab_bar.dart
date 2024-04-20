import 'package:car/screens/admin_screens/widgets_admin/retrieval_item_admin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../model/color_app.dart';

import '../../model/data_information/recovery_info.dart';
import '../../model/size_app.dart';
import '../../widget/tab_bar_app.dart';
import '../../widget/text.dart';
import 'widgets_admin/app_bar_admin.dart';
import 'widgets_admin/drawer_admin.dart';

class RetrievalTabBar extends StatefulWidget {
  const RetrievalTabBar({super.key});

  @override
  State<RetrievalTabBar> createState() => _RetrievalTabBarState();
}

class _RetrievalTabBarState extends State<RetrievalTabBar> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            drawer: DrawerAdmin(
              screens: 'الاسترجاع',
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
                    titleTab1: 'قيد التنفيذ',
                    titleTab2: 'الاسترجاع',
                  ),
                  const Expanded(
                    child: TabBarView(children: [
                      RetrievalUnderWay(),
                      RetrievalAdmin(),
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

class RetrievalUnderWay extends StatelessWidget {
  const RetrievalUnderWay({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Directionality(
        textDirection: TextDirection.ltr,
        child: Padding(
          padding: EdgeInsets.fromLTRB(
              SizeApp.padding, SizeApp.height * 0.02, SizeApp.padding, 0),
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('OrderReturns')
                  .where('agreeClient', isEqualTo: true)
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
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      RecoveryInfo results = RecoveryInfo.fromJson(
                          snapshot.data!.docs[index].data());

                      results.id = snapshot.data!.docs[index].id;
                      return RetrievalItemAdmin(
                        results: results,
                      );
                    },
                  );
                } else {
                  return Center(
                    child: TextApp(
                        text: 'لايوجد طلبات إسترجاع',
                        size: SizeApp.textSize * 1.5,
                        fontWeight: FontWeight.normal,
                        textAlign: TextAlign.center,
                        color: bigTextColor),
                  );
                }
              }),
        ),
      ),
    );
  }
}

class RetrievalAdmin extends StatelessWidget {
  const RetrievalAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Directionality(
        textDirection: TextDirection.ltr,
        child: Padding(
          padding: EdgeInsets.fromLTRB(
              SizeApp.padding, SizeApp.height * 0.02, SizeApp.padding, 0),
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('OrderReturns')
                  .where('agreeClient', isEqualTo: false)
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
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      RecoveryInfo results = RecoveryInfo.fromJson(
                          snapshot.data!.docs[index].data());

                      results.id = snapshot.data!.docs[index].id;
                      return RetrievalItemAdmin(
                        results: results,
                      );
                    },
                  );
                } else {
                  return Center(
                    child: TextApp(
                        text: 'لايوجد طلبات إسترجاع',
                        size: SizeApp.textSize * 1.5,
                        fontWeight: FontWeight.normal,
                        textAlign: TextAlign.center,
                        color: bigTextColor),
                  );
                }
              }),
        ),
      ),
    );
  }
}

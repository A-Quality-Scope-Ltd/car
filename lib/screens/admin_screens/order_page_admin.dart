import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../model/color_app.dart';
import '../../model/data_information/order_info.dart';

import '../../model/size_app.dart';

import '../../widget/tab_bar_app.dart';
import '../../widget/text.dart';
import 'widgets_admin/app_bar_admin.dart';
import 'widgets_admin/drawer_admin.dart';
import 'widgets_admin/order_item_admin.dart';

class OrderPageAdmin extends StatefulWidget {
  const OrderPageAdmin({super.key});

  @override
  State<OrderPageAdmin> createState() => _OrderPageAdminState();
}

class _OrderPageAdminState extends State<OrderPageAdmin> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            drawer: DrawerAdmin(
              screens: 'الطلبات',
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
                    titleTab1: 'قيد التنفيذ',
                    titleTab2: 'الطلبات',
                  ),
                  const Expanded(
                    child: TabBarView(children: [
                      OrderUnderWayAdmin(),
                      OrderAdmin(),
                    ]),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}

class OrderUnderWayAdmin extends StatelessWidget {
  const OrderUnderWayAdmin({super.key});

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
                  .collection('Orders')
                  .where('agreeAdmin', isEqualTo: true)
                  .orderBy('time')
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
                      OrderInfo results =
                          OrderInfo.fromJson(snapshot.data!.docs[index].data());

                      results.id = snapshot.data!.docs[index].id;
                      return OrderItemAdmin(
                        page: 'قيد التنفيذ',
                        results: results,
                      );
                    },
                  );
                } else {
                  return Center(
                    child: TextApp(
                        text: 'لاتوجد طلبات',
                        size: SizeApp.textSize * 1,
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

class OrderAdmin extends StatelessWidget {
  const OrderAdmin({super.key});

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
                  .collection('Orders')
                  .where('agreeAdmin', isEqualTo: false)
                  .orderBy('time')
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
                      OrderInfo searchResults =
                          OrderInfo.fromJson(snapshot.data!.docs[index].data());
                      searchResults.id = snapshot.data!.docs[index].id;
                      return OrderItemAdmin(
                        page: 'الطلبات',
                        results: searchResults,
                      );
                    },
                  );
                } else {
                  return Center(
                    child: TextApp(
                        text: 'لاتوجد طلبات',
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

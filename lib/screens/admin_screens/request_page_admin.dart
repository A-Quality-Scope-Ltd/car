import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../model/color_app.dart';

import '../../model/data_information/request_info.dart';
import '../../model/size_app.dart';

import '../../widget/text.dart';

import 'widgets_admin/app_bar_admin.dart';
import 'widgets_admin/drawer_admin.dart';
import 'widgets_admin/request_item_admin.dart';

class RequestPageAdmin extends StatefulWidget {
  const RequestPageAdmin({super.key});

  @override
  State<RequestPageAdmin> createState() => _RequestPageAdminState();
}

class _RequestPageAdminState extends State<RequestPageAdmin> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          drawer: DrawerAdmin(
            screens: 'الطلبيات',
          ),
          backgroundColor: whiteColor,
          body: Padding(
            padding: EdgeInsets.fromLTRB(
                SizeApp.padding, SizeApp.height * 0.07, SizeApp.padding, 0),
            child: Column(
              children: [
                const AppBarAdmin(),
                TextApp(
                    text: 'الطلبيات',
                    size: SizeApp.textSize * 2,
                    fontWeight: FontWeight.normal,
                    textAlign: TextAlign.center,
                    color: bigTextColor),
                Expanded(
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('Requests')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
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
                              RequestInfo results = RequestInfo.fromJson(
                                  snapshot.data!.docs[index].data());

                              results.id = snapshot.data!.docs[index].id;
                              return RequestItemAdmin(
                                results: results,
                              );
                            },
                          );
                        } else {
                          return Center(
                            child: TextApp(
                                text: 'لايوجد طلبيات',
                                size: SizeApp.textSize * 1.5,
                                fontWeight: FontWeight.normal,
                                textAlign: TextAlign.center,
                                color: bigTextColor),
                          );
                        }
                      }),
                )
              ],
            ),
          )),
    );
  }
}

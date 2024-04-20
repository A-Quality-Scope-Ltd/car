import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../model/color_app.dart';
import '../model/data_information/order_info.dart';
import '../model/provider_app.dart';
import '../model/size_app.dart';
import '../widget/product_item_underway.dart';
import '../widget/text.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../model/data_information/request_info.dart';
import '../widget/request_item.dart';
import '../widget/tab_bar_app.dart';

class RequestsAndOrder extends StatefulWidget {
  const RequestsAndOrder({super.key});

  @override
  State<RequestsAndOrder> createState() => _RequestsAndOrderState();
}

class _RequestsAndOrderState extends State<RequestsAndOrder> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            backgroundColor: whiteColor,
            body: Padding(
              padding: EdgeInsets.fromLTRB(0, SizeApp.height * 0.08, 0, 0),
              child: Column(
                children: [
                  TabBarApp(
                    titleTab1: 'الطلبات',
                    titleTab2: 'الطلبيات',
                    size: SizeApp.textSize * 1,
                  ),
                  SizedBox(height: SizeApp.height * 0.01),
                  const Expanded(
                    child: TabBarView(children: [OrderPage(), RequestPage()]),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final String whatsappNumber = '0577122910';

  @override
  Widget build(BuildContext context) {
    ProviderApp dataProvide = Provider.of<ProviderApp>(context);
    return Scaffold(
      backgroundColor: whiteColor,
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: EdgeInsets.fromLTRB(0, SizeApp.height * 0.02, 0, 0),
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('Orders')
                  .where('phoneClient', isEqualTo: dataProvide.phone)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                      alignment: Alignment.topCenter,
                      margin: const EdgeInsets.only(top: 20),
                      child: Center(
                        child: CircularProgressIndicator(
                          backgroundColor: smolleTextColor,
                          color: primaryColor,
                        ),
                      ));
                } else if (snapshot.data!.docs.isNotEmpty) {
                  return Align(
                    alignment: snapshot.data!.docs.length == 1
                        ? Alignment.topRight
                        : Alignment.topCenter,
                    child: SingleChildScrollView(
                      child: Wrap(children: [
                        ...List.generate(
                          snapshot.data!.docs.length,
                          (index) {
                            OrderInfo results = OrderInfo.fromJson(
                                snapshot.data!.docs[index].data());
                            results.id = snapshot.data!.docs[index].id;
                            return Padding(
                              padding: const EdgeInsets.all(5),
                              child: ProductItemUnderway(
                                results: results,
                              ),
                            );
                          },
                        ),
                        SizedBox(height: SizeApp.height * 0.4),
                      ]),
                    ),
                  );
                } else {
                  return Center(
                    child: TextApp(
                        text: 'لايوجد طلبات',
                        size: SizeApp.textSize * 1.5,
                        fontWeight: FontWeight.normal,
                        textAlign: TextAlign.center,
                        color: bigTextColor),
                  );
                }
              }),
        ),
      ),
      bottomNavigationBar: Container(
        height: SizeApp.height * 0.1,
        padding: EdgeInsets.only(
          right: SizeApp.width * 0.65,
        ),
        child: GestureDetector(
          onTap: () {
            _launchWhatsApp();
          },
          child: Column(children: [
            SvgPicture.asset(
              'assets/icons/ icon _whatsapp_.svg',
              width: SizeApp.iconSize * 1.5,
              height: SizeApp.iconSize * 1.5,
            ),
            TextApp(
                text: 'تواصل مع المسؤول',
                size: SizeApp.textSize * 0.8,
                fontWeight: FontWeight.normal,
                textAlign: TextAlign.center,
                color: const Color(0xff53B175)),
          ]),
        ),
      ),
    );
  }

  void _launchWhatsApp() async {
    final String whatsappURLIos = 'https://wa.me/$whatsappNumber';
    final String whatsappURlAndroid = 'whatsapp://send?phone=$whatsappNumber';

    if (Platform.isIOS) {
      // for iOS phone only
      if (await canLaunchUrl(Uri.parse(whatsappURLIos))) {
        await launchUrl(Uri.parse(whatsappURLIos));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: TextApp(
                text: 'الواتساب ليسة مثبت',
                size: SizeApp.textSize * 1,
                fontWeight: FontWeight.normal,
                textAlign: TextAlign.center,
                color: const Color.fromARGB(255, 205, 76, 91))));
      }
    } else {
      // android , web
      if (await canLaunchUrl(Uri.parse(whatsappURlAndroid))) {
        await launchUrl(Uri.parse(whatsappURlAndroid));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: TextApp(
                text: 'الواتساب ليسة مثبت',
                size: SizeApp.textSize * 1,
                fontWeight: FontWeight.normal,
                textAlign: TextAlign.center,
                color: const Color.fromARGB(255, 205, 76, 91))));
      }
    }
  }
}

class RequestPage extends StatelessWidget {
  const RequestPage({super.key});

  @override
  Widget build(BuildContext context) {
    ProviderApp dataProvide = Provider.of<ProviderApp>(context);

    return Scaffold(
      backgroundColor: whiteColor,
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: EdgeInsets.fromLTRB(
              SizeApp.padding, SizeApp.height * 0.02, SizeApp.padding, 0),
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('Requests')
                  .where('phoneClient', isEqualTo: dataProvide.phone)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                      alignment: Alignment.topCenter,
                      margin: const EdgeInsets.only(top: 20),
                      child: Center(
                        child: CircularProgressIndicator(
                          backgroundColor: smolleTextColor,
                          color: primaryColor,
                        ),
                      ));
                } else if (snapshot.data!.docs.isNotEmpty) {
                  return Align(
                    alignment: snapshot.data!.docs.length == 1
                        ? Alignment.topRight
                        : Alignment.topCenter,
                    child: SingleChildScrollView(
                      child: Wrap(
                        children: [
                          ...List.generate(
                            snapshot.data!.docs.length,
                            (index) {
                              RequestInfo results = RequestInfo.fromJson(
                                  snapshot.data!.docs[index].data());
                              results.id = snapshot.data!.docs[index].id;
                              return RequestItem(
                                requestInfo: results,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
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
        ),
      ),
    );
  }
}

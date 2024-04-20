import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../model/color_app.dart';
import '../../model/data_information/order_info.dart';
import '../../model/data_information/product_info.dart';
import '../../model/data_information/recovery_info.dart';
import '../../model/data_information/request_info.dart';
import '../../model/provider_app.dart';
import '../../model/size_app.dart';
import '../../widget/app_bar_seller.dart';
import '../../widget/product_item.dart';
import '../../widget/seller_order_item.dart';
import '../../widget/seller_recovery_item.dart';
import '../../widget/seller_request_item.dart';
import '../../widget/tab_bar_app.dart';
import '../../widget/text.dart';
import 'edit_product.dart';

// ignore: must_be_immutable
class Seller extends StatefulWidget {
  const Seller({super.key});

  @override
  State<Seller> createState() => _SellerState();
}

class _SellerState extends State<Seller> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
          backgroundColor: whiteColor,
          body: PopScope(
            canPop: false,
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, SizeApp.height * 0.07, 0, 0),
                child: Column(
                  children: [
                    const AppBarSeller(),
                    TabBarApp(
                      titleTab1: 'الرئيسية',
                      titleTab2: 'الطلبات',
                      titleTab3: 'الطلبية',
                      titleTab4: 'الاسترجاع',
                      size: SizeApp.textSize * 1,
                    ),
                    const Expanded(
                      child: TabBarView(children: [
                        SellerMainTab(),
                        SellerOrder(),
                        SellerRequest(),
                        SellerRecovery()
                      ]),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}

class SellerMainTab extends StatefulWidget {
  const SellerMainTab({super.key});

  @override
  State<SellerMainTab> createState() => _SellerMainTabState();
}

class _SellerMainTabState extends State<SellerMainTab> {
  final String whatsappNumber = '0577122910';
  @override
  Widget build(BuildContext context) {
    ProviderApp dataProvide = Provider.of<ProviderApp>(context);
    print(dataProvide.phone);
    return Scaffold(
      backgroundColor: whiteColor,
      body: Padding(
        padding: EdgeInsets.fromLTRB(0, SizeApp.height * 0.01, 0, 0),
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('Products')
                .where('phone', isEqualTo: dataProvide.sellInfo.phone)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                    backgroundColor: smolleTextColor,
                    color: primaryColor,
                  ),
                );
              } else if (snapshot.data!.docs.isNotEmpty) {
                return Align(
                  alignment: snapshot.data!.docs.length == 1
                      ? Alignment.topRight
                      : Alignment.topCenter,
                  child: SingleChildScrollView(
                    child: Wrap(spacing: 10, children: [
                      ...List.generate(snapshot.data!.docs.length, (index) {
                        ProductInfo searchResults = ProductInfo.fromJson(
                            snapshot.data!.docs[index].data());
                        return Container(
                          padding: EdgeInsets.only(
                              right: snapshot.data!.docs.length == 1
                                  ? SizeApp.width * 0.03
                                  : 0),
                          child: ProductItem(
                            pageTitle: 'Seller',
                            data: searchResults,
                            onTapEditIcon: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditProduct(
                                          productInfo: searchResults,
                                        )),
                              );
                            },
                          ),
                        );
                      }),
                      SizedBox(height: SizeApp.height * 0.03),
                    ]),
                  ),
                );
              } else {
                return Center(
                    child: TextApp(
                        text: 'لايوجد متجات',
                        size: SizeApp.textSize * 1.5,
                        fontWeight: FontWeight.normal,
                        textAlign: TextAlign.center,
                        color: bigTextColor));
              }
            }),
      ),
      bottomNavigationBar: Container(
        height: SizeApp.height * 0.12,
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
                size: SizeApp.textSize * 1,
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

class SellerRequest extends StatelessWidget {
  const SellerRequest({super.key});

  @override
  Widget build(BuildContext context) {
    ProviderApp dataProvide = Provider.of<ProviderApp>(context);

    return Scaffold(
      backgroundColor: whiteColor,
      body: Directionality(
        textDirection: TextDirection.ltr,
        child: Padding(
          padding: EdgeInsets.fromLTRB(
              SizeApp.padding, SizeApp.height * 0.01, SizeApp.padding, 0),
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('Requests')
                  .where('phoneSeller', isEqualTo: dataProvide.phone)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: smolleTextColor,
                      color: primaryColor,
                    ),
                  );
                } else if (snapshot.data!.docs.isNotEmpty) {
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      RequestInfo results = RequestInfo.fromJson(
                          snapshot.data!.docs[index].data());

                      results.id = snapshot.data!.docs[index].id;
                      return SellerRequestsItem(
                        requestInfo: results,
                      );
                    },
                  );
                } else {
                  return Center(
                      child: TextApp(
                          text: 'لايوجد طلبات',
                          size: SizeApp.textSize * 1.5,
                          fontWeight: FontWeight.normal,
                          textAlign: TextAlign.center,
                          color: bigTextColor));
                }
              }),
        ),
      ),
    );
  }
}

class SellerOrder extends StatelessWidget {
  const SellerOrder({super.key});

  @override
  Widget build(BuildContext context) {
    ProviderApp dataProvide = Provider.of<ProviderApp>(context);

    return Scaffold(
      backgroundColor: whiteColor,
      body: Directionality(
        textDirection: TextDirection.ltr,
        child: Padding(
          padding: EdgeInsets.fromLTRB(
              SizeApp.padding, SizeApp.height * 0.01, SizeApp.padding, 0),
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('Orders')
                  .where('phoneSeller', isEqualTo: dataProvide.phone)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: smolleTextColor,
                      color: primaryColor,
                    ),
                  );
                } else if (snapshot.data!.docs.isNotEmpty) {
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      OrderInfo results =
                          OrderInfo.fromJson(snapshot.data!.docs[index].data());

                      results.id = snapshot.data!.docs[index].id;
                      return SellerOrdersItem(
                        orderInfo: results,
                      );
                    },
                  );
                } else {
                  return Center(
                      child: TextApp(
                          text: 'لايوجد طلبات',
                          size: SizeApp.textSize * 1.5,
                          fontWeight: FontWeight.normal,
                          textAlign: TextAlign.center,
                          color: bigTextColor));
                }
              }),
        ),
      ),
    );
  }
}

class SellerRecovery extends StatelessWidget {
  const SellerRecovery({super.key});

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
                  .where('agreeAdmin', isEqualTo: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: smolleTextColor,
                      color: primaryColor,
                    ),
                  );
                } else if (snapshot.data!.docs.isNotEmpty) {
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      RecoveryInfo results = RecoveryInfo.fromJson(
                          snapshot.data!.docs[index].data());

                      results.id = snapshot.data!.docs[index].id;
                      return SellerRecoveryItem();
                    },
                  );
                } else {
                  return Center(
                      child: TextApp(
                          text: 'لايوجد طلبيات',
                          size: SizeApp.textSize * 1.5,
                          fontWeight: FontWeight.normal,
                          textAlign: TextAlign.center,
                          color: bigTextColor));
                }
              }),
        ),
      ),
    );
  }
}

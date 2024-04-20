import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../model/color_app.dart';

import '../../model/createpdf.dart';
import '../../model/size_app.dart';

import '../../widget/button.dart';

import '../../widget/text.dart';

import 'widgets_admin/app_bar_admin.dart';
import 'widgets_admin/drawer_admin.dart';

class DashBord extends StatefulWidget {
  const DashBord({super.key});

  @override
  State<DashBord> createState() => _DashBordState();
}

class _DashBordState extends State<DashBord> {
  int? totalNumberOfSellers = 0;
  int? totalNumberOfProducts = 0;
  int? totalNumberOfRequests = 0;
  int? totalNumberOfReturnRequests = 0;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: whiteColor,
        drawer: DrawerAdmin(screens: 'الرئيسية'),
        body: PopScope(
          canPop: false,
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                SizeApp.padding, SizeApp.height * 0.07, SizeApp.padding, 0),
            child: Column(children: [
              const AppBarAdmin(),
              SizedBox(
                height: SizeApp.height * 0.04,
              ),
              TextApp(
                  text: 'الرئيسية',
                  size: SizeApp.textSize * 2.5,
                  fontWeight: FontWeight.normal,
                  color: bigTextColor),
              SizedBox(
                height: SizeApp.height * 0.1,
              ),
              _statistics(),
            ]),
          ),
        ),
      ),
    );
  }

  Widget _statistics() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _designStatistics(
              title: 'إجمالي عدد البائعين',
              collection: 'Sellers',
            ),
            _designStatistics(
              title: 'اجمالي عدد المنتجات',
              collection: 'Products',
            ),
          ],
        ),
        SizedBox(
          height: SizeApp.height * 0.03,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _designStatistics(
              title: 'إجمالي عدد الطلبات',
              collection: 'Orders',
            ),
            _designStatistics(
              title: 'إجمالي عدد طلبات الاسترجاع',
              collection: 'OrderReturns',
            ),
          ],
        ),
        SizedBox(
          height: SizeApp.height * 0.1,
        ),
        _buttonPDF()
      ],
    );
  }

  Widget _designStatistics({
    String? title,
    String? collection,
  }) {
    return Container(
      width: SizeApp.width * 0.44,
      height: SizeApp.height * 0.14,
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.all(Radius.circular(SizeApp.cardRadius)),
        border: Border.all(color: bordarColor, width: SizeApp.width * 0.002),
      ),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        TextApp(
            text: title!,
            size: SizeApp.textSize,
            fontWeight: FontWeight.normal,
            textAlign: TextAlign.center,
            color: bigTextColor),
        SizedBox(
          height: SizeApp.height * 0.008,
        ),
        StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection(collection!).snapshots(),
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
                if (title == 'إجمالي عدد البائعين') {
                  totalNumberOfSellers = snapshot.data!.docs.length;
                } else if (title == 'اجمالي عدد المنتجات') {
                  totalNumberOfProducts = snapshot.data!.docs.length;
                } else if (title == 'إجمالي عدد الطلبات') {
                  totalNumberOfRequests = snapshot.data!.docs.length;
                } else {
                  totalNumberOfReturnRequests = snapshot.data!.docs.length;
                }

                return TextApp(
                    text: snapshot.data!.docs.length.toString(),
                    size: SizeApp.textSize * 1.5,
                    fontWeight: FontWeight.normal,
                    color: bigTextColor);
              } else {
                return Center(
                  child: TextApp(
                      text: '0',
                      size: SizeApp.textSize * 1.5,
                      fontWeight: FontWeight.normal,
                      textAlign: TextAlign.center,
                      color: bigTextColor),
                );
              }
            }),
      ]),
    );
  }

  Widget _buttonPDF() {
    return ButtonApp(
        buttonText: 'تقرير',
        color: primaryColor,
        width: SizeApp.width * 0.6,
        fontSize: SizeApp.textSize * 1.7,
        radius: SizeApp.buttonRadius,
        onPressed: () async {
          try {
            CreatePDF createPDF = CreatePDF(
                totalNumberOfProducts: totalNumberOfProducts,
                totalNumberOfRequests: totalNumberOfRequests,
                totalNumberOfReturnRequests: totalNumberOfReturnRequests,
                totalNumberOfSellers: totalNumberOfSellers);
            final File pdfFile = await createPDF.generate();
            createPDF.openFile(pdfFile);
            createPDF.reportNumber++;
          } catch (e) {
            print(e);
          }
        });
  }
}

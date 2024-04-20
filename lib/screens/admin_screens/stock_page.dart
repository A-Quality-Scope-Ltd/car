import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../model/color_app.dart';
import '../../model/data_information/seller_registration_info.dart';
import '../../model/database/firebase_helper.dart';
import '../../model/size_app.dart';
import '../../widget/button.dart';
import '../../widget/text.dart';
import 'widgets_admin/app_bar_admin.dart';
import 'widgets_admin/drawer_admin.dart';

class StockPage extends StatefulWidget {
  const StockPage({super.key});

  @override
  State<StockPage> createState() => _StockPageState();
}

class _StockPageState extends State<StockPage> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          drawer: DrawerAdmin(
            screens: 'المستحقات',
          ),
          backgroundColor: whiteColor,
          body: Padding(
            padding: EdgeInsets.fromLTRB(
                SizeApp.padding, SizeApp.height * 0.07, SizeApp.padding, 0),
            child: Column(
              children: [
                const AppBarAdmin(),
                TextApp(
                    text: 'مستحقات البائعين',
                    size: SizeApp.textSize * 2,
                    fontWeight: FontWeight.normal,
                    textAlign: TextAlign.center,
                    color: bigTextColor),
                Expanded(
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('Sellers')
                          .where('stock', isNotEqualTo: '0')
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
                              SellerRegistrationInfo results =
                                  SellerRegistrationInfo.fromJson(
                                      snapshot.data!.docs[index].data());

                              return ItemBuild(
                                results,
                              );
                            },
                          );
                        } else {
                          return const Center(
                            child: Text('لايوجد مستحقات'),
                          );
                        }
                      }),
                )
              ],
            ),
          )),
    );
  }

  Widget ItemBuild(SellerRegistrationInfo results) {
    return Container(
      margin: EdgeInsets.only(bottom: SizeApp.height * 0.015),
      padding: EdgeInsets.only(
          left: SizeApp.width * 0.05,
          right: SizeApp.width * 0.05,
          top: SizeApp.height * 0.015,
          bottom: SizeApp.height * 0.015),
      height: SizeApp.height * 0.18,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(SizeApp.cardRadius),
        border: Border.all(
            color: bordarColor.withOpacity(0.5), width: SizeApp.width * 0.002),
        color: whiteColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(width: SizeApp.width * 0.02),
          Expanded(
            child: Column(
              children: [
                SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextApp(
                          text: 'اسم البائع: ${results.fullName!}',
                          size: SizeApp.textSize * 1.1,
                          fontWeight: FontWeight.normal,
                          overflow: TextOverflow.visible,
                          textAlign: TextAlign.center,
                          color: bigTextColor),
                      SizedBox(
                        width: SizeApp.width * 0.02,
                      ),
                      TextApp(
                          text: 'الرصيد: ${results.stock}',
                          size: SizeApp.textSize * 1.1,
                          fontWeight: FontWeight.normal,
                          overflow: TextOverflow.visible,
                          textAlign: TextAlign.center,
                          color: bigTextColor),
                    ],
                  ),
                ),
                SizedBox(height: SizeApp.height * 0.01),
                TextApp(
                    text: 'رقم الهاتف: ${results.phone}',
                    size: SizeApp.textSize * 0.9,
                    fontWeight: FontWeight.normal,
                    textAlign: TextAlign.center,
                    color: bigTextColor),
                TextApp(
                    text: 'رقم الحساب: ${results.iban}',
                    size: SizeApp.textSize * 0.9,
                    fontWeight: FontWeight.normal,
                    textAlign: TextAlign.center,
                    color: bigTextColor),
                SizedBox(height: SizeApp.height * 0.01),
                ButtonApp(
                    buttonText: 'تم تحويل المبلغ',
                    color: primaryColor,
                    width: SizeApp.width * 0.45,
                    height: SizeApp.height * 0.035,
                    fontSize: SizeApp.textSize * 1.2,
                    fontWeight: FontWeight.bold,
                    radius: SizeApp.buttonRadius,
                    onPressed: () {
                      FirebaseAppHelper().updateSellerData(
                          phone: results.phone, updateData: {'stock': '0'});
                    })
              ],
            ),
          ),
        ],
      ),
    );
  }
}

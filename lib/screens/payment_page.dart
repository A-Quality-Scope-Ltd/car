// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../model/data_information/order_info.dart';
import '../model/data_information/product_info.dart';
import '../model/data_information/request_info.dart';
import '../model/database/firebase_helper.dart';
import '../screens/home_tap_bar_navigation.dart';
import 'package:moyasar/moyasar.dart';
import '../model/size_app.dart';
import '../widget/custom_snack_bar.dart';

//live
String pk_live = 'pk_live_jbQF2pnkkBYCFCRpkmmdhXEnYE5csgEgbrwSSXMA';
String sk_live = 'sk_live_hF4mBRTACNLmve8LHcFFLvYVEctebRWdVvM1vBmL';
//test
String pk_test = 'pk_test_XoEwpUaucqXLCih1afwYp262uhofaUkBckDCkqwq';
String sk_test = 'sk_test_Ybv5PDmEGjKGoojcLdyrVsCk3gyggoja4yk6pMgr';
////Aquality Scope

class PaymentMethods extends StatefulWidget {
  final PaymentConfig paymentConfig;
  ProductInfo? productInfo;
  OrderInfo? orderInfo;
  RequestInfo? requestInfo;
  bool isOrder = false;

  PaymentMethods(
      {super.key,
      required this.paymentConfig,
      this.orderInfo,
      this.productInfo,
      this.requestInfo,
      this.isOrder = false});

  @override
  State<PaymentMethods> createState() => _PaymentMethodsState();
}

class _PaymentMethodsState extends State<PaymentMethods> {
  void onPaymentResult(result) {
    if (result is PaymentResponse) {
      switch (result.status) {
        case PaymentStatus.paid:
          if (widget.isOrder) {
            widget.orderInfo!.time = FieldValue.serverTimestamp();
            int amount = int.parse(widget.productInfo!.amountProduct!) -
                int.parse(widget.orderInfo!.amountProduct!);
            FirebaseAppHelper()
                .setOrderData(setOrder: widget.orderInfo!.toMap());
            FirebaseAppHelper()
                .updateProductData(id: widget.productInfo!.id, updateData: {
              'numberRequests': widget.productInfo!.numberRequests + 1,
              'amountProduct': '$amount'
            });
          } else {
            widget.requestInfo!.agreeClient = true;
            FirebaseAppHelper().updateRequestData(
                id: widget.productInfo!.id,
                updateData: widget.productInfo!.toMap());
          }
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const HomeTapBarNavigation()));
          customSnackBar(context: context, text: 'تم طلب المنتج');
          // handle success.
          break;
        case PaymentStatus.failed:
          customSnackBar(context: context, text: 'فشلت عملية الدفع');
          // handle failure.
          break;
        case PaymentStatus.authorized:
          customSnackBar(context: context, text: 'تأكد من البيانات');
          // handle authorized.
          break;
        default:
      }
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const HomeTapBarNavigation()));
      customSnackBar(context: context, text: 'تم طلب المنتج');
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Directionality(
          textDirection: TextDirection.rtl,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    size: SizeApp.iconSize,
                  )),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ApplePay(
              config: widget.paymentConfig,
              onPaymentResult: onPaymentResult,
            ),
            CreditCard(
              config: widget.paymentConfig,
              onPaymentResult: onPaymentResult,
            )
          ],
        ),
      ),
    );
  }
}

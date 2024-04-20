import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../model/color_app.dart';
import '../model/data_information/request_info.dart';
import '../model/size_app.dart';
import '../widget/button.dart';
import '../widget/get_image.dart';
import '../widget/text.dart';
import 'package:moyasar/moyasar.dart';

import '../screens/payment_page.dart';

// ignore: must_be_immutable
class RequestItem extends StatelessWidget {
  RequestInfo requestInfo = RequestInfo();

  RequestItem({super.key, required this.requestInfo});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: SizeApp.height * 0.015),
      padding: EdgeInsets.only(
          left: SizeApp.width * 0.05,
          right: SizeApp.width * 0.05,
          top: SizeApp.height * 0.015,
          bottom: SizeApp.height * 0.015),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(SizeApp.cardRadius),
        border: Border.all(
            color: bordarColor.withOpacity(0.5), width: SizeApp.width * 0.002),
        color: whiteColor,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                  child: getImage(
                phone: requestInfo.phoneSeller,
                propertyName: requestInfo.propertyName,
                width: SizeApp.width * 0.29,
              )),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextApp(
                        text: requestInfo.propertyName!,
                        size: SizeApp.textSize * 1,
                        fontWeight: FontWeight.bold,
                        textAlign: TextAlign.center,
                        color: bigTextColor),
                    SizedBox(height: SizeApp.height * 0.015),
                    SvgPicture.asset(
                      'assets/icons/ icon _location_.svg',
                      width: SizeApp.iconSize * 0.9,
                    ),
                    TextApp(
                        text: requestInfo.locationClient!,
                        size: SizeApp.textSize,
                        fontWeight: FontWeight.normal,
                        textAlign: TextAlign.center,
                        color: bigTextColor),
                    SizedBox(height: SizeApp.height * 0.015),
                    if (requestInfo.agreeSeller && !requestInfo.agreeAdmin) ...{
                      TextApp(
                          text: 'جاري تنفيذ الطلب',
                          size: SizeApp.textSize * 1.5,
                          fontWeight: FontWeight.normal,
                          textAlign: TextAlign.center,
                          color: bigTextColor)
                    },
                    if (requestInfo.agreeAdmin) ...{
                      TextApp(
                          text:
                              '${int.parse(requestInfo.deliveryCharge!) + int.parse(requestInfo.productPrice!) + int.parse(requestInfo.valueAddedTax!)} ر'
                              '.س.',
                          size: SizeApp.textSize * 1.5,
                          fontWeight: FontWeight.normal,
                          textAlign: TextAlign.center,
                          color: bigTextColor),
                      SizedBox(height: SizeApp.height * 0.015),
                      ButtonApp(
                        buttonText: 'دفع',
                        width: SizeApp.width,
                        height: SizeApp.height * 0.04,
                        color: primaryColor,
                        fontSize: SizeApp.textSize * 1.3,
                        radius: SizeApp.buttonRadius,
                        fontWeight: FontWeight.bold,
                        onPressed: () {
                          String id = 'be4868ff-8b32-408b-bfd0-fb28084ccef9';
                          int productPrice =
                              int.parse(requestInfo.productPrice!) +
                                  int.parse(requestInfo.deliveryCharge!) +
                                  int.parse(requestInfo.valueAddedTax!);
                          var paymentConfig = PaymentConfig(
                            publishableApiKey: pk_live,
                            amount: productPrice * 100, //
                            // SAR
                            description: 'order #1324',
                            metadata: {'size': '250g'},
                            applePay: ApplePayConfig(
                                merchantId: id,
                                label: 'اكلة وحرفة',
                                manual: true),
                          );
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PaymentMethods(
                                        paymentConfig: paymentConfig,
                                        requestInfo: requestInfo,
                                      )));
                        },
                      ),
                    }
                  ],
                ),
              ),
            ],
          ),
          if (requestInfo.agreeClient == false && requestInfo.agreeAdmin) ...{
            SizedBox(height: SizeApp.height * 0.015),
            TextApp(
                text: 'سيتم إلغاء الطلبية خلال : ${requestInfo.deleteTime}',
                size: SizeApp.textSize * 1.5,
                fontWeight: FontWeight.normal,
                textAlign: TextAlign.center,
                color: bigTextColor),
          }
        ],
      ),
    );
  }
}

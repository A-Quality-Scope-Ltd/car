// ignore: file_names
import 'package:flutter/material.dart';
import '../model/color_app.dart';
import '../model/data_information/order_info.dart';
import '../model/database/firebase_helper.dart';
import '../model/size_app.dart';
import '../widget/button.dart';
import '../widget/get_image.dart';
import '../widget/text.dart';

// ignore: must_be_immutable
class SellerOrdersItem extends StatelessWidget {
  OrderInfo? orderInfo;
  SellerOrdersItem({
    super.key,
    this.orderInfo,
  });

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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
              child: getImage(
            phone: orderInfo!.phoneSeller,
            propertyName: orderInfo!.propertyName,
            width: SizeApp.width * 0.2,
          )),
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextApp(
                    text: 'اسم المنتج : ${orderInfo!.propertyName}',
                    size: SizeApp.textSize * 1.1,
                    fontWeight: FontWeight.bold,
                    textAlign: TextAlign.end,
                    color: bigTextColor),
                SizedBox(height: SizeApp.height * 0.007),
                TextApp(
                    text: 'سعر المنتج : ${orderInfo!.productPrice}',
                    size: SizeApp.textSize * 1.1,
                    fontWeight: FontWeight.bold,
                    textAlign: TextAlign.end,
                    color: bigTextColor),
                SizedBox(height: SizeApp.height * 0.007),
                TextApp(
                    text: 'الكمية : ${orderInfo!.amountProduct}',
                    size: SizeApp.textSize * 1.1,
                    fontWeight: FontWeight.normal,
                    textAlign: TextAlign.end,
                    color: smolleTextColor),
                SizedBox(height: SizeApp.height * 0.015),
                if (!orderInfo!.agreeSeller) ...{
                  ButtonApp(
                      buttonText: 'موافقة',
                      color: primaryColor,
                      width: SizeApp.width * 0.35,
                      height: SizeApp.height * 0.035,
                      fontSize: SizeApp.textSize * 1.2,
                      fontWeight: FontWeight.bold,
                      radius: SizeApp.buttonRadius,
                      onPressed: () {
                        orderInfo!.agreeSeller = true;
                        FirebaseAppHelper().updateOrderData(
                            id: orderInfo!.id, updateData: orderInfo!.toMap());
                      }),
                  SizedBox(height: SizeApp.height * 0.02),
                } else ...{
                  TextApp(
                      text: 'انتظار المندوب ',
                      size: SizeApp.textSize * 1.5,
                      fontWeight: FontWeight.normal,
                      textAlign: TextAlign.center,
                      color: bigTextColor)
                }
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../model/color_app.dart';
import '../model/data_information/order_info.dart';
import '../model/size_app.dart';
import '../widget/get_image.dart';
import '../widget/text.dart';

// ignore: must_be_immutable
class ProductItemUnderway extends StatelessWidget {
  OrderInfo results = OrderInfo();
  ProductItemUnderway({super.key, required this.results});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        height: SizeApp.height * 0.31,
        width: SizeApp.width * 0.45,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(SizeApp.dilogRadius),
          border: Border.all(color: bordarColor, width: SizeApp.width * 0.002),
          color: whiteColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: getImage(
              phone: results.phoneSeller,
              propertyName: results.propertyName,
              width: SizeApp.width * 0.2,
            )),
            Padding(
              padding: EdgeInsets.only(right: SizeApp.width * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextApp(
                      text: '${results.productPrice} ر.س.',
                      size: SizeApp.textSize * 1.2,
                      fontWeight: FontWeight.normal,
                      color: bigTextColor),
                  SizedBox(height: SizeApp.height * 0.01),
                  TextApp(
                      text: results.propertyName!,
                      size: SizeApp.textSize * 1.3,
                      fontWeight: FontWeight.normal,
                      color: bigTextColor),
                  SizedBox(height: SizeApp.height * 0.02)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

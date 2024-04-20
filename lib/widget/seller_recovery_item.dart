import 'package:flutter/material.dart';
import '../model/color_app.dart';
import '../model/data_information/recovery_info.dart';
import '../model/size_app.dart';
import '../widget/get_image.dart';
import '../widget/text.dart';

// ignore: must_be_immutable
class SellerRecoveryItem extends StatelessWidget {
  RecoveryInfo? results;

  SellerRecoveryItem({super.key, this.results});

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
                phone: results!.phoneSeller,
                propertyName: results!.propertyName,
                width: SizeApp.width * 0.2,
              )),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextApp(
                        text: results!.propertyName!,
                        size: SizeApp.textSize * 1.5,
                        fontWeight: FontWeight.bold,
                        textAlign: TextAlign.center,
                        color: bigTextColor),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: SizeApp.height * 0.01),
          TextApp(
              text: 'سبب الاسترجاع : ${results!.reasonReturn!}',
              size: SizeApp.textSize * 1.3,
              fontWeight: FontWeight.normal,
              textAlign: TextAlign.center,
              color: bigTextColor),
          SizedBox(height: SizeApp.height * 0.015),
          TextApp(
              text: 'جاري الاسترجاع',
              size: SizeApp.textSize * 1.3,
              fontWeight: FontWeight.normal,
              textAlign: TextAlign.center,
              color: bigTextColor),
        ],
      ),
    );
  }
}

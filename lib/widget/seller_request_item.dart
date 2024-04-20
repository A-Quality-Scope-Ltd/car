// ignore: file_names
import 'package:flutter/material.dart';
import '../model/color_app.dart';
import '../model/data_information/request_info.dart';
import '../model/size_app.dart';
import '../widget/button.dart';
import '../widget/get_image.dart';
import '../widget/show_dialog_app.dart';
import '../widget/text.dart';

import '../model/database/firebase_helper.dart';

// ignore: must_be_immutable
class SellerRequestsItem extends StatefulWidget {
  RequestInfo? requestInfo;
  SellerRequestsItem({
    super.key,
    this.requestInfo,
  });

  @override
  State<SellerRequestsItem> createState() => _SellerRequestsItemState();
}

class _SellerRequestsItemState extends State<SellerRequestsItem> {
  int hours = 5;
  int minutes = 59;
  @override
  void initState() {
    startTimer();
    super.initState();
  }

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
            phone: widget.requestInfo!.phoneSeller,
            propertyName: widget.requestInfo!.propertyName,
            width: SizeApp.width * 0.2,
          )),
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextApp(
                    text: 'اسم المنتج :${widget.requestInfo!.propertyName}',
                    size: SizeApp.textSize * 1.1,
                    fontWeight: FontWeight.bold,
                    textAlign: TextAlign.end,
                    color: bigTextColor),
                SizedBox(height: SizeApp.height * 0.03),
                SizedBox(
                  width: SizeApp.width * 1,
                  child: TextApp(
                      text: 'الوصف : ${widget.requestInfo!.descriptionRequest}',
                      size: SizeApp.textSize * 1.1,
                      fontWeight: FontWeight.bold,
                      textAlign: TextAlign.end,
                      color: bigTextColor),
                ),
                SizedBox(height: SizeApp.height * 0.015),
                if (!widget.requestInfo!.agreeSeller) ...{
                  ButtonApp(
                      buttonText: 'موافقة',
                      color: primaryColor,
                      width: SizeApp.width * 0.35,
                      height: SizeApp.height * 0.035,
                      fontSize: SizeApp.textSize * 1.2,
                      fontWeight: FontWeight.bold,
                      radius: SizeApp.buttonRadius,
                      onPressed: () {
                        widget.requestInfo!.agreeSeller = true;
                        widget.requestInfo!.deleteTime = '$hours:$minutes';
                        FirebaseAppHelper().updateRequestData(
                            id: widget.requestInfo!.id,
                            updateData: widget.requestInfo!.toMap());
                      }),
                  SizedBox(height: SizeApp.height * 0.02),
                  ButtonApp(
                      buttonText: 'رفض',
                      color: redColor,
                      width: SizeApp.width * 0.35,
                      height: SizeApp.height * 0.035,
                      fontSize: SizeApp.textSize * 1.2,
                      fontWeight: FontWeight.bold,
                      radius: SizeApp.buttonRadius,
                      onPressed: () {
                        showDialogApp(context,
                            title: 'هل انت متأكد من رفض الطلبية ؟',
                            cancel: () => Navigator.pop(context),
                            done: () {
                              FirebaseAppHelper().deleteRequest(
                                id: widget.requestInfo!.id,
                              );
                            });
                      })
                } else if (!widget.requestInfo!.agreeClient) ...{
                  TextApp(
                      text: 'انتظار تأكيد العميل',
                      size: SizeApp.textSize * 1.5,
                      fontWeight: FontWeight.normal,
                      textAlign: TextAlign.center,
                      color: bigTextColor)
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

  void startTimer() {
    if (widget.requestInfo!.agreeSeller) {
      Future.delayed(
          const Duration(
            minutes: 1,
          ), () {
        setState(() async {
          if (minutes > 0) {
            minutes--;
            widget.requestInfo!.deleteTime = '$hours:$minutes';
            FirebaseAppHelper().updateRequestData(
                id: widget.requestInfo!.id,
                updateData: widget.requestInfo!.toMap());
          } else if (hours > 0) {
            minutes = 59;
            hours--;
            widget.requestInfo!.deleteTime = '$hours:$minutes';
            FirebaseAppHelper().updateRequestData(
                id: widget.requestInfo!.id,
                updateData: widget.requestInfo!.toMap());
          } else if (!widget.requestInfo!.agreeClient) {
            FirebaseAppHelper().deleteRequest(id: widget.requestInfo!.id);
          }
        });
      });
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../model/color_app.dart';
import '../../../model/data_information/recovery_info.dart';
import '../../../model/database/firebase_helper.dart';
import '../../../model/size_app.dart';
import '../../../widget/button.dart';
import '../../../widget/custom_snack_bar.dart';
import '../../../widget/get_image.dart';
import '../../../widget/show_dialog_app.dart';
import '../../../widget/text.dart';
import 'lauch_whatsapp.dart';

// ignore: must_be_immutable
class RetrievalItemAdmin extends StatelessWidget {
  RecoveryInfo? results;
  final _formKey = GlobalKey<FormState>();
  RetrievalItemAdmin({super.key, this.results});
  final TextEditingController _controller = TextEditingController();

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
                  child: Column(
                children: [
                  TextApp(
                      text: 'العميل',
                      size: SizeApp.textSize * 1.5,
                      fontWeight: FontWeight.normal,
                      overflow: TextOverflow.visible,
                      textAlign: TextAlign.center,
                      color: bigTextColor),
                  SizedBox(height: SizeApp.height * 0.015),
                  SvgPicture.asset(
                    'assets/icons/ icon _location_.svg',
                    width: SizeApp.iconSize * 0.9,
                  ),
                  TextApp(
                      text: results!.locationClient!,
                      size: SizeApp.textSize * 0.9,
                      fontWeight: FontWeight.normal,
                      textAlign: TextAlign.center,
                      color: bigTextColor),
                  SizedBox(height: SizeApp.height * 0.015),
                  TextApp(
                      text: '${results!.phoneClient} : رقم الهاتف ',
                      size: SizeApp.textSize * 0.9,
                      fontWeight: FontWeight.normal,
                      textAlign: TextAlign.center,
                      color: bigTextColor),
                ],
              )),
              Expanded(
                  child: Column(
                children: [
                  TextApp(
                      text: 'البائع',
                      size: SizeApp.textSize * 1.5,
                      fontWeight: FontWeight.normal,
                      overflow: TextOverflow.visible,
                      textAlign: TextAlign.center,
                      color: bigTextColor),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width: SizeApp.width * 0.02),
                      SvgPicture.asset(
                        'assets/icons/user.svg',
                        width: SizeApp.iconSize * 0.5,
                      ),
                    ],
                  ),
                  SizedBox(height: SizeApp.height * 0.015),
                  SvgPicture.asset(
                    'assets/icons/ icon _location_.svg',
                    width: SizeApp.iconSize * 0.9,
                  ),
                  TextApp(
                      text: results!.locationSeller!,
                      size: SizeApp.textSize * 0.9,
                      fontWeight: FontWeight.normal,
                      textAlign: TextAlign.center,
                      color: bigTextColor),
                  SizedBox(height: SizeApp.height * 0.015),
                  TextApp(
                      text: '${results!.phoneSeller} : رقم الهاتف ',
                      size: SizeApp.textSize * 0.9,
                      fontWeight: FontWeight.normal,
                      textAlign: TextAlign.center,
                      color: bigTextColor),
                ],
              )),
            ],
          ),
          SizedBox(height: SizeApp.height * 0.015),
          TextApp(
              text: 'سبب الارجاع',
              size: SizeApp.textSize * 1.5,
              fontWeight: FontWeight.normal,
              textAlign: TextAlign.center,
              color: bigTextColor),
          SizedBox(height: SizeApp.height * 0.0015),
          TextApp(
              text: results!.reasonReturn!,
              size: SizeApp.textSize * 1,
              fontWeight: FontWeight.normal,
              textAlign: TextAlign.center,
              color: smolleTextColor),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    TextApp(
                        text: 'اسم المنتج : ${results!.propertyName}',
                        size: SizeApp.textSize * 1.1,
                        fontWeight: FontWeight.normal,
                        textAlign: TextAlign.center,
                        color: bigTextColor),
                    SizedBox(height: SizeApp.height * 0.015),
                  ],
                ),
              ),
              Expanded(
                  child: getImage(
                phone: results!.phoneSeller,
                propertyName: results!.propertyName,
                width: SizeApp.width * 0.2,
              )),
            ],
          ),
          results!.agree
              ? ButtonApp(
                  buttonText: 'تم إعادة الطلب إلى البائع',
                  color: primaryColor,
                  width: SizeApp.width * 0.6,
                  height: SizeApp.height * 0.05,
                  fontSize: SizeApp.textSize * 1.2,
                  fontWeight: FontWeight.bold,
                  radius: SizeApp.buttonRadius,
                  onPressed: () {
                    results!.sendRecovery = true;
                    try {
                      FirebaseAppHelper().updateOrderData(
                          id: results!.id, updateData: results!.toMap());
                      FirebaseAppHelper().deleteOrder(id: results!.id);
                    } catch (e) {
                      customSnackBar(
                          context: context,
                          text: 'تأكد من أتصالك '
                              'بالشبكة'
                              ' ');
                    }
                  })
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ButtonApp(
                        buttonText: 'رفض',
                        color: redColor,
                        width: SizeApp.width * 0.35,
                        height: SizeApp.height * 0.04,
                        fontSize: SizeApp.textSize * 1.2,
                        fontWeight: FontWeight.bold,
                        radius: SizeApp.buttonRadius,
                        onPressed: () {
                          showDialogApp(context,
                              title: 'هل انت متأكد من رفض الطلب ؟',
                              cancel: () => Navigator.pop(context),
                              done: () {
                                Navigator.pop(context);
                                showDialogAppReasonForDeletionReasonOfRefuse(
                                  context,
                                  formKey: _formKey,
                                  title: 'سبب الرفض',
                                  controller: _controller,
                                  validator: (value) {
                                    if (!RegExp(r'^.').hasMatch(value!)) {
                                      return 'الحقل فارغ';
                                    }
                                    return null;
                                  },
                                  done: () {
                                    if (_formKey.currentState!.validate()) {
                                      launchWhatsApp(
                                        consigneeNumber: results!.phoneClient!,
                                        titleMessage: 'سبب الرفض',
                                        textMessage: _controller.text,
                                      );
                                      Navigator.pop(context);
                                    }
                                  },
                                );
                              });
                        }),
                    ButtonApp(
                        buttonText: 'موافقة',
                        color: primaryColor,
                        width: SizeApp.width * 0.35,
                        height: SizeApp.height * 0.04,
                        fontSize: SizeApp.textSize * 1.2,
                        fontWeight: FontWeight.bold,
                        radius: SizeApp.buttonRadius,
                        onPressed: () {
                          results!.agree = true;
                          FirebaseAppHelper().updateOrderData(
                              id: results!.id, updateData: results!.toMap());
                        })
                  ],
                )
        ],
      ),
    );
  }
}

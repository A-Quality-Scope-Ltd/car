import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../model/color_app.dart';
import '../../../model/data_information/request_info.dart';
import '../../../model/database/firebase_helper.dart';
import '../../../model/size_app.dart';
import '../../../widget/button.dart';
import '../../../widget/custom_snack_bar.dart';
import '../../../widget/get_image.dart';
import '../../../widget/show_dialog_app.dart';
import '../../../widget/text.dart';

import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class RequestItemAdmin extends StatefulWidget {
  RequestInfo? results;

  RequestItemAdmin({
    super.key,
    this.results,
  });

  @override
  State<RequestItemAdmin> createState() => _RequestItemAdminState();
}

class _RequestItemAdminState extends State<RequestItemAdmin> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controllerPhoneNumber =
      TextEditingController(text: '05');

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
                      text: widget.results!.locationSeller!,
                      size: SizeApp.textSize * 0.9,
                      fontWeight: FontWeight.normal,
                      textAlign: TextAlign.center,
                      color: bigTextColor),
                  SizedBox(height: SizeApp.height * 0.015),
                  TextApp(
                      text: 'رقم الهاتف : ${widget.results!.phoneSeller!}',
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
                      text: widget.results!.locationClient!,
                      size: SizeApp.textSize * 0.9,
                      fontWeight: FontWeight.normal,
                      textAlign: TextAlign.center,
                      color: bigTextColor),
                  SizedBox(height: SizeApp.height * 0.015),
                  TextApp(
                      text: 'رقم الهاتف : ${widget.results!.phoneClient}',
                      size: SizeApp.textSize * 0.9,
                      fontWeight: FontWeight.normal,
                      textAlign: TextAlign.center,
                      color: bigTextColor),
                ],
              )),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  child: getImage(
                phone: widget.results!.phoneSeller,
                propertyName: widget.results!.propertyName,
                width: SizeApp.width * 0.2,
              )),
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    TextApp(
                        text: 'اسم المنتج : ${widget.results!.propertyName}',
                        size: SizeApp.textSize * 1.1,
                        fontWeight: FontWeight.normal,
                        textAlign: TextAlign.center,
                        color: bigTextColor),
                    SizedBox(height: SizeApp.height * 0.015),
                    TextApp(
                        text: 'وقت التسليم : ${widget.results!.time}',
                        size: SizeApp.textSize * 1.1,
                        fontWeight: FontWeight.normal,
                        textAlign: TextAlign.center,
                        color: bigTextColor),
                  ],
                ),
              ),
            ],
          ),
          if (widget.results!.agreeSeller) ...{
            if (widget.results!.agreeClient) ...{
              ButtonApp(
                  buttonText: 'إرسال إلى المندوب',
                  color: redColor,
                  width: SizeApp.width * 0.5,
                  height: SizeApp.height * 0.05,
                  fontSize: SizeApp.textSize * 1.2,
                  fontWeight: FontWeight.bold,
                  radius: SizeApp.buttonRadius,
                  onPressed: () {
                    showDialogAppReasonForDeletionReasonOfRefuse(
                      context,
                      title: 'ادخل رقم المندوب',
                      formKey: _formKey,
                      validator: (value) {
                        if (!RegExp(r'^\d{10,}$').hasMatch(value!)) {
                          return 'الرجاء إدخال الرقم كامل';
                        } else if (!RegExp(r'^\d{10,10}$').hasMatch(value)) {
                          return 'الرقم زائد';
                        }
                        return null;
                      },
                      controller: _controllerPhoneNumber,
                      done: () {
                        if (_formKey.currentState!.validate()) {
                          _launchWhatsApp(
                            consigneeNumber: _controllerPhoneNumber.text,
                          );
                          widget.results!.agreeAdmin = true;
                          FirebaseAppHelper().updateRequestData(
                              id: widget.results!.id,
                              updateData: widget.results!.toMap());
                        }
                      },
                    );
                  }),
            } else ...{
              TextApp(
                  text: 'إنتظار دفع العميل للطلبية',
                  size: SizeApp.textSize * 1.4,
                  fontWeight: FontWeight.normal,
                  textAlign: TextAlign.center,
                  color: bigTextColor),
            }
          } else ...{
            TextApp(
                text: 'إنتظار تأكيد البائع للطلبية',
                size: SizeApp.textSize * 1.4,
                fontWeight: FontWeight.normal,
                textAlign: TextAlign.center,
                color: bigTextColor),
          },
          if (widget.results!.agreeSeller == true &&
              widget.results!.agreeClient == true) ...{
            ButtonApp(
                buttonText: 'تم إرسال الطلب إلى العميل',
                color: primaryColor,
                width: SizeApp.width * 0.6,
                height: SizeApp.height * 0.05,
                fontSize: SizeApp.textSize * 1.2,
                fontWeight: FontWeight.bold,
                radius: SizeApp.buttonRadius,
                onPressed: () {
                  showDialogApp(
                    context,
                    title: 'هل انت متأكد من تم إرسال الطلب',
                    done: () {
                      try {
                        FirebaseAppHelper()
                            .deleteRequest(id: widget.results!.id);
                        Navigator.pop(context);
                      } catch (e) {
                        customSnackBar(
                            context: context,
                            text: 'تأكد من أتصالك '
                                'بالشبكة'
                                ' ');
                        Navigator.pop(context);
                      }
                      ;
                    },
                    cancel: () {
                      Navigator.pop(context);
                    },
                  );
                }),
          },
          SizedBox(height: SizeApp.height * 0.015),
        ],
      ),
    );
  }

  //this Function for the launchWhatsApp message
  void _launchWhatsApp({
    required String consigneeNumber,
  }) async {
    // location URL IOS for Seller and Client
    final String urlSellerIOS =
        'http://maps.apple.com/?ll=${widget.results!.latSeller},${widget.results!.longSeller}';
    final String urlClientIOS =
        'http://maps.apple.com/?ll=${widget.results!.latClient},${widget.results!.longClient}';

    // location URL Android for Seller and Client
    final String urlSellerAndroid =
        'geo:${widget.results!.latSeller},${widget.results!.longSeller}';
    final String urlClientAndroid =
        'geo:${widget.results!.latClient},${widget.results!.longClient}';

    String message = '''البائع 
رقم البائع : ${widget.results!.phoneSeller}
موقع البائع : ${Platform.isIOS ? urlSellerIOS : urlSellerAndroid}\n\n
العميل
رقم العميل : ${widget.results!.phoneClient}
موقع العميل : ${Platform.isIOS ? urlClientIOS : urlClientAndroid}
    ''';
    //launch the wahtsapp IOS and Android message
    final String whatsappURLIos =
        'https://wa.me/$consigneeNumber/?text=$message';
    final String whatsappURlAndroid =
        'whatsapp://send?phone=$consigneeNumber&text=$message';

    if (Platform.isIOS) {
      // for iOS phone only
      if (await canLaunchUrl(Uri.parse(whatsappURLIos))) {
        await launchUrl(Uri.parse(whatsappURLIos));
      }
    } else {
      // android , web
      if (await canLaunchUrl(Uri.parse(whatsappURlAndroid))) {
        await launchUrl(Uri.parse(whatsappURlAndroid));
      }
    }
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../model/color_app.dart';
import '../../../model/data_information/order_info.dart';
import '../../../model/data_information/recovery_info.dart';
import '../../../model/database/firebase_helper.dart';
import '../../../model/size_app.dart';
import '../../../widget/button.dart';
import '../../../widget/custom_snack_bar.dart';
import '../../../widget/get_image.dart';
import '../../../widget/show_dialog_app.dart';
import '../../../widget/text.dart';
import 'lauch_whatsapp.dart';

import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class OrderItemAdmin extends StatelessWidget {
  String page;
  OrderInfo results = OrderInfo();
  String seller = 'البائع';
  String client = 'العميل';
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controllerPhoneNumber =
      TextEditingController(text: '05');
  final TextEditingController _controller = TextEditingController();

  OrderItemAdmin({
    super.key,
    this.page = 'قيد التنفيذ',
    required this.results,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          left: SizeApp.width * 0.05,
          right: SizeApp.width * 0.05,
          top: SizeApp.height * 0.017,
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
                      text: client,
                      size: SizeApp.textSize * 1.5,
                      fontWeight: FontWeight.normal,
                      overflow: TextOverflow.visible,
                      textAlign: TextAlign.center,
                      color: bigTextColor),
                  SizedBox(height: SizeApp.height * 0.015),
                  SvgPicture.asset(
                    'assets/icons/user.svg',
                    width: SizeApp.iconSize * 0.5,
                  ),
                  SizedBox(height: SizeApp.height * 0.015),
                  SvgPicture.asset(
                    'assets/icons/ icon _location_.svg',
                    width: SizeApp.iconSize * 0.9,
                  ),
                  TextApp(
                      text: results.locationClient!,
                      size: SizeApp.textSize * 0.9,
                      fontWeight: FontWeight.normal,
                      textAlign: TextAlign.center,
                      color: bigTextColor),
                  SizedBox(height: SizeApp.height * 0.015),
                  TextApp(
                      text: '${results.phoneClient} : رقم الهاتف ',
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
                      text: seller,
                      size: SizeApp.textSize * 1.5,
                      fontWeight: FontWeight.normal,
                      overflow: TextOverflow.visible,
                      textAlign: TextAlign.center,
                      color: bigTextColor),
                  SizedBox(width: SizeApp.width * 0.02),
                  SvgPicture.asset(
                    'assets/icons/user.svg',
                    width: SizeApp.iconSize * 0.5,
                  ),
                  SizedBox(height: SizeApp.height * 0.015),
                  SvgPicture.asset(
                    'assets/icons/ icon _location_.svg',
                    width: SizeApp.iconSize * 0.9,
                  ),
                  TextApp(
                      text: results.locationSeller!,
                      size: SizeApp.textSize * 0.9,
                      fontWeight: FontWeight.normal,
                      textAlign: TextAlign.center,
                      color: bigTextColor),
                  SizedBox(height: SizeApp.height * 0.015),
                  TextApp(
                      text: '${results.phoneSeller} : رقم الهاتف ',
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
                flex: 2,
                child: Column(
                  children: [
                    TextApp(
                        text: 'اسم المنتج : ${results.propertyName}',
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
                phone: results.phoneSeller,
                propertyName: results.propertyName,
                width: SizeApp.width * 0.2,
              )),
            ],
          ),
          page == 'قيد التنفيذ'
              ? Column(
                  children: [
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
                              results.sendOrder = true;
                              try {
                                FirebaseAppHelper().updateOrderData(
                                    id: results.id,
                                    updateData: results.toMap());
                                FirebaseAppHelper().deleteOrder(id: results.id);
                                if (results.retrievability) {
                                  RecoveryInfo recoveryInfo =
                                      RecoveryInfo.fromJson(results.toMap());
                                  FirebaseAppHelper().setOrderReturnsData(
                                      id: recoveryInfo.id,
                                      setOrder: recoveryInfo.toMap());
                                  Navigator.pop(context);
                                }
                              } catch (e) {
                                customSnackBar(
                                    context: context,
                                    text: 'تأكد من أتصالك '
                                        'بالشبكة'
                                        ' ');
                              }
                            },
                            cancel: () {
                              Navigator.pop(context);
                            },
                          );
                        }),
                    SizedBox(height: SizeApp.height * 0.015),
                    ButtonApp(
                        buttonText: 'إعدة إرسال إلى المندوب',
                        color: redColor,
                        width: SizeApp.width * 0.5,
                        height: SizeApp.height * 0.05,
                        fontSize: SizeApp.textSize * 1.2,
                        fontWeight: FontWeight.bold,
                        radius: SizeApp.buttonRadius,
                        onPressed: () {
                          if (results.agreeSeller) {
                            showDialogAppReasonForDeletionReasonOfRefuse(
                              context,
                              title: 'ادخل رقم المندوب',
                              formKey: _formKey,
                              validator: (value) {
                                if (!RegExp(r'^\d{10,}$').hasMatch(value!)) {
                                  return 'الرجاء إدخال الرقم كامل';
                                } else if (!RegExp(r'^\d{10,10}$')
                                    .hasMatch(value)) {
                                  return 'الرقم زائد';
                                }
                                return null;
                              },
                              controller: _controllerPhoneNumber,
                              done: () {
                                if (_formKey.currentState!.validate()) {
                                  _launchWhatsApp(
                                    consigneeNumber:
                                        _controllerPhoneNumber.text,
                                  );
                                  results.agreeAdmin = true;
                                  FirebaseAppHelper().updateOrderData(
                                      id: results.id,
                                      updateData: results.toMap());
                                }
                              },
                            );
                          }
                        }),
                  ],
                )
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
                                        consigneeNumber: results.phoneClient!,
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
                        color: results.agreeSeller
                            ? primaryColor
                            : smolleTextColor,
                        width: SizeApp.width * 0.35,
                        height: SizeApp.height * 0.04,
                        fontSize: SizeApp.textSize * 1.2,
                        fontWeight: FontWeight.bold,
                        radius: SizeApp.buttonRadius,
                        onPressed: () {
                          if (results.agreeSeller) {
                            showDialogAppReasonForDeletionReasonOfRefuse(
                              context,
                              title: 'ادخل رقم المندوب',
                              formKey: _formKey,
                              validator: (value) {
                                if (!RegExp(r'^\d{10,}$').hasMatch(value!)) {
                                  return 'الرجاء إدخال الرقم كامل';
                                } else if (!RegExp(r'^\d{10,10}$')
                                    .hasMatch(value)) {
                                  return 'الرقم زائد';
                                }
                                return null;
                              },
                              controller: _controllerPhoneNumber,
                              done: () {
                                if (_formKey.currentState!.validate()) {
                                  _launchWhatsApp(
                                    consigneeNumber:
                                        _controllerPhoneNumber.text,
                                  );
                                  results.agreeAdmin = true;
                                  FirebaseAppHelper().updateOrderData(
                                      id: results.id,
                                      updateData: results.toMap());
                                }
                              },
                            );
                          }
                        })
                  ],
                )
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
        'http://maps.apple.com/?ll=${results.latSeller},${results.longSeller}';
    final String urlClientIOS =
        'http://maps.apple.com/?ll=${results.latClient},${results.longClient}';

    // location URL Android for Seller and Client
    final String urlSellerAndroid =
        'geo:${results.latSeller},${results.longSeller}';
    final String urlClientAndroid =
        'geo:${results.latClient},${results.longClient}';

    String message = '''البائع 
رقم البائع : ${results.phoneSeller}
موقع البائع : ${Platform.isIOS ? urlSellerIOS : urlSellerAndroid}\n\n
العميل
رقم العميل : ${results.phoneClient}
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

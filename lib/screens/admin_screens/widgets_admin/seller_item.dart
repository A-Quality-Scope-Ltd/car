import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../model/color_app.dart';
import '../../../model/database/firebase_helper.dart';
import '../../../model/size_app.dart';
import '../../../widget/button.dart';
import '../../../widget/full_screen_image.dart';
import '../../../widget/get_image.dart';
import '../../../widget/show_dialog_app.dart';
import '../../../widget/text.dart';
import 'lauch_whatsapp.dart';

// ignore: must_be_immutable
class SellerItem extends StatelessWidget {
  String tab;
  String name;
  String phone;
  String statement;
  String location;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _controller = TextEditingController();
  TextEditingController _controller2 = TextEditingController();

  SellerItem({
    super.key,
    required this.tab,
    required this.name,
    required this.phone,
    required this.statement,
    required this.location,
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
      height: SizeApp.height * 0.35,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(SizeApp.cardRadius),
        border: Border.all(
            color: bordarColor.withOpacity(0.5), width: SizeApp.width * 0.002),
        color: whiteColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(SizeApp.cardRadius),
                border: Border.all(
                    color: bordarColor.withOpacity(0.5),
                    width: SizeApp.width * 0.002),
                color: whiteColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: GestureDetector(
                  onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FullScreenImage(
                            id: phone,
                            url: statement,
                          ),
                        ),
                      ),
                  child: getImage(phone: phone, propertyName: statement)),
            ),
          ),
          SizedBox(width: SizeApp.width * 0.02),
          Expanded(
            child: Column(
              children: [
                SizedBox(
                  width: SizeApp.width * 0.4,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextApp(
                        text: name,
                        size: SizeApp.textSize * 1.1,
                        fontWeight: FontWeight.normal,
                        overflow: TextOverflow.visible,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        color: bigTextColor,
                      ),
                      SizedBox(width: SizeApp.width * 0.02),
                      SvgPicture.asset(
                        'assets/icons/user.svg',
                        width: SizeApp.iconSize * 0.5,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: SizeApp.height * 0.02),
                SvgPicture.asset(
                  'assets/icons/ icon _location_.svg',
                  width: SizeApp.iconSize * 0.9,
                ),
                TextApp(
                  text: location,
                  size: SizeApp.textSize * 0.9,
                  fontWeight: FontWeight.normal,
                  textAlign: TextAlign.center,
                  maxLines: 3,
                  color: bigTextColor,
                ),
                SizedBox(
                    height: tab == 'tab 2'
                        ? SizeApp.height * 0.03
                        : SizeApp.height * 0.04),
                TextApp(
                    text: '$phone : رقم الهاتف ',
                    size: SizeApp.textSize * 0.9,
                    fontWeight: FontWeight.normal,
                    textAlign: TextAlign.center,
                    color: bigTextColor),
                if (tab == 'tab 1') ...{
                  SizedBox(height: SizeApp.height * 0.04),
                  ButtonApp(
                      buttonText: 'حذف',
                      color: redColor,
                      width: SizeApp.width * 0.35,
                      height: SizeApp.height * 0.04,
                      fontSize: SizeApp.textSize * 1.2,
                      fontWeight: FontWeight.bold,
                      radius: SizeApp.buttonRadius,
                      onPressed: () {
                        showDialogApp(context,
                            title: 'هل انت متأكد من حذف البائع ؟',
                            cancel: () => Navigator.pop(context),
                            done: () {
                              FirebaseAppHelper().deleteSeller(phone: phone);
                              FirebaseAppHelper().deleteImage(image: phone);
                              Navigator.pop(context);
                              showDialogAppReasonForDeletionReasonOfRefuse(
                                context,
                                formKey: _formKey,
                                title: 'سبب الحذف',
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
                                      consigneeNumber: phone,
                                      titleMessage: 'سبب الحذف',
                                      textMessage: _controller.text,
                                    );
                                    Navigator.pop(context);
                                  }
                                },
                              );
                            });
                      })
                } else if (tab == 'tab 2') ...{
                  SizedBox(height: SizeApp.height * 0.015),
                  ButtonApp(
                      buttonText: 'موافقة',
                      color: primaryColor,
                      width: SizeApp.width * 0.35,
                      height: SizeApp.height * 0.035,
                      fontSize: SizeApp.textSize * 1.2,
                      fontWeight: FontWeight.bold,
                      radius: SizeApp.buttonRadius,
                      onPressed: () {
                        FirebaseAppHelper().updateSellerData(
                            phone: phone, updateData: {'allow': true});
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
                            title: 'هل انت متأكد من رفض البائع ؟',
                            cancel: () => Navigator.pop(context),
                            done: () {
                              FirebaseAppHelper().deleteSeller(phone: phone);
                              FirebaseAppHelper()
                                  .deleteImage(image: '$phone/statement');
                              Navigator.pop(context);
                              showDialogAppReasonForDeletionReasonOfRefuse(
                                context,
                                formKey: _formKey,
                                title: 'سبب الرفض',
                                controller: _controller2,
                                validator: (value) {
                                  if (!RegExp(r'^.').hasMatch(value!)) {
                                    return 'الحقل فارغ';
                                  }
                                  return null;
                                },
                                done: () {
                                  if (_formKey.currentState!.validate()) {
                                    launchWhatsApp(
                                      consigneeNumber: phone,
                                      titleMessage: 'سبب الرفض',
                                      textMessage: _controller2.text,
                                    );
                                    Navigator.pop(context);
                                  }
                                },
                              );
                            });
                      })
                },
              ],
            ),
          ),
        ],
      ),
    );
  }
}

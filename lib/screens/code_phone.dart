import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';
import '../model/color_app.dart';
import '../model/data_information/accuont_registration_info.dart';
import '../model/database/firebase_helper.dart';
import '../model/provider_app.dart';
import '../model/sharedpreferances/sharedpreferances_keys_.dart';
import '../model/sharedpreferances/sharedpreferences_users.dart';
import '../model/size_app.dart';
import '../screens/admin_screens/dash_board.dart';
import '../screens/home_tap_bar_navigation.dart';
import '../screens/seller/register_new_seller.dart';
import '../screens/seller/seller.dart';
import '../widget/app_bar_with_button_back.dart';
import '../widget/button.dart';
import '../widget/custom_snack_bar.dart';
import '../widget/text.dart';
import 'package:provider/provider.dart';

import '../model/data_information/seller_registration_info.dart';

// ignore: must_be_immutable
class CodePhone extends StatefulWidget {
  String? phoneNumber;
  TextEditingController? controllerPinCode = TextEditingController();
  CodePhone({
    super.key,
    this.phoneNumber,
    this.controllerPinCode,
  });

  @override
  State<CodePhone> createState() => _CodePhoneState();
}

class _CodePhoneState extends State<CodePhone> {
  String verificationId = '';
  FirebaseAuth auth = FirebaseAuth.instance;

  String smsCode = '';

  @override
  void initState() {
    verifyPhoneNumber();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: whiteColor,
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                SizeApp.padding, SizeApp.height * 0.07, SizeApp.padding, 0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const AppBarWithButtonBack(),
                  SizedBox(
                    height: SizeApp.height * 0.04,
                  ),
                  TextApp(
                      text: 'تأكيد الرمز السري',
                      size: SizeApp.textSize * 1.8,
                      fontWeight: FontWeight.normal,
                      color: bigTextColor),
                  SizedBox(
                    height: SizeApp.height * 0.08,
                  ),
                  TextApp(
                      text:
                          'فضلاً ادخل الرمز الذي تم إرساله لرقم الجوال \n ${widget.phoneNumber} ',
                      size: SizeApp.textSize * 1,
                      fontWeight: FontWeight.normal,
                      textAlign: TextAlign.center,
                      color: bigTextColor),
                  SizedBox(
                    height: SizeApp.height * 0.06,
                  ),
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: PinCodeFields(
                      padding: EdgeInsets.zero,
                      margin: EdgeInsets.zero,
                      length: 6,
                      fieldBorderStyle: FieldBorderStyle.square,
                      responsive: false,
                      fieldHeight: SizeApp.height * 0.054,
                      fieldWidth: SizeApp.height * 0.048,
                      borderWidth: SizeApp.textSize * 0.06,
                      activeBorderColor: primaryColor,
                      activeBackgroundColor: whiteColor,
                      borderColor: bordarColor,
                      fieldBackgroundColor: whiteColor,
                      borderRadius: BorderRadius.circular(SizeApp.buttonRadius),
                      keyboardType: TextInputType.number,
                      autoHideKeyboard: false,
                      textStyle: TextStyle(
                        fontSize: SizeApp.textSize * 1.6,
                        fontWeight: FontWeight.bold,
                      ),
                      controller: widget.controllerPinCode,
                      onComplete: (output) {
                        smsCode = output;
                      },
                    ),
                  ),
                  SizedBox(
                    height: SizeApp.height * 0.06,
                  ),
                  ButtonApp(
                    buttonText: 'تحقق',
                    color: redColor,
                    width: SizeApp.width * 0.7,
                    fontSize: SizeApp.textSize * 1.7,
                    radius: SizeApp.buttonRadius,
                    onPressed: () {
                      verifyOTP(context);
                    },
                  ),
                  SizedBox(
                    height: SizeApp.height * 0.12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextApp(
                          text: 'لم يصلك الرمز بعد؟',
                          size: SizeApp.textSize * 1.2,
                          fontWeight: FontWeight.normal,
                          color: bigTextColor),
                      SizedBox(
                        width: SizeApp.width * 0.015,
                      ),
                      TextApp(
                        text: 'اطلب رمز آخر',
                        size: SizeApp.textSize * 1.3,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                        onClick: () {
                          verifyPhoneNumber();
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }

  void verifyPhoneNumber() async {
    await auth.verifyPhoneNumber(
      phoneNumber: "+966${widget.phoneNumber!}",
      verificationCompleted: (PhoneAuthCredential credential) async {},
      verificationFailed: (FirebaseAuthException e) {
        customSnackBar(
            context: context, text: 'فشل التحقق من الرمز: ${e.message}');
      },
      codeSent: (verificationId, resendToken) {
        this.verificationId = verificationId;
        customSnackBar(context: context, text: 'تم إرسال الرمز بنجاح');
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        this.verificationId = verificationId;
        customSnackBar(
            context: context, text: 'انتهى وقت استرجاع الرمز تلقائيا');
      },
    );
  }

  verifyOTP(context) async {
    var data = await FirebaseAppHelper().getAdmin();
    String phone = data['phone'];
    ProviderApp dataProvide = Provider.of<ProviderApp>(context, listen: false);
  }
}

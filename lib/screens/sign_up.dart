import 'package:flutter/material.dart';
import '../model/color_app.dart';

import '../model/size_app.dart';
import '../screens/login.dart';
import '../widget/app_bar_with_button_back.dart';
import '../widget/button.dart';
import 'package:provider/provider.dart';

import '../model/database/firebase_helper.dart';
import '../model/provider_app.dart';
import '../model/sharedpreferances/sharedpreferances_keys_.dart';
import '../model/sharedpreferances/sharedpreferences_users.dart';
import '../widget/show_dialog_app.dart';

// ignore: must_be_immutable
class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    ProviderApp dataProvide = Provider.of<ProviderApp>(context);
    return Scaffold(
        backgroundColor: whiteColor,
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                SizeApp.padding, SizeApp.height * 0.07, SizeApp.padding, 0),
            child: Column(
              children: [
                AppBarWithButtonBack(),
                SizedBox(
                  height: SizeApp.height * 0.2,
                ),
                Image.asset('assets/images/logo.png'),
                SizedBox(
                  height: SizeApp.height * 0.1,
                ),
                if (dataProvide.phone == '' || dataProvide.userType) ...{
                  ButtonApp(
                    buttonText: 'تسجيل مستخدم',
                    color: redColor,
                    width: SizeApp.width * 0.7,
                    fontSize: SizeApp.textSize * 1.7,
                    radius: SizeApp.buttonRadius,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Login(),
                          ));
                    },
                  ),
                  SizedBox(
                    height: SizeApp.height * 0.05,
                  ),
                } else if (dataProvide.phone != '' &&
                    !dataProvide.userType) ...{
                  ButtonApp(
                      buttonText: 'تسجيل خروج',
                      color: primaryColor,
                      width: SizeApp.width * 0.7,
                      fontSize: SizeApp.textSize * 1.7,
                      radius: SizeApp.buttonRadius,
                      onPressed: () {
                        showDialogApp(
                          context,
                          title: 'هل انت متأكد من تسجيل الخروج',
                          done: () {
                            Provider.of<ProviderApp>(context, listen: false)
                                .changeNotifierID(phone: '', userType: false);
                            SharedPreferencesSignup().saveData(
                                key: SharedPreferencesKeys.userType, value: '');
                            SharedPreferencesSignup().saveData(
                                key: SharedPreferencesKeys.phone, value: '');
                            setState(() {});
                            Navigator.pop(context);
                          },
                          cancel: () {
                            Navigator.pop(context);
                          },
                        );
                      }),
                  SizedBox(
                    height: SizeApp.height * 0.05,
                  ),
                  ButtonApp(
                      buttonText: 'حذف الحساب',
                      color: redColor,
                      width: SizeApp.width * 0.7,
                      fontSize: SizeApp.textSize * 1.7,
                      radius: SizeApp.buttonRadius,
                      onPressed: () {
                        showDialogApp(
                          context,
                          title: 'هل انت متأكد من حذف الحساب',
                          done: () {
                            FirebaseAppHelper()
                                .deleteUserData(dataProvide.phone);
                            Provider.of<ProviderApp>(context, listen: false)
                                .changeNotifierID(phone: '', userType: false);
                            SharedPreferencesSignup().saveData(
                                key: SharedPreferencesKeys.userType, value: '');
                            SharedPreferencesSignup().saveData(
                                key: SharedPreferencesKeys.phone, value: '');
                            setState(() {});
                            Navigator.pop(context);
                          },
                          cancel: () {
                            Navigator.pop(context);
                          },
                        );
                      })
                }
              ],
            ),
          ),
        ));
  }
}

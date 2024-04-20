import 'package:flutter/material.dart';
import '../model/color_app.dart';
import '../model/provider_app.dart';
import '../model/size_app.dart';
import '../screens/code_phone.dart';
import '../widget/app_bar_with_button_back.dart';
import '../widget/button.dart';
import '../widget/text.dart';
import '../widget/text_field.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class Login extends StatefulWidget {
  bool isSeller;
  Login({super.key, this.isSeller = false});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _controllerPhoneNumber =
      TextEditingController(text: '05');

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: whiteColor,
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                  SizeApp.padding, SizeApp.height * 0.07, SizeApp.padding, 0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const AppBarWithButtonBack(),
                    SizedBox(
                      height: SizeApp.height * 0.15,
                    ),
                    Image.asset('assets/images/logo.png'),
                    SizedBox(
                      height: SizeApp.height * 0.06,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextApp(
                            text: 'رقم الجوال',
                            size: SizeApp.textSize * 1.3,
                            fontWeight: FontWeight.normal,
                            color: bigTextColor),
                        SizedBox(
                          height: SizeApp.height * 0.01,
                        ),
                        TextFieldApp(
                          width: SizeApp.width * 0.7,
                          style: TextStyle(fontSize: SizeApp.textSize * 1.3),
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          controller: _controllerPhoneNumber,
                          validator: (value) {
                            if (!RegExp(r'^\d{10,}$').hasMatch(value!)) {
                              return 'الرجاء إدخال الرقم كامل';
                            } else if (!RegExp(r'^\d{10,10}$')
                                .hasMatch(value)) {
                              return 'الرقم زائد';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: SizeApp.height * 0.03,
                    ),
                    ButtonApp(
                      buttonText: 'تسجيل دخول',
                      color: primaryColor,
                      width: SizeApp.width * 0.7,
                      fontSize: SizeApp.textSize * 1.7,
                      radius: SizeApp.buttonRadius,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Provider.of<ProviderApp>(context, listen: false)
                              .changeNotifierID(
                                  userType: widget.isSeller, phone: '');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CodePhone(
                                      phoneNumber: _controllerPhoneNumber.text,
                                    )),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}

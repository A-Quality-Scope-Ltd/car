// ignore_for_file: must_be_immutable

import 'package:car/screens/home_tap_bar_navigation.dart';
import 'package:car/screens/seller/seller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'model/color_app.dart';
import 'model/data_information/accuont_registration_info.dart';
import 'model/data_information/seller_registration_info.dart';
import 'model/provider_app.dart';
import 'model/sharedpreferances/sharedpreferances_keys_.dart';
import 'model/sharedpreferances/sharedpreferences_users.dart';
import 'model/size_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  firebaseInitializeApp();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => ProviderApp()),
  ], child: const FroductiveFamilies()));
}

firebaseInitializeApp() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class FroductiveFamilies extends StatefulWidget {
  const FroductiveFamilies({super.key});

  @override
  State<FroductiveFamilies> createState() => _FroductiveFamiliesState();
}

class _FroductiveFamiliesState extends State<FroductiveFamilies> {
  bool userType = false;
  String phone = '';
  @override
  void initState() {
    initData();
    super.initState();
  }

  initData() async {
    await SharedPreferencesSignup.getData(SharedPreferencesKeys.userType)
        .then((value) async {
      if (value == 'بائع') {
        userType = true;
      }
    });
    await SharedPreferencesSignup.getData(SharedPreferencesKeys.phone)
        .then((value) async {
      phone = value;
      if (userType) {
        try {
          // ignore: use_build_context_synchronously
          Provider.of<ProviderApp>(context, listen: false)
              .changeNotifierID(phone: phone, userType: userType);
          await FirebaseFirestore.instance
              .collection('Sellers')
              .doc(phone)
              .get()
              .then(
            (value) {
              Provider.of<ProviderApp>(context, listen: false)
                  .changeNotifierDataSeller(
                      accountInfoData:
                          SellerRegistrationInfo.fromJson(value.data()));
            },
          );
        } catch (e) {
          print(e);
        }
      }
    });
    if (!userType && phone != 'null') {
      // ignore: use_build_context_synchronously
      Provider.of<ProviderApp>(context, listen: false)
          .changeNotifierID(phone: phone, userType: userType);
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(phone)
          .get()
          .then(
        (value) {
          Provider.of<ProviderApp>(context, listen: false)
              .changeNotifierDataUser(
                  accountInfoData:
                      AccountRegistrationInfo.fromJson(value.data()));
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeApp.initializeSize(context);
    ProviderApp dataProvide = Provider.of<ProviderApp>(context);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Froductive Families',
        theme: appThemeData,
        home: SplashScreen(
          phone: phone,
          userType: userType,
          allow: dataProvide.sellInfo.allow,
        ));
  }
}

class SplashScreen extends StatefulWidget {
  bool? userType;
  String? phone;
  bool allow = false;
  SplashScreen({super.key, this.userType, this.phone, this.allow = false});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 5), // Change the duration as needed
      () async {
        if (widget.userType!) {
          if (widget.allow) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Seller()),
            );
          } else {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const HomeTapBarNavigation()));
          }
          ;
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const HomeTapBarNavigation()),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: splachScreenColor,
      body: Center(
        child: Image.asset('assets/images/logo.png'),
      ),
    );
  }
}

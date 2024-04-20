import 'package:flutter/foundation.dart';

import 'data_information/accuont_registration_info.dart';
import 'data_information/seller_registration_info.dart';

class ProviderApp with ChangeNotifier {
  bool userType = false;
  String phone = '';
  AccountRegistrationInfo accountInfo = AccountRegistrationInfo();
  SellerRegistrationInfo sellInfo = SellerRegistrationInfo();

  void changeNotifierID({bool userType = false, String phone = ''}) {
    this.userType = userType;
    this.phone = phone;

    notifyListeners();
  }

  void changeNotifierDataUser(
      {required AccountRegistrationInfo accountInfoData}) {
    accountInfo = accountInfoData;
    notifyListeners();
  }

  void changeNotifierDataSeller(
      {required SellerRegistrationInfo accountInfoData}) {
    sellInfo = accountInfoData;
    notifyListeners();
  }

  initDataUser() async {
    // await  FirebaseFirestore.instance
    //     .collection('Users').doc(phone).get().then((value){
    //   accountInfo=AccountRegistrationInfo.fromJson(value.data());
    //   notifyListeners();
    // });
  }
}

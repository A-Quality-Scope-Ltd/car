import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../model/color_app.dart';
import '../model/database/firebase_helper.dart';
import '../model/provider_app.dart';
import '../model/size_app.dart';
import '../screens/seller/add_new_product.dart';
import '../screens/seller/edit_register_seller.dart';
import '../widget/text.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';

class AppBarSeller extends StatelessWidget {
  const AppBarSeller({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ProviderApp dataProvide = Provider.of<ProviderApp>(context);
    int index = dataProvide.sellInfo.available ? 1 : 0;

    return Container(
      width: SizeApp.width,
      height: SizeApp.height * 0.07,
      padding: EdgeInsets.only(
          right: SizeApp.width * 0.06, left: SizeApp.width * 0.06),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddNewProduct()),
              );
            },
            child: SvgPicture.asset(
              'assets/icons/ icon _add square_.svg',
              width: SizeApp.iconSize,
              height: SizeApp.iconSize,
            ),
          ),
          Column(
            children: [
              TextApp(
                  text: 'حالة البائع',
                  size: SizeApp.textSize * 0.9,
                  fontWeight: FontWeight.normal,
                  textAlign: TextAlign.center,
                  color: bigTextColor),
              ToggleSwitch(
                minWidth: 100,
                minHeight: 35,
                cornerRadius: 40,
                activeBgColors: [
                  [primaryColor],
                  [primaryColor],
                ],
                activeFgColor: whiteColor,
                inactiveFgColor: whiteColor,
                fontSize: SizeApp.textSize * 1.1,
                initialLabelIndex: index,
                totalSwitches: 2,
                labels: [
                  'غير متاح',
                  'متاح',
                ],
                radiusStyle: true,
                onToggle: (index) {
                  if (index == 0) {
                    dataProvide.sellInfo.available = false;
                  } else {
                    dataProvide.sellInfo.available = true;
                  }
                  FirebaseAppHelper().updateSellerData(
                      phone: dataProvide.phone,
                      updateData: {
                        'available': dataProvide.sellInfo.available
                      });
                },
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const EditRegisterSeller()),
              );
            },
            child: SvgPicture.asset(
              'assets/icons/user.svg',
              width: SizeApp.iconSize,
              height: SizeApp.iconSize,
            ),
          ),
        ],
      ),
    );
  }
}

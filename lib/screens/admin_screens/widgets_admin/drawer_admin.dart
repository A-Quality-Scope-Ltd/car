// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../model/color_app.dart';
import '../../../model/data_information/recovery_info.dart';
import '../../../model/database/firebase_helper.dart';
import '../../../model/size_app.dart';
import '../../../widget/button.dart';
import '../../../widget/custom_snack_bar.dart';
import '../../../widget/full_screen_image.dart';
import '../../../widget/get_image.dart';
import '../../../widget/show_dialog_app.dart';
import '../../../widget/text.dart';
import '../../home_tap_bar_navigation.dart';
import '../dash_board.dart';
import '../products_tab_bar.dart';
import '../request_page_admin.dart';
import '../retrieval_tab_bar.dart';
import '../sellers_tab_bar.dart';
import '../stock_page.dart';
import 'lauch_whatsapp.dart';

import '../order_page_admin.dart';

class DrawerAdmin extends StatelessWidget {
  String screens;
  DrawerAdmin({super.key, required this.screens});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        width: SizeApp.width * 0.55,
        backgroundColor: whiteColor,
        child: Column(children: [
          Padding(
            padding: EdgeInsets.all(SizeApp.padding),
            child: Row(
              children: [
                Icon(Icons.menu, size: SizeApp.iconSize),
                SizedBox(
                  width: SizeApp.width * 0.05,
                ),
                TextApp(
                    text: 'لوحة التحكم',
                    size: SizeApp.textSize * 1.5,
                    fontWeight: FontWeight.normal,
                    color: bigTextColor),
              ],
            ),
          ),
          itemDrawer(
              title: 'الرئيسية',
              widget: SvgPicture.asset(
                'assets/icons/home 2.svg',
                width: SizeApp.iconSize * 1.1,
              ),
              onTap: () {
                if (screens == 'الرئيسية') {
                  Navigator.pop(context);
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const DashBord()),
                  );
                }
              }),
          itemDrawer(
              title: 'البائعين',
              widget: SvgPicture.asset(
                'assets/icons/icon _profile 2user_.svg',
                width: SizeApp.iconSize * 0.9,
              ),
              onTap: () {
                if (screens == 'البائعين') {
                  Navigator.pop(context);
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SellersTabBar()),
                  );
                }
              }),
          itemDrawer(
              title: 'المنتجات',
              widget: Icon(Icons.shopping_cart_rounded, size: SizeApp.iconSize),
              onTap: () {
                if (screens == 'المنتجات') {
                  Navigator.pop(context);
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProductsTabBar()),
                  );
                }
              }),
          itemDrawer(
              title: 'الطلبات',
              widget: SvgPicture.asset(
                'assets/icons/shopping bag.svg',
                width: SizeApp.iconSize * 0.9,
              ),
              onTap: () {
                if (screens == 'الطلبات') {
                  Navigator.pop(context);
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const OrderPageAdmin()),
                  );
                }
              }),
          itemDrawer(
              title: 'الاسترجاع',
              widget: SvgPicture.asset(
                'assets/icons/icon _recovery convert_.svg',
                width: SizeApp.iconSize * 0.9,
              ),
              onTap: () {
                if (screens == 'الاسترجاع') {
                  Navigator.pop(context);
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RetrievalTabBar()),
                  );
                }
              }),
          itemDrawer(
              title: 'الطلبيات',
              widget: Icon(Icons.shop_two, size: SizeApp.iconSize),
              onTap: () {
                if (screens == 'الطلبيات') {
                  Navigator.pop(context);
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RequestPageAdmin()),
                  );
                }
              }),
          itemDrawer(
              title: 'المستحقات',
              widget: Icon(Icons.monetization_on, size: SizeApp.iconSize),
              onTap: () {
                if (screens == 'المستحقات') {
                  Navigator.pop(context);
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const StockPage()),
                  );
                }
              }),
          itemDrawer(
              title: 'تسجيل خروج',
              widget: SvgPicture.asset(
                'assets/icons/login.svg',
                width: SizeApp.iconSize * 0.9,
              ),
              onTap: () {
                showDialogApp(
                  context,
                  title: 'هل انت متأكد من تسجيل الخروج',
                  done: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomeTapBarNavigation()),
                    );
                  },
                  cancel: () {
                    Navigator.pop(context);
                  },
                );
              }),
        ]),
      ),
    );
  }

  Widget itemDrawer({String? title, Widget? widget, void Function()? onTap}) {
    return Padding(
      padding: EdgeInsets.all(SizeApp.padding),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            widget!,
            SizedBox(
              width: SizeApp.width * 0.03,
            ),
            TextApp(
                text: title!,
                size: SizeApp.textSize * 1.4,
                fontWeight: FontWeight.normal,
                color: bigTextColor),
          ],
        ),
      ),
    );
  }
}

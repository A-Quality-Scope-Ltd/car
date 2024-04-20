// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../model/color_app.dart';
import '../model/size_app.dart';
import '../screens/home.dart';
import '../screens/recovery.dart';
import '../screens/requests_and_order.dart';
import '../widget/text.dart';

class HomeTapBarNavigation extends StatefulWidget {
  const HomeTapBarNavigation({super.key});

  @override
  State<HomeTapBarNavigation> createState() => _HomeTapBarNavigationState();
}

class _HomeTapBarNavigationState extends State<HomeTapBarNavigation> {
  int _currentIndex = 2;
  final List<Widget> _listOfPages = [
    const Recovery(),
    const RequestsAndOrder(),
    Home(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PopScope(
        canPop: false,
        child: _listOfPages[_currentIndex],
      ),
      bottomNavigationBar: CustomBottomNavigation(
        currentIndex: _currentIndex,
        onTabTapped: _onTabTapped,
      ),
    );
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}

class CustomBottomNavigation extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTabTapped;
  final List<String> _listOfIcons = [
    'assets/icons/icon _recovery convert_.svg',
    'assets/icons/icon _messages_.svg',
    'assets/icons/icon _home_.svg',
  ];
  final List<String> _listOfText = [
    'عروضي',
    'اضافة',
    'الرئيسة',
  ];

  CustomBottomNavigation(
      {super.key, required this.currentIndex, required this.onTabTapped});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
          0, Platform.isIOS ? SizeApp.height * 0.01 : 0, 0, 0),
      height: Platform.isIOS ? SizeApp.height * 0.115 : SizeApp.height * 0.09,
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(SizeApp.cardRadius),
            topRight: Radius.circular(SizeApp.cardRadius)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 10,
            offset: const Offset(
              0,
              -0.5,
            ),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment:
            Platform.isIOS ? MainAxisAlignment.start : MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _buildNavItem(0),
              _buildNavItem(1),
              _buildNavItem(2),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(
    int index,
  ) {
    return GestureDetector(
      onTap: () => onTabTapped(index),
      child: AnimatedContainer(
        width: SizeApp.width * 0.2,
        duration: const Duration(milliseconds: 1500),
        curve: Curves.fastLinearToSlowEaseIn,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(SizeApp.dilogRadius),
          color: currentIndex == index ? primaryColor : whiteColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              _listOfIcons[index],
              width: SizeApp.iconSize * 1.1,
              color: currentIndex == index ? whiteColor : bigTextColor,
            ),
            TextApp(
                text: _listOfText[index],
                size: SizeApp.textSize * 1.2,
                fontWeight: FontWeight.normal,
                color: currentIndex == index ? whiteColor : bigTextColor),
          ],
        ),
      ),
    );
  }
}

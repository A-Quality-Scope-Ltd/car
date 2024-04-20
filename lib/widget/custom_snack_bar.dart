

import 'package:flutter/material.dart';

customSnackBar({required BuildContext context,required String text,}){
  return   ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Center(child: Text(text,)),
    clipBehavior: Clip.antiAliasWithSaveLayer,
    backgroundColor:Colors.grey,
    behavior: SnackBarBehavior.floating,
  ));
}
//1000205870
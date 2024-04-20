import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import '../model/color_app.dart';
import '../model/size_app.dart';
import '../widget/text.dart';

Widget getImage(
    {String? phone,
    String? propertyName,
    BoxFit fit = BoxFit.contain,
    double? width}) {
  return FutureBuilder(
      future: FirebaseStorage.instance
          .ref()
          .child('Sellers/$phone/$propertyName')
          .getDownloadURL(),
      builder: (c, snap) {
        if (snap.hasData) {
          return ClipRRect(
            child: Image.network(
              snap.data.toString(),
              width: width,
              height: width,
              fit: fit,
            ),
          );
        }
        return TextApp(
            text: '',
            size: SizeApp.textSize * 0.9,
            fontWeight: FontWeight.bold,
            textAlign: TextAlign.center,
            color: smolleTextColor);
      });
}

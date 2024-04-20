import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import '../model/color_app.dart';
import 'package:photo_view/photo_view.dart';

// ignore: must_be_immutable
class FullScreenImage extends StatelessWidget {
  String id;
  String url;
  FullScreenImage({
    super.key,
    required this.id,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.black,
            iconTheme: IconThemeData(color: whiteColor)),
        body: FutureBuilder(
            future: FirebaseStorage.instance
                .ref()
                .child('Sellers/$id/$url')
                .getDownloadURL(),
            builder: (c, snap) {
              if (snap.hasData) {
                return PhotoView(
                  imageProvider: NetworkImage(snap.data.toString()),
                );
              }
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: smolleTextColor,
                  color: primaryColor,
                ),
              );
            }),
      ),
    );
  }
}

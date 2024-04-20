import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../model/color_app.dart';
import '../model/data_information/product_info.dart';
import '../model/size_app.dart';
import '../screens/product.dart';
import '../widget/product_item.dart';
import '../widget/text.dart';
import '../widget/text_field.dart';

// ignore: must_be_immutable
class SearchProductPage extends StatefulWidget {
  String textSearch = '';
  SearchProductPage({super.key, this.textSearch = ''});

  @override
  State<SearchProductPage> createState() => _SearchProductPageState();
}

class _SearchProductPageState extends State<SearchProductPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController controller =
        TextEditingController(text: widget.textSearch);

    return Scaffold(
      backgroundColor: whiteColor,
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(
                  SizeApp.padding, SizeApp.height * 0.07, SizeApp.padding, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back_ios,
                        size: SizeApp.iconSize,
                      )),
                  TextFieldApp(
                    controller: controller,
                    width: SizeApp.width * 0.78,
                    hintText: 'بحث',
                    style: TextStyle(fontSize: SizeApp.textSize * 1.2),
                    keyboardType: TextInputType.text,
                    textAlign: TextAlign.start,
                    prefixIcon: Icon(
                      Icons.search,
                      color: bordarColor,
                      size: SizeApp.iconSize,
                    ),
                    onEditingComplete: () {
                      setState(() {
                        widget.textSearch = controller.text;
                      });
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: SizeApp.height * 0.015),
            Expanded(
                child: SingleChildScrollView(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('Products')
                    .where('agree', isEqualTo: true)
                    .orderBy('propertyName')
                    .startAt([controller.text]).endAt(
                        ['${controller.text}\uf8ff']).snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Align(
                      alignment: snapshot.data!.docs.length == 1
                          ? Alignment.topRight
                          : Alignment.topCenter,
                      child: SingleChildScrollView(
                        child: Wrap(children: [
                          ...List.generate(snapshot.data!.docs.length, (index) {
                            ProductInfo searchResults = ProductInfo.fromJson(
                                snapshot.data!.docs[index].data());
                            return Container(
                              margin: const EdgeInsets.all(5),
                              padding: EdgeInsets.only(
                                  right: snapshot.data!.docs.length == 1
                                      ? SizeApp.width * 0.03
                                      : 0),
                              child: ProductItem(
                                data: searchResults,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Product(
                                              resultsProduct: searchResults,
                                            )),
                                  );
                                },
                              ),
                            );
                          }),
                          SizedBox(height: SizeApp.height * 0.4),
                        ]),
                      ),
                    );
                  } else {
                    return TextApp(
                        text: 'لاتوجد منتجات',
                        size: SizeApp.textSize * 1.5,
                        fontWeight: FontWeight.normal,
                        textAlign: TextAlign.center,
                        color: bigTextColor);
                  }
                },
              ),
            ))
          ],
        ),
      ),
    );
  }
}

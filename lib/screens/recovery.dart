import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../model/color_app.dart';
import '../model/data_information/order_info.dart';
import '../model/provider_app.dart';
import '../model/size_app.dart';
import '../widget/recovery_item.dart';
import '../widget/text.dart';
import 'package:provider/provider.dart';

class Recovery extends StatelessWidget {
  const Recovery({super.key});

  @override
  Widget build(BuildContext context) {
    ProviderApp dataProvide = Provider.of<ProviderApp>(context);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          backgroundColor: whiteColor,
          body: Padding(
            padding: EdgeInsets.fromLTRB(
                SizeApp.padding, SizeApp.height * 0.08, SizeApp.padding, 0),
            child: Column(
              children: [
                TextApp(
                    text: 'إسترجاع',
                    size: SizeApp.textSize * 2,
                    fontWeight: FontWeight.normal,
                    textAlign: TextAlign.center,
                    color: bigTextColor),
                SizedBox(height: SizeApp.height * 0.03),
                Expanded(
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('Orders')
                          .where('phoneClient', isEqualTo: dataProvide.phone)
                          .where('sendOrder', isEqualTo: true)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Container(
                              alignment: Alignment.topCenter,
                              margin: const EdgeInsets.only(top: 20),
                              child: Center(
                                child: CircularProgressIndicator(
                                  backgroundColor: smolleTextColor,
                                  color: primaryColor,
                                ),
                              ));
                        } else if (snapshot.data!.docs.isNotEmpty) {
                          return GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount:
                                  2, // Set the number of items per row
                              crossAxisSpacing: 8.0,
                              mainAxisSpacing: 8.0,
                            ),
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              OrderInfo results = OrderInfo.fromJson(
                                  snapshot.data!.docs[index].data());

                              results.id = snapshot.data!.docs[index].id;
                              return RecoveryItem(results: results);
                            },
                          );
                        } else {
                          return Center(
                            child: TextApp(
                                text: 'لايوجد طلبات إسترجاع',
                                size: SizeApp.textSize * 1.5,
                                fontWeight: FontWeight.normal,
                                textAlign: TextAlign.center,
                                color: bigTextColor),
                          );
                        }
                      }),
                ),
              ],
            ),
          )),
    );
  }
}

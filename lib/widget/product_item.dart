import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../model/color_app.dart';
import '../model/data_information/product_info.dart';
import '../model/database/firebase_helper.dart';
import '../model/provider_app.dart';
import '../model/size_app.dart';
import '../widget/get_image.dart';
import '../widget/text.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ProductItem extends StatefulWidget {
  ProductInfo? data;
  String pageTitle;
  void Function()? onTap;
  void Function()? onTapEditIcon;
  bool isTrue = false;

  ProductItem({
    super.key,
    this.data,
    this.pageTitle = 'home',
    this.onTap,
    this.onTapEditIcon,
  });

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  bool favorite = false;
  @override
  Widget build(BuildContext context) {
    ProviderApp dataProvide = Provider.of<ProviderApp>(context);
    if (dataProvide.phone != '' && !dataProvide.userType) {
      if (dataProvide.accountInfo.favorites != null) {
        for (int i = 0; i < dataProvide.accountInfo.favorites!.length; i++) {
          if (dataProvide.accountInfo.favorites![i] == widget.data!.id) {
            favorite = true;
          }
        }
      }
    }
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          margin: EdgeInsets.only(top: SizeApp.height * 0.015),
          height: SizeApp.height * 0.31,
          width: SizeApp.width * 0.45,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(SizeApp.dilogRadius),
            border:
                Border.all(color: bordarColor, width: SizeApp.width * 0.002),
            color: whiteColor,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: getImage(
                  phone: widget.data!.phone,
                  propertyName: widget.data!.propertyName,
                  width: SizeApp.width * 0.29,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: SizeApp.width * 0.03),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextApp(
                        text: widget.data!.propertyName!,
                        size: SizeApp.textSize * 1.3,
                        fontWeight: FontWeight.normal,
                        color: bigTextColor),
                    TextApp(
                        text: 'الكمية المتوفرة: ${widget.data!.amountProduct}',
                        size: SizeApp.textSize * 0.9,
                        fontWeight: FontWeight.normal,
                        color: smolleTextColor),
                    TextApp(
                        text: '${widget.data!.productPrice} ر.س.',
                        size: SizeApp.textSize * 1.2,
                        fontWeight: FontWeight.normal,
                        color: bigTextColor),
                    if (widget.pageTitle == 'Seller' &&
                        widget.isTrue == true) ...{
                      TextApp(
                          text: 'لم يتم قبول المنتج بعد',
                          size: SizeApp.textSize * 1.2,
                          fontWeight: FontWeight.normal,
                          color: bigTextColor),
                    },
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        widget.data!.rival == ''
                            ? SizedBox(
                                width: SizeApp.width * 0.1,
                              )
                            : TextApp(
                                text: widget.data!.rival!,
                                size: SizeApp.textSize * 1,
                                fontWeight: FontWeight.normal,
                                color: Colors.green),
                        widget.pageTitle == 'Seller'
                            ? GestureDetector(
                                onTap: widget.onTapEditIcon,
                                child: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: SvgPicture.asset(
                                    'assets/icons/icon _edit_.svg',
                                    width: SizeApp.iconSize * 0.8,
                                    height: SizeApp.iconSize * 0.8,
                                  ),
                                ),
                              )
                            : IconButton(
                                onPressed: () {
                                  bool addToList = true;
                                  if (dataProvide.phone != '' &&
                                      !dataProvide.userType) {
                                    favorite = !favorite;
                                    if (favorite) {
                                      for (var i = 0;
                                          i <
                                              dataProvide.accountInfo.favorites!
                                                  .length;
                                          i++) {
                                        if (dataProvide
                                                .accountInfo.favorites![i] ==
                                            widget.data!.id) {
                                          addToList = false;
                                        }
                                      }
                                      if (addToList) {
                                        dataProvide.accountInfo.favorites!
                                            .add(widget.data!.id);
                                        FirebaseAppHelper().updateUsers(
                                            phone: dataProvide.phone,
                                            setUpdate: dataProvide.accountInfo
                                                .toMap());
                                      }
                                      ProviderApp().initDataUser();
                                      setState(() {});
                                    } else {
                                      dataProvide.accountInfo.favorites!
                                          .remove(widget.data!.id);
                                      FirebaseAppHelper().updateUsers(
                                          phone: dataProvide.phone,
                                          setUpdate:
                                              dataProvide.accountInfo.toMap());
                                      ProviderApp().initDataUser();
                                      setState(() {});
                                    }
                                  }
                                },
                                icon: Icon(
                                  favorite
                                      ? Icons.favorite_outlined
                                      : Icons.favorite_border,
                                  size: SizeApp.iconSize,
                                  color: favorite ? redColor : bordarColor,
                                ))
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

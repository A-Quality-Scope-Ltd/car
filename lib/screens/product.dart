import 'dart:io';
import '../model/data_information/seller_registration_info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import '../model/color_app.dart';
import '../model/data_information/comment_info.dart';
import '../model/data_information/product_info.dart';
import '../model/database/firebase_helper.dart';
import '../model/provider_app.dart';
import '../model/size_app.dart';
import '../widget/button.dart';
import '../widget/count_controller.dart';
import '../widget/custom_snack_bar.dart';
import '../widget/get_image.dart';
import '../widget/text.dart';
import 'package:provider/provider.dart';
import 'package:rating_dialog/rating_dialog.dart';

// ignore: must_be_immutable
class Product extends StatefulWidget {
  ProductInfo? resultsProduct;

  Product({
    super.key,
    this.resultsProduct,
  });

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  int? countControllerValue;
  int isSelectTaybe = 0;
  bool isTrue = false;
  bool favorite = false;
  SellerRegistrationInfo seller = SellerRegistrationInfo();
  // void _shareProduct() async {
  //   String url = await FirebaseStorage.instance
  //       .ref()
  //       .child(
  //           'Sellers/${widget.resultsProduct!.phone}/${widget.resultsProduct!.propertyName}')
  //       .getDownloadURL();
  //   final response = await http.get(Uri.parse(url));
  //   final b = response.bodyBytes;
  //   final temp = await getTemporaryDirectory();
  //   final path = '${temp.path}/image.jpg';
  //   File(path).writeAsBytesSync(b);

  //   String message =
  //       '${widget.resultsProduct!.propertyName}\n${widget.resultsProduct!.descriptionProperty}';

  //   await Share.shareFiles([path], text: message);
  // }
  @override
  Widget build(BuildContext context) {
    ProviderApp dataProvide = Provider.of<ProviderApp>(context);

    if (dataProvide.phone != '' && !dataProvide.userType) {
      for (int i = 0; i < dataProvide.accountInfo.favorites!.length; i++) {
        if (dataProvide.accountInfo.favorites![i] ==
            widget.resultsProduct!.id) {
          favorite = true;
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColorProduct,
        automaticallyImplyLeading: false,
        surfaceTintColor: whiteColorProduct,
        title: Directionality(
          textDirection: TextDirection.rtl,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    size: SizeApp.iconSize,
                  )),
            ],
          ),
        ),
      ),
      backgroundColor: whiteColor,
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          children: [
            Expanded(
              child: _imageProduct(),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                    SizeApp.padding, SizeApp.height * 0.02, SizeApp.padding, 0),
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('Products')
                      .doc(widget.resultsProduct!.id)
                      .snapshots(),
                  builder: (context, snapshot) {
                    FirebaseFirestore.instance
                        .collection('Sellers')
                        .doc(widget.resultsProduct!.phone)
                        .get()
                        .then((value) {
                      seller = SellerRegistrationInfo.fromJson(value.data());
                      widget.resultsProduct!.location = seller.location;
                      widget.resultsProduct!.latSeller = seller.latSeller;
                      widget.resultsProduct!.longSeller = seller.longSeller;

                      setState(() {});
                    });
                    if (snapshot.connectionState == ConnectionState.none) {
                      widget.resultsProduct =
                          ProductInfo.fromJson(snapshot.data);
                    }

                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _nameAndLocation(),
                          TextApp(
                              text:
                                  '${widget.resultsProduct!.productPrice} ر.س.',
                              size: SizeApp.textSize * 1.2,
                              fontWeight: FontWeight.normal,
                              color: bigTextColor),
                          SizedBox(height: SizeApp.height * 0.02),
                          _quantityAvailableAndCountController(),
                          TextApp(
                            text:
                                'قابل للإسترجاع : ${widget.resultsProduct!.retrievability ? 'نعم' : 'لا'}',
                            size: SizeApp.textSize * 1.2,
                            fontWeight: FontWeight.normal,
                            color: bigTextColor,
                          ),
                          _type(),
                          SizedBox(height: SizeApp.height * 0.02),
                          Divider(color: bordarColor.withOpacity(0.3)),
                          TextApp(
                              text: 'تفاصيل المنتج',
                              size: SizeApp.textSize * 1.5,
                              fontWeight: FontWeight.normal,
                              color: bigTextColor),
                          _productDetails(),
                          SizedBox(height: SizeApp.height * 0.02),
                          Divider(color: bordarColor.withOpacity(0.3)),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextApp(
                                    text: 'تعليق المشتري',
                                    size: SizeApp.textSize * 1.5,
                                    fontWeight: FontWeight.normal,
                                    color: bigTextColor),
                                _commentButton(),
                              ]),
                          SizedBox(height: SizeApp.height * 0.02),
                          if (widget.resultsProduct!.comments!.isNotEmpty) ...{
                            Column(
                              verticalDirection: VerticalDirection.up,
                              children: List.generate(
                                  widget.resultsProduct!.comments!.length,
                                  (index) {
                                CommentInfo comment = CommentInfo.fromJson(
                                    widget.resultsProduct!.comments![index]);

                                return _commentAndRating(
                                    comment: comment.comment!,
                                    rating: comment.rating);
                              }),
                            )
                          } else ...{
                            Center(
                                child: TextApp(
                                    text: 'لاتوجد تعليقات',
                                    size: SizeApp.textSize * 1.5,
                                    fontWeight: FontWeight.normal,
                                    textAlign: TextAlign.center,
                                    color: bigTextColor)),
                          },
                          SizedBox(height: SizeApp.height * 0.06),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _toButton(),
    );
  }

  Widget _imageProduct() {
    ProviderApp dataProvide = Provider.of<ProviderApp>(context);

    return Container(
      padding: EdgeInsets.fromLTRB(SizeApp.padding, 0, SizeApp.padding, 0),
      height: SizeApp.height * 2,
      decoration: BoxDecoration(
        color: whiteColorProduct,
        borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(SizeApp.dilogRadius),
            bottomLeft: Radius.circular(SizeApp.dilogRadius)),
      ),
      child: Column(children: [
        Expanded(
          child: getImage(
            phone: widget.resultsProduct!.phone,
            propertyName: widget.resultsProduct!.propertyName,
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            IconButton(
                onPressed: () {
                  if (dataProvide.phone != '' && !dataProvide.userType) {
                    favorite = !favorite;
                    if (favorite) {
                      dataProvide.accountInfo.favorites!
                          .add(widget.resultsProduct!.id);
                      FirebaseAppHelper().updateUsers(
                          phone: dataProvide.phone,
                          setUpdate: dataProvide.accountInfo.toMap());
                      setState(() {});
                    } else {
                      dataProvide.accountInfo.favorites!
                          .remove(widget.resultsProduct!.id);
                      FirebaseAppHelper().updateUsers(
                          phone: dataProvide.phone,
                          setUpdate: dataProvide.accountInfo.toMap());
                      setState(() {});
                    }
                  } else {
                    customSnackBar(context: context, text: 'قم تسجيل الدخول');
                  }
                },
                icon: Icon(
                  favorite ? Icons.favorite_outlined : Icons.favorite_border,
                  size: SizeApp.iconSize,
                  color: favorite ? redColor : null,
                ))
          ],
        )
      ]),
    );
  }

  Widget _nameAndLocation() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            children: [
              TextApp(
                  text: widget.resultsProduct!.propertyName!,
                  size: SizeApp.textSize * 1.3,
                  fontWeight: FontWeight.normal,
                  textAlign: TextAlign.center,
                  color: bigTextColor),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              SvgPicture.asset(
                'assets/icons/ icon _location_.svg',
                width: SizeApp.iconSize * 0.9,
              ),
              TextApp(
                  text: widget.resultsProduct!.location!,
                  size: SizeApp.textSize * 0.9,
                  fontWeight: FontWeight.normal,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  color: bigTextColor),
            ],
          ),
        ),
      ],
    );
  }

  Widget _quantityAvailableAndCountController() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextApp(
            text: 'الكمية المتوفرة : ${widget.resultsProduct!.amountProduct}',
            size: SizeApp.textSize * 1.2,
            fontWeight: FontWeight.normal,
            color: bigTextColor),
        CountController(
          removeNumber: (enabled) => Icon(
            Icons.remove_rounded,
            color: redColor,
            size: SizeApp.width * 0.1,
          ),
          countBuilder: (count) => TextApp(
              text: count.toString(),
              size: SizeApp.textSize * 1.2,
              fontWeight: FontWeight.normal,
              color: bigTextColor),
          addNumber: (enabled) => Icon(
            Icons.add_rounded,
            color: primaryColor,
            size: SizeApp.width * 0.1,
          ),
          count: countControllerValue ??= 1,
          updateCount: (count) => setState(() => countControllerValue = count),
          stepSize: 1,
          minimum: 1,
          maximum: int.parse(widget.resultsProduct!.amountProduct!),
        ),
      ],
    );
  }

  Widget _type() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextApp(
            text: widget.resultsProduct!.titleType!,
            size: SizeApp.textSize * 1.5,
            fontWeight: FontWeight.normal,
            color: bigTextColor),
        SizedBox(height: SizeApp.height * 0.02),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: List.generate(
              widget.resultsProduct!.typeProduct!.length,
              (index) => _showTypes(
                  text: widget.resultsProduct!.typeProduct![index],
                  index: index)),
        ),
      ],
    );
  }

  Widget _showTypes({
    required text,
    required int index,
  }) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelectTaybe = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(13),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(SizeApp.dilogRadius),
          border: Border.all(
              color: isSelectTaybe == index ? primaryColor : bordarColor,
              width: SizeApp.width * 0.002),
          color: isSelectTaybe == index ? primaryColor : whiteColor,
        ),
        child: TextApp(
            text: text,
            size: SizeApp.textSize * 1,
            fontWeight: FontWeight.normal,
            textAlign: TextAlign.center,
            color: bigTextColor),
      ),
    );
  }

  Widget _productDetails() {
    return TextApp(
        text: widget.resultsProduct!.descriptionProperty!,
        size: SizeApp.textSize * 1,
        fontWeight: FontWeight.normal,
        color: smolleTextColor);
  }

  Widget _commentAndRating({required double rating, required String comment}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RatingBar.builder(
              initialRating: rating,
              itemCount: 5,
              ignoreGestures: true,
              itemPadding: const EdgeInsets.symmetric(horizontal: 0),
              itemSize: SizeApp.iconSize * 0.8,
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {},
            ),
          ],
        ),
        SizedBox(height: SizeApp.height * 0.01),
        TextApp(
            text: comment,
            size: SizeApp.textSize * 1,
            fontWeight: FontWeight.normal,
            color: smolleTextColor),
        Divider(
          color: bordarColor.withOpacity(0.3),
        ),
      ],
    );
  }

  Widget _toButton() {
    ProviderApp dataProvide = Provider.of<ProviderApp>(context);

    return Container(
      padding: EdgeInsets.fromLTRB(SizeApp.padding, 0, SizeApp.padding, 0),
      margin: EdgeInsets.only(
          bottom:
              Platform.isIOS ? SizeApp.height * 0.05 : SizeApp.height * 0.02),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: ButtonApp(
              buttonText: seller.available ? 'شراء' : 'البائع غير ماتح',
              width: SizeApp.width,
              height: SizeApp.height * 0.04,
              color: seller.available &&
                      widget.resultsProduct!.amountProduct != '0'
                  ? redColor
                  : bordarColor,
              fontSize: SizeApp.textSize * 1.3,
              radius: SizeApp.buttonRadius,
              fontWeight: FontWeight.bold,
              onPressed: seller.available &&
                      widget.resultsProduct!.amountProduct != '0'
                  ? () {
                      if (dataProvide.phone != '' && !dataProvide.userType) {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) => PaymentProcessOrder(
                        //             productInfo: widget.resultsProduct,
                        //             amountProduct:
                        //                 countControllerValue.toString(),
                        //           )),
                        // );
                      } else {
                        customSnackBar(
                            context: context, text: 'قم تسجيل الدخول');
                      }
                    }
                  : null,
            ),
          ),
          SizedBox(width: SizeApp.width * 0.01),
          Expanded(
            child: ButtonApp(
              buttonText: 'طلبية',
              width: SizeApp.width,
              height: SizeApp.height * 0.04,
              color: redColor,
              fontSize: SizeApp.textSize * 1.3,
              radius: SizeApp.buttonRadius,
              fontWeight: FontWeight.bold,
              onPressed: () {
                if (dataProvide.phone != '' && !dataProvide.userType) {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) => PaymentProcessRequest(
                  //             productInfo: widget.resultsProduct,
                  //           )),
                  // );
                } else {
                  customSnackBar(context: context, text: 'قم تسجيل الدخول');
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _commentButton() {
    return ButtonApp(
      buttonText: 'اضف تعليق',
      width: SizeApp.width * 0.25,
      height: SizeApp.height * 0.04,
      color: primaryColor,
      fontSize: SizeApp.textSize * 1,
      radius: SizeApp.buttonRadius,
      fontWeight: FontWeight.w600,
      onPressed: () {
        showDialogCommentAndRating(
          context,
        );
      },
    );
  }

  showDialogCommentAndRating(
    BuildContext context,
  ) {
    return showDialog(
        context: context,
        builder: (context) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: RatingDialog(
              initialRating: 0,
              starColor: primaryColor,
              title: const Text(''),
              submitButtonText: 'تعليق',
              commentHint: 'اكتب تعليقك',
              onSubmitted: (value) {
                CommentInfo commentInfo = CommentInfo(
                  rating: value.rating,
                  comment: value.comment,
                );
                widget.resultsProduct!.comments!.add(commentInfo.toMap());
                FirebaseAppHelper().updateProductData(
                    id: widget.resultsProduct!.id!,
                    updateData: widget.resultsProduct!.toMap());
                setState(() {});
              },
            ),
          );
        });
  }
}

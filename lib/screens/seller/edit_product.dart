import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../model/color_app.dart';
import '../../model/data_information/product_info.dart';
import '../../model/database/firebase_helper.dart';
import '../../model/size_app.dart';
import '../../widget/app_bar_with_button_back.dart';
import '../../widget/button.dart';
import '../../widget/dropdown_button_app.dart';
import '../../widget/text.dart';
import '../../widget/text_field.dart';

import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
class EditProduct extends StatefulWidget {
  ProductInfo productInfo = ProductInfo();

  EditProduct({super.key, required this.productInfo});

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  List<String> listType = [];
  final _formKey = GlobalKey<FormState>();
  XFile? pictureHere;
  final ImagePicker picker = ImagePicker();
  Future getImageForGallery(ImageSource source) async {
    XFile? image = await picker.pickImage(source: source);

    setState(() {
      pictureHere = image;
    });
  }

  String selectedValue = 'الحرف اليدوية';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                SizeApp.padding, SizeApp.height * 0.07, SizeApp.padding, 0),
            child: Column(
              children: [
                const AppBarWithButtonBack(),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        addImage(),
                        SizedBox(height: SizeApp.height * 0.03),
                        textField(
                            text: 'تعديل اسم المنتج',
                            hintText: widget.productInfo.propertyName,
                            keyboardType: TextInputType.name,
                            onChanged: (value) {
                              widget.productInfo.propertyName = value;
                            },
                            validator: (value) {
                              if (!RegExp(r'^(.)[^#@$%&*+-=!:)(_?؟]+$')
                                  .hasMatch(value!)) {
                                return 'الحقل فارغ';
                              }
                              return null;
                            }),
                        SizedBox(height: SizeApp.height * 0.03),
                        textField(
                            text: 'تعديل سعر المنتج',
                            hintText: widget.productInfo.productPrice,
                            style: TextStyle(fontSize: SizeApp.textSize * 1.1),
                            onChanged: (value) {
                              widget.productInfo.productPrice = value;
                            },
                            validator: (value) {
                              if (!RegExp(r'^SA\d{2}[0-9A-Z]{20}$')
                                  .hasMatch(value!)) {
                                return 'الحقل فارغ';
                              }
                              return null;
                            }),
                        SizedBox(height: SizeApp.height * 0.03),
                        textField(
                            text: 'تعديل الكمية المتوفرة',
                            hintText: widget.productInfo.amountProduct,
                            style: TextStyle(fontSize: SizeApp.textSize * 1.1),
                            onChanged: (value) {
                              widget.productInfo.amountProduct = value;
                            },
                            validator: (value) {
                              if (!RegExp(r'^(.)[^#@$%&*+-=!:)(_?؟]+$')
                                  .hasMatch(value!)) {
                                return 'الحقل فارغ';
                              }
                              return null;
                            }),
                        SizedBox(height: SizeApp.height * 0.03),
                        textField(
                            text: 'تعديل تفاصيل المنتج',
                            hintText: widget.productInfo.descriptionProperty,
                            style: TextStyle(fontSize: SizeApp.textSize * 1.1),
                            textAlign: TextAlign.start,
                            minLines: 5,
                            maxLines: 5,
                            onChanged: (value) {
                              widget.productInfo.descriptionProperty = value;
                            },
                            validator: (value) {
                              if (!RegExp(r'^(.)[^#@$%&*+-=!:)(_?؟]+$')
                                  .hasMatch(value!)) {
                                return 'الحقل فارغ';
                              }
                              return null;
                            }),
                        SizedBox(height: SizeApp.height * 0.03),
                        ButtonApp(
                            buttonText: 'تعديل المنتج',
                            color: primaryColor,
                            width: SizeApp.width * 0.7,
                            fontSize: SizeApp.textSize * 1.7,
                            radius: SizeApp.buttonRadius,
                            onPressed: () {
                              FirebaseAppHelper().updateProductData(
                                  id: widget.productInfo.id!,
                                  updateData: widget.productInfo.toMap());
                              if (pictureHere != null) {
                                FirebaseAppHelper().deleteImage(
                                    image:
                                        '${widget.productInfo.phone}/${widget.productInfo.propertyName}');
                                FirebaseAppHelper().uploadImage(
                                    phoneProduct: widget.productInfo.phone!,
                                    nameImage: widget.productInfo.propertyName!,
                                    imagePath: File(pictureHere!.path));
                              }
                            }),
                        SizedBox(
                          height: SizeApp.height * 0.03,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Platform.isIOS
          ? SizedBox(
              height: SizeApp.height * 0.03,
            )
          : null,
    );
  }

  Widget textField(
      {required String text,
      String? hintText,
      TextEditingController? controller,
      String? Function(String?)? validator,
      TextInputType? keyboardType,
      TextAlign? textAlign,
      TextStyle? style,
      int? maxLines,
      int? minLines,
      Function(String)? onChanged}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextApp(
            text: text,
            size: SizeApp.textSize * 1.3,
            fontWeight: FontWeight.normal,
            color: bigTextColor),
        SizedBox(
          height: SizeApp.height * 0.01,
        ),
        TextFieldApp(
          width: SizeApp.width * 0.8,
          hintText: hintText,
          style: style ?? TextStyle(fontSize: SizeApp.textSize * 1.3),
          keyboardType: keyboardType,
          maxLines: maxLines,
          minLines: minLines,
          textAlign: textAlign ?? TextAlign.center,
          controller: controller,
          validator: validator,
          onChanged: onChanged,
        ),
      ],
    );
  }

  addImage() {
    return FormField<XFile>(
      validator: (value) {
        value = pictureHere;
        if (value == null) {
          return 'الرجاء رفع صورة وثيقة العمل الحر او السجل التجاري';
        } else {
          return null;
        }
      },
      builder: (fieldAddPictrue) => Column(
        children: [
          SizedBox(
            height: SizeApp.height * 0.01,
          ),
          GestureDetector(
            onTap: () {
              getImageForGallery(ImageSource.gallery);
            },
            child: Container(
              width: SizeApp.width * 0.8,
              height: SizeApp.height * 0.16,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(SizeApp.buttonRadius),
                border: Border.all(
                    color: fieldAddPictrue.hasError
                        ? const Color.fromARGB(255, 176, 27, 16)
                        : bordarColor.withOpacity(0.5),
                    width: SizeApp.width * 0.002),
              ),
              alignment: Alignment.center,
              child: pictureHere == null
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/icon _add image_.svg',
                          width: SizeApp.iconSize * 2,
                        ),
                        TextApp(
                            text: 'تعديل صورة المنتج',
                            size: SizeApp.textSize * 1.1,
                            fontWeight: FontWeight.normal,
                            color: bigTextColor),
                      ],
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(SizeApp.buttonRadius),
                      child: Image.file(
                        //to show image, you type like this.
                        File(pictureHere!.path),
                        fit: BoxFit.cover,
                        width: SizeApp.width,
                      ),
                    ),
            ),
          ),
          if (fieldAddPictrue.hasError)
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 5, SizeApp.width * 0.09, 0),
                  child: TextApp(
                      text: fieldAddPictrue.errorText!,
                      size: SizeApp.textSize * 0.9,
                      fontWeight: FontWeight.normal,
                      color: const Color.fromARGB(255, 176, 27, 16)),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget dropdownButton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextApp(
            text: 'تعديل التصنيف',
            size: SizeApp.textSize * 1.3,
            fontWeight: FontWeight.normal,
            color: bigTextColor),
        SizedBox(height: SizeApp.height * 0.01),
        DropdownButtonApp2(
          onChanged: (value) {
            widget.productInfo.descriptionProperty = value;
          },
        )
      ],
    );
  }
}

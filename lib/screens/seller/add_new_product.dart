import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../model/color_app.dart';
import '../../model/data_information/product_info.dart';
import '../../model/database/firebase_helper.dart';
import '../../model/provider_app.dart';
import '../../model/size_app.dart';
import '../../widget/app_bar_with_button_back.dart';
import '../../widget/button.dart';
import '../../widget/dropdown_button_app.dart';
import '../../widget/show_dialog_app.dart';
import '../../widget/text.dart';
import '../../widget/text_field.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class AddNewProduct extends StatefulWidget {
  const AddNewProduct({super.key});

  @override
  State<AddNewProduct> createState() => _AddNewProductState();
}

class _AddNewProductState extends State<AddNewProduct> {
  final _formKey = GlobalKey<FormState>();
  XFile? pictureHere;
  final ImagePicker picker = ImagePicker();
  ProductInfo productInfo = ProductInfo();
  final TextEditingController _titleType = TextEditingController();
  final TextEditingController _typeProduct1 = TextEditingController();
  final TextEditingController _typeProduct2 = TextEditingController();
  final TextEditingController _typeProduct3 = TextEditingController();
  final TextEditingController _typeProduct4 = TextEditingController();
  final TextEditingController _typeProduct5 = TextEditingController();

  Future getImageForGallery(ImageSource source) async {
    XFile? image = await picker.pickImage(source: source);
    setState(() {
      pictureHere = image;
    });
  }

  String selectedValue = 'الحرف اليدوية';

  @override
  Widget build(BuildContext context) {
    ProviderApp dataProvide = Provider.of<ProviderApp>(context);
    productInfo.phone = dataProvide.phone;
    productInfo.longSeller = dataProvide.sellInfo.longSeller;
    productInfo.latSeller = dataProvide.sellInfo.latSeller;
    productInfo.location = dataProvide.sellInfo.location;

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
                            text: 'اسم المنتج',
                            keyboardType: TextInputType.name,
                            onChanged: (value) {
                              productInfo.propertyName = value;
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
                            text: 'سعر المنتج',
                            style: TextStyle(fontSize: SizeApp.textSize * 1.1),
                            onChanged: (value) {
                              productInfo.productPrice = value;
                            },
                            validator: (value) {
                              if (!RegExp(
                                      r'^\$?(\d{1,3}(,\d{3})*(\.\d{1,2})?|\.\d{1,2})$')
                                  .hasMatch(value!)) {
                                return 'الحقل فارغ';
                              }
                              return null;
                            }),
                        SizedBox(height: SizeApp.height * 0.03),
                        textField(
                            text: 'الكمية المتوفرة',
                            style: TextStyle(fontSize: SizeApp.textSize * 1.1),
                            onChanged: (value) {
                              productInfo.amountProduct = value;
                            },
                            validator: (value) {
                              if (RegExp(r'^\s*$').hasMatch(value!)) {
                                return 'الحقل فارغ';
                              }
                              if (!RegExp(r'^(100|\$?(\d{1,2}(\.\d{1,2})?))$')
                                  .hasMatch(value)) {
                                return 'يجب ان يكون الرقم اقل من 100';
                              }
                              return null;
                            }),
                        SizedBox(height: SizeApp.height * 0.03),
                        dropdownButton(),
                        SizedBox(height: SizeApp.height * 0.03),
                        // textField(
                        //   text: 'ادخل اسم النوع (اختياري)',
                        //   style: TextStyle(fontSize: SizeApp.textSize * 1.1),
                        //   controller: _titleType,
                        //   onChanged: (value) {
                        //     setState(() {
                        //       _titleType.text = value;
                        //     });
                        //   },
                        // ),
                        if (_titleType.text != '') ...{
                          SizedBox(height: SizeApp.height * 0.03),
                          productTypes(),
                        },
                        SizedBox(height: SizeApp.height * 0.03),
                        textField(
                            text: 'تفاصيل المنتج',
                            style: TextStyle(fontSize: SizeApp.textSize * 1.1),
                            textAlign: TextAlign.start,
                            minLines: 5,
                            maxLines: 5,
                            onChanged: (value) {
                              productInfo.descriptionProperty = value;
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
                            buttonText: 'إنشاء منتج',
                            color: primaryColor,
                            width: SizeApp.width * 0.7,
                            fontSize: SizeApp.textSize * 1.7,
                            radius: SizeApp.buttonRadius,
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                // productInfo.titleType = _titleType.text;
                                // productInfo.typeProduct!
                                //     .add(_typeProduct1.text);
                                // productInfo.typeProduct!
                                //     .add(_typeProduct2.text);
                                // productInfo.typeProduct!
                                //     .add(_typeProduct3.text);
                                // productInfo.typeProduct!
                                //     .add(_typeProduct4.text);
                                // productInfo.typeProduct!
                                //     .add(_typeProduct5.text);

                                FirebaseAppHelper().uploadImage(
                                    phoneProduct: productInfo.phone!,
                                    nameImage: productInfo.propertyName!,
                                    imagePath: File(pictureHere!.path));
                                FirebaseAppHelper().setDataProduct(
                                    setData: productInfo.toMap());
                                showDialogWait(context,
                                    title: 'إنتظار موافقة المسؤل',
                                    pageRegister: false);
                                setState(() {});
                              }
                            }),
                        SizedBox(height: SizeApp.height * 0.03),
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
        TextFieldApp(
          width: SizeApp.width * 0.8,
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
                            text: 'رفع صورة المنتج',
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
            text: 'اختيار التصنيف',
            size: SizeApp.textSize * 1.3,
            fontWeight: FontWeight.normal,
            color: bigTextColor),
        SizedBox(height: SizeApp.height * 0.01),
        DropdownButtonApp(
          onChanged: (value) {
            productInfo.productClassification = value;
          },
        )
      ],
    );
  }

  Widget productTypes() {
    return Padding(
      padding:
          EdgeInsets.fromLTRB(SizeApp.padding * 2, 0, SizeApp.padding * 2, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              TextApp(
                  text: 'ادخل نوع المنتج',
                  size: SizeApp.textSize * 1.3,
                  fontWeight: FontWeight.normal,
                  color: bigTextColor),
              TextApp(
                  text: ' (اختياري)',
                  size: SizeApp.textSize * 1.1,
                  fontWeight: FontWeight.normal,
                  color: smolleTextColor),
            ],
          ),
          SizedBox(
            height: SizeApp.height * 0.01,
          ),
          Wrap(
            spacing: 5,
            runSpacing: 5,
            children: [
              buildWidget(controller: _typeProduct1),
              buildWidget(controller: _typeProduct2),
              buildWidget(controller: _typeProduct3),
              buildWidget(controller: _typeProduct4),
              buildWidget(controller: _typeProduct5),
            ],
          )
        ],
      ),
    );
  }

  Widget buildWidget({required TextEditingController controller}) {
    return TextFieldApp(
        width: SizeApp.width * 0.25,
        hintText: 'ادخل نص',
        style: TextStyle(fontSize: SizeApp.textSize * 1),
        hintStyle: TextStyle(
          fontSize: SizeApp.textSize * 1,
        ),
        maxLines: 1,
        keyboardType: TextInputType.name,
        controller: controller,
        onChanged: (value) {
          setState(() {
            controller.text = value;
          });
        });
  }
}

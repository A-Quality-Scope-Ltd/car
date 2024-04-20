import 'package:flutter/material.dart';
import '../../../model/color_app.dart';
import '../../../model/data_information/product_info.dart';
import '../../../model/database/firebase_helper.dart';
import '../../../model/size_app.dart';
import '../../../widget/button.dart';
import '../../../widget/get_image.dart';
import '../../../widget/show_dialog_app.dart';
import '../../../widget/text.dart';
import 'lauch_whatsapp.dart';

// ignore: must_be_immutable
class ProductsItemAdmin extends StatefulWidget {
  ProductInfo data = ProductInfo();
  String? page;

  ProductsItemAdmin({super.key, required this.data, required this.page});

  @override
  State<ProductsItemAdmin> createState() => _ProductsItemAdminState();
}

class _ProductsItemAdminState extends State<ProductsItemAdmin> {
  TextEditingController deliveryCharge = TextEditingController();
  TextEditingController valueAddedTax = TextEditingController();
  TextEditingController productDiscount = TextEditingController();
  TextEditingController _controller = TextEditingController();
  TextEditingController _deletController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: SizeApp.height * 0.015),
      padding: EdgeInsets.only(
          left: SizeApp.width * 0.05,
          right: SizeApp.width * 0.05,
          top: SizeApp.height * 0.015,
          bottom: SizeApp.height * 0.015),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(SizeApp.cardRadius),
        border: Border.all(
            color: bordarColor.withOpacity(0.5), width: SizeApp.width * 0.002),
        color: whiteColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
              child: getImage(
                  phone: widget.data.phone,
                  propertyName: widget.data.propertyName)),
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextApp(
                        text: '${widget.data.propertyName} :',
                        size: SizeApp.textSize * 1.1,
                        fontWeight: FontWeight.bold,
                        textAlign: TextAlign.end,
                        color: bigTextColor),
                    TextApp(
                        text: ' اسم المنتج',
                        size: SizeApp.textSize * 1.1,
                        fontWeight: FontWeight.bold,
                        textAlign: TextAlign.end,
                        color: bigTextColor),
                  ],
                ),
                SizedBox(height: SizeApp.height * 0.007),
                TextApp(
                    text: '.سعر المنتج : ${widget.data.productPrice} ر.س',
                    size: SizeApp.textSize * 1.1,
                    fontWeight: FontWeight.bold,
                    textAlign: TextAlign.end,
                    color: bigTextColor),
                SizedBox(height: SizeApp.height * 0.007),
                TextApp(
                    text: 'الكمية : ${widget.data.amountProduct}',
                    size: SizeApp.textSize * 1.1,
                    fontWeight: FontWeight.normal,
                    textAlign: TextAlign.end,
                    color: smolleTextColor),
                TextApp(
                    text: 'تصنيف المنتج : ${widget.data.productClassification}',
                    size: SizeApp.textSize * 1.1,
                    fontWeight: FontWeight.normal,
                    textAlign: TextAlign.end,
                    color: smolleTextColor),
                SizedBox(height: SizeApp.height * 0.015),
                if (widget.page != 'المنتجات')
                  ButtonApp(
                      buttonText: 'موافقة',
                      color: primaryColor,
                      width: SizeApp.width * 0.35,
                      height: SizeApp.height * 0.035,
                      fontSize: SizeApp.textSize * 1.2,
                      fontWeight: FontWeight.bold,
                      radius: SizeApp.buttonRadius,
                      onPressed: () {
                        showDialogAppLiftTheProduct(
                          context,
                          formKey: _formKey,
                          title: 'رسوم التوصيل',
                          controller: deliveryCharge,
                          title2: 'ضريبة القيمة المضافة',
                          controller2: valueAddedTax,
                          title3: 'تخفيض للمنتج (اختياري)',
                          controller3: productDiscount,
                          onChanged: (String? newValue) {
                            if (newValue == 'نعم') {
                              widget.data.retrievability = true;
                            }
                          },
                          done: () {
                            if (_formKey.currentState!.validate()) {
                              widget.data.deliveryCharge = deliveryCharge.text;
                              widget.data.valueAddedTax = valueAddedTax.text;
                              widget.data.productDiscount =
                                  productDiscount.text;
                              widget.data.agree = true;
                              FirebaseAppHelper().updateProductData(
                                  id: widget.data.id,
                                  updateData: widget.data.toMap());
                              Navigator.pop(context);
                            }
                          },
                        );
                      }),
                SizedBox(height: SizeApp.height * 0.02),
                widget.page == 'المنتجات'
                    ? ButtonApp(
                        buttonText: 'حذف',
                        color: redColor,
                        width: SizeApp.width * 0.35,
                        height: SizeApp.height * 0.035,
                        fontSize: SizeApp.textSize * 1.2,
                        fontWeight: FontWeight.bold,
                        radius: SizeApp.buttonRadius,
                        onPressed: () {
                          showDialogApp(context,
                              title: 'هل انت متأكد من حذف المنتج ؟',
                              cancel: () => Navigator.pop(context),
                              done: () {
                                FirebaseAppHelper()
                                    .deleteProduct(id: widget.data.id);
                                FirebaseAppHelper().deleteImage(
                                    image:
                                        '${widget.data.phone}/${widget.data.propertyName}');

                                Navigator.pop(context);

                                showDialogAppReasonForDeletionReasonOfRefuse(
                                  context,
                                  formKey: _formKey,
                                  title: 'سبب الحذف',
                                  controller: _deletController,
                                  validator: (value) {
                                    if (!RegExp(r'^.').hasMatch(value!)) {
                                      return 'الحقل فارغ';
                                    }
                                    return null;
                                  },
                                  done: () {
                                    if (_formKey.currentState!.validate()) {
                                      launchWhatsApp(
                                        consigneeNumber: widget.data.phone!,
                                        titleMessage: 'سبب الحذف',
                                        textMessage: _deletController.text,
                                      );
                                      Navigator.pop(context);
                                    }
                                  },
                                );
                              });
                        })
                    : ButtonApp(
                        buttonText: 'رفض',
                        color: redColor,
                        width: SizeApp.width * 0.35,
                        height: SizeApp.height * 0.035,
                        fontSize: SizeApp.textSize * 1.2,
                        fontWeight: FontWeight.bold,
                        radius: SizeApp.buttonRadius,
                        onPressed: () {
                          showDialogApp(context,
                              title: 'هل انت متأكد من رفض المنتج ؟',
                              cancel: () => Navigator.pop(context),
                              done: () {
                                FirebaseAppHelper()
                                    .deleteProduct(id: widget.data.id);
                                Navigator.pop(context);
                                showDialogAppReasonForDeletionReasonOfRefuse(
                                  context,
                                  formKey: _formKey,
                                  title: 'سبب الرفض',
                                  controller: _controller,
                                  validator: (value) {
                                    if (!RegExp(r'^.').hasMatch(value!)) {
                                      return 'الحقل فارغ';
                                    }
                                    return null;
                                  },
                                  done: () {
                                    if (_formKey.currentState!.validate()) {
                                      launchWhatsApp(
                                        consigneeNumber: widget.data.phone!,
                                        titleMessage: 'سبب الرفض',
                                        textMessage: _controller.text,
                                      );
                                      Navigator.pop(context);
                                    }
                                  },
                                );
                              });
                        }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../model/color_app.dart';
import '../model/size_app.dart';
import '../screens/home_tap_bar_navigation.dart';
import '../screens/seller/seller.dart';
import '../widget/button.dart';
import '../widget/dropdown_button_app.dart';
import '../widget/text.dart';
import '../widget/text_field.dart';
import 'package:rating_dialog/rating_dialog.dart';

// showDialog is for approval or rejection
showDialogApp(
  BuildContext context, {
  required String title,
  required void Function()? cancel,
  required void Function()? done,
}) {
  return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          elevation: 0,
          backgroundColor: whiteColor,
          shape: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(SizeApp.dilogRadius),
            ),
            borderSide: BorderSide(
              color: bordarColor.withOpacity(0.5),
              width: SizeApp.width * 0.002,
            ),
          ),
          child: SizedBox(
            height: SizeApp.height * 0.3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: SizeApp.height * 0.03,
                ),
                TextApp(
                    text: title,
                    size: SizeApp.textSize * 1.5,
                    fontWeight: FontWeight.normal,
                    color: bigTextColor),
                SizedBox(
                  height: SizeApp.height * 0.08,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ButtonApp(
                        buttonText: 'إلغاء',
                        color: primaryColor,
                        width: SizeApp.width * 0.25,
                        height: SizeApp.height * 0.05,
                        fontSize: SizeApp.textSize * 1.3,
                        radius: SizeApp.buttonRadius,
                        onPressed: cancel),
                    SizedBox(
                      width: SizeApp.width * 0.05,
                    ),
                    ButtonApp(
                        buttonText: 'تأكيد',
                        color: redColor,
                        width: SizeApp.width * 0.25,
                        height: SizeApp.height * 0.05,
                        fontSize: SizeApp.textSize * 1.3,
                        radius: SizeApp.buttonRadius,
                        onPressed: done),
                  ],
                )
              ],
            ),
          ),
        );
      });
}

// showDialog is for Wait
showDialogWait(
  BuildContext context, {
  required String title,
  bool pageRegister = true,
}) {
  return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          elevation: 0,
          backgroundColor: whiteColor,
          shape: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(SizeApp.dilogRadius),
            ),
            borderSide: BorderSide(
              color: bordarColor.withOpacity(0.5),
              width: SizeApp.width * 0.002,
            ),
          ),
          child: SizedBox(
            height: SizeApp.height * 0.28,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: SizeApp.height * 0.03,
                ),
                TextApp(
                    text: title,
                    size: SizeApp.textSize * 1.5,
                    fontWeight: FontWeight.normal,
                    textAlign: TextAlign.center,
                    color: bigTextColor),
                SizedBox(height: SizeApp.height * 0.04),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ButtonApp(
                        buttonText: 'تم',
                        color: primaryColor,
                        width: SizeApp.width * 0.25,
                        height: SizeApp.height * 0.05,
                        fontSize: SizeApp.textSize * 1.3,
                        radius: SizeApp.buttonRadius,
                        onPressed: () {
                          if (pageRegister) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const HomeTapBarNavigation()),
                            );
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Seller()));
                          }
                        }),
                  ],
                )
              ],
            ),
          ),
        );
      });
}

// showDialog is for Comment and Rating
showDialogCommentAndRating(
  BuildContext context, {
  required dynamic Function(RatingDialogResponse) onValue,
}) {
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
              onSubmitted: (value) {}),
        );
      });
}

// showDialog is for reason for deletion reason of refuse
showDialogAppReasonForDeletionReasonOfRefuse(
  BuildContext context, {
  required GlobalKey<FormState> formKey,
  required String title,
  required void Function()? done,
  String? Function(String?)? validator,
  TextEditingController? controller,
}) {
  return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          elevation: 0,
          backgroundColor: whiteColor,
          shape: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(SizeApp.dilogRadius),
            ),
            borderSide: BorderSide(
              color: bordarColor.withOpacity(0.5),
              width: SizeApp.width * 0.002,
            ),
          ),
          child: Form(
            key: formKey,
            child: SizedBox(
              height: SizeApp.height * 0.3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: SizeApp.width * 0.8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      TextApp(
                          text: title,
                          size: SizeApp.textSize * 1.3,
                          fontWeight: FontWeight.normal,
                          color: bigTextColor),
                      SizedBox(height: SizeApp.height * 0.01),
                      TextFieldApp(
                        width: SizeApp.width * 0.65,
                        style: TextStyle(fontSize: SizeApp.textSize * 1.3),
                        keyboardType: TextInputType.text,
                        textAlign: TextAlign.center,
                        controller: controller,
                        onChanged: (value) {
                          controller!.text = value;
                        },
                        validator: validator ??
                            (value) {
                              if (!RegExp(r'^.').hasMatch(value!)) {
                                return 'الحقل فارغ';
                              }
                              return null;
                            },
                      ),
                    ],
                  ),
                  SizedBox(height: SizeApp.height * 0.03),
                  ButtonApp(
                      buttonText: 'إرسال',
                      color: primaryColor,
                      width: SizeApp.width * 0.4,
                      height: SizeApp.height * 0.05,
                      fontSize: SizeApp.textSize * 1.3,
                      radius: SizeApp.buttonRadius,
                      onPressed: done)
                ],
              ),
            ),
          ),
        );
      });
}

// showDialog is for lift the product
showDialogAppLiftTheProduct(
  BuildContext context, {
  required GlobalKey<FormState> formKey,
  required String title,
  required String title2,
  required String title3,
  TextEditingController? controller,
  TextEditingController? controller2,
  TextEditingController? controller3,
  required void Function(String?)? onChanged,
  required void Function()? done,
}) {
  return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          elevation: 0,
          backgroundColor: whiteColor,
          shape: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(SizeApp.dilogRadius),
            ),
            borderSide: BorderSide(
              color: bordarColor.withOpacity(0.5),
              width: SizeApp.width * 0.002,
            ),
          ),
          child: Form(
            key: formKey,
            child: SizedBox(
              height: SizeApp.height * 0.65,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: SizeApp.width * 0.8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      TextApp(
                          text: title,
                          size: SizeApp.textSize * 1.2,
                          fontWeight: FontWeight.normal,
                          color: bigTextColor),
                      SizedBox(height: SizeApp.height * 0.01),
                      TextFieldApp(
                        width: SizeApp.width * 0.65,
                        style: TextStyle(fontSize: SizeApp.textSize * 1.3),
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        controller: controller,
                        validator: (value) {
                          if (!RegExp(r'^.').hasMatch(value!)) {
                            return 'الحقل فارغ';
                          } else if (RegExp(r'[^0-9]+$').hasMatch(value)) {
                            return 'يجب إدخال ارقام';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: SizeApp.height * 0.01),
                      TextApp(
                          text: title2,
                          size: SizeApp.textSize * 1.2,
                          fontWeight: FontWeight.normal,
                          color: bigTextColor),
                      SizedBox(height: SizeApp.height * 0.01),
                      TextFieldApp(
                        width: SizeApp.width * 0.65,
                        style: TextStyle(fontSize: SizeApp.textSize * 1.3),
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        controller: controller2,
                        validator: (value) {
                          if (!RegExp(r'^.+').hasMatch(value!)) {
                            return 'الحقل فارغ';
                          } else if (RegExp(r'[^0-9]+$').hasMatch(value)) {
                            return 'يجب إدخال ارقام';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: SizeApp.height * 0.01),
                      TextApp(
                          text: title3,
                          size: SizeApp.textSize * 1.2,
                          fontWeight: FontWeight.normal,
                          color: bigTextColor),
                      SizedBox(height: SizeApp.height * 0.01),
                      TextFieldApp(
                        width: SizeApp.width * 0.65,
                        style: TextStyle(fontSize: SizeApp.textSize * 1.3),
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        controller: controller3,
                        validator: (value) {
                          return null;
                        },
                      ),
                      SizedBox(height: SizeApp.height * 0.01),
                      TextApp(
                          text: 'هل المنتج قابل للإسترجاع؟',
                          size: SizeApp.textSize * 1.2,
                          fontWeight: FontWeight.normal,
                          color: bigTextColor),
                      SizedBox(height: SizeApp.height * 0.01),
                      DropdownButtonApp2(
                        onChanged: onChanged,
                      )
                    ],
                  ),
                  SizedBox(height: SizeApp.height * 0.03),
                  ButtonApp(
                    buttonText: 'رفع المنتج',
                    color: primaryColor,
                    width: SizeApp.width * 0.4,
                    height: SizeApp.height * 0.05,
                    fontSize: SizeApp.textSize * 1.3,
                    radius: SizeApp.buttonRadius,
                    onPressed: done,
                  )
                ],
              ),
            ),
          ),
        );
      });
}
// For the add anmin
// showDialogAppAddAdmin(
//   BuildContext context, {
//   required GlobalKey<FormState> formKey,
//   required String title,
//   TextEditingController? controller,
//   required void Function()? done,
// }) {
//   return showDialog(
//       context: context,
//       builder: (context) {
//         return Dialog(
//           elevation: 0,
//           backgroundColor: whiteColor,
//           shape: OutlineInputBorder(
//             borderRadius: BorderRadius.all(
//               Radius.circular(SizeApp.dilogRadius),
//             ),
//             borderSide: BorderSide(
//               color: bordarColor.withOpacity(0.5),
//               width: SizeApp.width * 0.002,
//             ),
//           ),
//           child: SizedBox(
//             height: SizeApp.height * 0.35,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 SizedBox(width: SizeApp.width * 0.8),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   children: [
//                     TextApp(
//                         text: title,
//                         size: SizeApp.textSize * 1.2,
//                         fontWeight: FontWeight.normal,
//                         color: bigTextColor),
//                     SizedBox(height: SizeApp.height * 0.01),
//                     TextFieldApp(
//                       width: SizeApp.width * 0.65,
//                       style: TextStyle(fontSize: SizeApp.textSize * 1.3),
//                       keyboardType: TextInputType.number,
//                       textAlign: TextAlign.center,
//                       controller: controller,
//                       validator: (value) {
//                         return null;
//                       },
//                     ),
//                     SizedBox(height: SizeApp.height * 0.01),
//                     TextApp(
//                         text: 'مسؤول',
//                         size: SizeApp.textSize * 1.2,
//                         fontWeight: FontWeight.normal,
//                         color: bigTextColor),
//                     SizedBox(height: SizeApp.height * 0.01),
//                     DropdownButtonApp3(
//                       selectedValue: 'فرعي',
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: SizeApp.height * 0.03),
//                 ButtonApp(
//                     buttonText: 'إضافة مسؤول آخر',
//                     color: primaryColor,
//                     width: SizeApp.width * 0.4,
//                     height: SizeApp.height * 0.05,
//                     fontSize: SizeApp.textSize * 1.3,
//                     radius: SizeApp.buttonRadius,
//                     onPressed: done)
//               ],
//             ),
//           ),
//         );
//       });
// }

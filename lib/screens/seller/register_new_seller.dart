// ignore_for_file: must_be_immutable

import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../model/color_app.dart';
import '../../model/data_information/seller_registration_info.dart';
import '../../model/database/firebase_helper.dart';
import '../../model/provider_app.dart';
import '../../model/sharedpreferances/sharedpreferances_keys_.dart';
import '../../model/sharedpreferances/sharedpreferences_users.dart';
import '../../model/size_app.dart';
import '../../widget/app_bar_with_button_back.dart';
import '../../widget/button.dart';
import '../../widget/show_dialog_app.dart';
import '../../widget/text.dart';
import '../../widget/text_field.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:geocoding/geocoding.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

class RegisterNewSeller extends StatefulWidget {
  String phone;
  RegisterNewSeller({super.key, required this.phone});

  @override
  State<RegisterNewSeller> createState() => _RegisterNewSellerState();
}

class _RegisterNewSellerState extends State<RegisterNewSeller> {
  final TextEditingController _sellerNameController = TextEditingController();

  final TextEditingController _ibanNumberController =
      TextEditingController(text: 'SA');
  XFile? pictureHere;
  final ImagePicker picker = ImagePicker();

  Future getImageForGallery(ImageSource source) async {
    XFile? image = await picker.pickImage(source: source);

    setState(() {
      pictureHere = image;
    });
  }

  // static LatLng currentLocation = _initialCameraPosition.target;
  // final Completer<GoogleMapController> controllerMap = Completer();
  // static const CameraPosition _initialCameraPosition = CameraPosition(
  //   target: LatLng(21.363356177873204,
  //       39.89073347300291), // Initial map location (San Francisco, CA)
  //   zoom: 12.0,
  // );
  // late GoogleMapController mapController;
  String location = 'الموقع المختار في الاعلى';
  var placemark = [];
  String administrativeAreaHint = "";
  String subAdministrativeAreaHint = "";
  String subLocalityHint = "";

  final _formKey = GlobalKey<FormState>();
  SellerRegistrationInfo setInfo = SellerRegistrationInfo();
  @override
  Widget build(BuildContext context) {
    ProviderApp dataProvide = Provider.of<ProviderApp>(context, listen: false);
    setInfo.phone = dataProvide.phone;
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
                        textField(
                            text: 'اسم البائع',
                            controller: _sellerNameController,
                            keyboardType: TextInputType.name,
                            onChanged: (value) {
                              setInfo.fullName = value;
                            },
                            validator: (value) {
                              if (!RegExp(r'^(.)[^#@$%&*+-=!:)(_?؟]+$')
                                  .hasMatch(value!)) {
                                return 'الحقل فارغ';
                              }
                              return null;
                            }),
                        SizedBox(
                          height: SizeApp.height * 0.03,
                        ),
                        SizedBox(
                          height: SizeApp.height * 0.03,
                        ),
                        detectLocation(),
                        SizedBox(
                          height: SizeApp.height * 0.03,
                        ),
                        SizedBox(
                          height: SizeApp.height * 0.03,
                        ),
                        addImage(),
                        SizedBox(
                          height: SizeApp.height * 0.03,
                        ),
                        textField(
                            text: 'رقم الايبان',
                            controller: _ibanNumberController,
                            style: TextStyle(fontSize: SizeApp.textSize * 1.1),
                            onChanged: (value) {
                              setInfo.iban = value;
                            },
                            validator: (value) {
                              if (!RegExp(r'^SA\d{2}[0-9A-Z]{20}$')
                                  .hasMatch(value!)) {
                                return 'الرجاء إدخال الايبان بشكل صحيح';
                              }

                              return null;
                            }),
                        SizedBox(
                          height: SizeApp.height * 0.03,
                        ),
                        ButtonApp(
                            buttonText: 'تسجيل دخول',
                            color: redColor,
                            width: SizeApp.width * 0.7,
                            fontSize: SizeApp.textSize * 1.7,
                            radius: SizeApp.buttonRadius,
                            onPressed: () {
                              setState(() {});
                              if (_formKey.currentState!.validate()) {
                                setInfo.time = FieldValue.serverTimestamp();
                                SharedPreferencesSignup().saveData(
                                    key: SharedPreferencesKeys.userType,
                                    value: 'بائع');
                                SharedPreferencesSignup().saveData(
                                    key: SharedPreferencesKeys.phone,
                                    value: dataProvide.phone);
                                FirebaseAppHelper().uploadImage(
                                    phoneProduct: setInfo.phone!,
                                    nameImage: setInfo.statement,
                                    imagePath: File(pictureHere!.path));
                                FirebaseAppHelper().setDataSeller(
                                    phone: setInfo.phone!,
                                    setData: setInfo.toMap());
                                showDialogWait(
                                  context,
                                  title: 'إنتظار موافقة المسؤل',
                                );
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
      required TextEditingController? controller,
      String? Function(String?)? validator,
      TextInputType? keyboardType,
      TextStyle? style,
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
          style: style ?? TextStyle(fontSize: SizeApp.textSize * 1.3),
          keyboardType: keyboardType,
          textAlign: TextAlign.center,
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
          TextApp(
              text: 'رفع صورة وثيقة العمل الحر او السجل التجاري',
              size: SizeApp.textSize * 1.2,
              fontWeight: FontWeight.normal,
              color: bigTextColor),
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
                  ? SvgPicture.asset(
                      'assets/icons/icon _add image_.svg',
                      width: SizeApp.iconSize * 2,
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

  Widget detectLocation() {
    return FormField<String>(
      validator: (value) {
        value = location;
        if (value == 'الموقع المختار في الاعلى') {
          return 'الرجاء تحديد الموقع';
        } else {
          return null;
        }
      },
      builder: (fieldDetectLocation) => Column(
        children: [
          TextApp(
              text: 'اختيار الموقع',
              size: SizeApp.textSize * 1.2,
              fontWeight: FontWeight.normal,
              color: bigTextColor),
          SizedBox(height: SizeApp.height * 0.01),
          Container(
            width: SizeApp.width,
            height: SizeApp.height * 0.28,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(SizeApp.dilogRadius),
              border: Border.all(
                  color: fieldDetectLocation.hasError
                      ? const Color.fromARGB(255, 176, 27, 16)
                      : const Color(0x00000000),
                  width: SizeApp.width * 0.002),
            ),
            child: ClipRRect(
              borderRadius:
                  BorderRadius.all(Radius.circular(SizeApp.dilogRadius)),
              child: Stack(alignment: Alignment.center, children: [
                // GoogleMap(
                //   mapType: MapType.normal,
                //   gestureRecognizers: Set()
                //     ..add(Factory<EagerGestureRecognizer>(
                //         () => EagerGestureRecognizer())),
                //   indoorViewEnabled: true,
                //   myLocationEnabled: true,
                //   initialCameraPosition: _initialCameraPosition,
                //   buildingsEnabled: true,
                //   myLocationButtonEnabled: true,
                //   onMapCreated: (controller) {
                //     controllerMap.complete(controller);
                //   },
                //   onCameraMove: (CameraPosition e) async {
                //     currentLocation = e.target;
                //     setInfo.latSeller = currentLocation.latitude.toString();
                //     setInfo.longSeller = currentLocation.longitude.toString();
                //   },
                // ),
                Icon(
                  Icons.location_on,
                  color: primaryColor,
                  size: SizeApp.iconSize * 1.23,
                )
              ]),
            ),
          ),
          if (fieldDetectLocation.hasError)
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 5, SizeApp.width * 0.09, 0),
                  child: TextApp(
                      text: fieldDetectLocation.errorText!,
                      size: SizeApp.textSize * 0.9,
                      fontWeight: FontWeight.normal,
                      color: const Color.fromARGB(255, 176, 27, 16)),
                ),
              ],
            ),
          SizedBox(height: SizeApp.height * 0.01),
          ButtonApp(
            buttonText: 'تحديد الموقع',
            color: primaryColor,
            width: SizeApp.width * 0.55,
            height: SizeApp.height * 0.05,
            fontSize: SizeApp.textSize * 1.5,
            radius: SizeApp.buttonRadius,
            fontWeight: FontWeight.w600,
            onPressed: () {
              // getAddress(currentLocation.latitude, currentLocation.longitude)
              //     .then((value) {
              //   placemark = value;
              //   setState(() {
              //     administrativeAreaHint = placemark[0].administrativeArea!;
              //     subAdministrativeAreaHint = value[0].subAdministrativeArea!;
              //     subLocalityHint = value[0].subLocality!;
              //
              //     location =
              //         '$administrativeAreaHint, $subAdministrativeAreaHint, '
              //         '$subLocalityHint';
              //     setInfo.location = location;
              //   });
              // });
            },
          ),
          SizedBox(height: SizeApp.height * 0.01),
          Container(
            padding: const EdgeInsets.all(10),
            width: SizeApp.width * 0.8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(SizeApp.cardRadius),
              border:
                  Border.all(color: bordarColor, width: SizeApp.width * 0.002),
              color: whiteColor,
            ),
            alignment: Alignment.center,
            child: TextApp(
                text: location,
                size: SizeApp.textSize * 1.2,
                textAlign: TextAlign.center,
                fontWeight: FontWeight.normal,
                color: bigTextColor),
          )
        ],
      ),
    );
  }

  //For convert lat long to address
  Future getAddress(lat, long) async {
    List<Placemark> placeMarks = await placemarkFromCoordinates(
      lat,
      long,
    );

    return placeMarks;
  }
}

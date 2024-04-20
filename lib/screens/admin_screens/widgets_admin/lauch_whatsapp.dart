import 'dart:io';
import 'package:url_launcher/url_launcher.dart';

//this Function for the launchWhatsApp message
void launchWhatsApp({
  required String consigneeNumber,
  required String titleMessage,
  required String textMessage,
}) async {
  String message = '$titleMessage : $textMessage';

  //launch the wahtsapp IOS and Android message
  final String whatsappURLIos = 'https://wa.me/$consigneeNumber/?text=$message';
  final String whatsappURlAndroid =
      'whatsapp://send?phone=$consigneeNumber&text=$message';

  if (Platform.isIOS) {
    // for iOS phone only
    if (await canLaunchUrl(Uri.parse(whatsappURLIos))) {
      await launchUrl(Uri.parse(whatsappURLIos));
    }
  } else {
    // android , web
    if (await canLaunchUrl(Uri.parse(whatsappURlAndroid))) {
      await launchUrl(Uri.parse(whatsappURlAndroid));
    }
  }
}

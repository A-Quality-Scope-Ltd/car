import 'dart:io';
import 'package:car/model/size_app.dart';
import 'package:flutter/services.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

class CreatePDF {
  int? totalNumberOfSellers = 0;
  int? totalNumberOfProducts = 0;
  int? totalNumberOfRequests = 0;
  int? totalNumberOfReturnRequests = 0;
  CreatePDF({
    required this.totalNumberOfSellers,
    required this.totalNumberOfProducts,
    required this.totalNumberOfRequests,
    required this.totalNumberOfReturnRequests,
  });

  int reportNumber = 1;

  //Create and Save PDF Document
  Future<File> _saveDocument({
    required String nameDocument,
    required Document pdf,
  }) async {
    final bytes = await pdf.save();
    final directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/$nameDocument');
    await file.writeAsBytes(bytes);
    return file;
  }

  //Open PDF Page
  Future openFile(File file) async {
    final String url = file.path;
    await OpenFile.open(url);
  }

  //Add something in the PDF Page
  Future<File> generate() async {
    final Document pdf = Document();
    final Font arabicFont = Font.ttf(
        await rootBundle.load("assets/fonts/NotoSansArabic-Medium.ttf"));
    final Uint8List image =
        (await rootBundle.load("assets/images/logo.png")).buffer.asUint8List();

    pdf.addPage(Page(
        textDirection: TextDirection.rtl,
        theme: ThemeData.withFont(base: arabicFont),
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        build: (context) {
          return Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              _buildTitle(
                text: 'تقرير اكلة وحرفة',
                fontSize: 28,
              ),
              _buildTitle(
                text:
                    '${DateTime.now().day.toString()}-${DateTime.now().month.toString()}-${DateTime.now().year.toString()}',
                fontSize: 20,
              ),
              _buildImage(image),
            ]),
            SizedBox(height: 100),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _designStatistics(
                    title: 'إجمالي عدد البائعين',
                    number: '$totalNumberOfSellers'),
                _designStatistics(
                    title: 'اجمالي عدد المنتجات',
                    number: '$totalNumberOfProducts'),
              ],
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _designStatistics(
                    title: 'إجمالي عدد الطلبات',
                    number: '$totalNumberOfRequests'),
                _designStatistics(
                    title: 'إجمالي عدد طلبات الاسترجاع',
                    number: '$totalNumberOfReturnRequests'),
              ],
            ),
          ]);
        }));

    return _saveDocument(
      nameDocument: 'تقرير $reportNumber.pdf',
      pdf: pdf,
    );
  }

//Design PDF Page BuildTitle
  Widget _buildTitle({
    required String text,
    double? fontSize = 18,
    PdfColor? color,
  }) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: fontSize,
        color: color ?? const PdfColor.fromInt(0xff000000),
      ),
    );
  }

  //Design PDF Page BuildImage
  Widget _buildImage(Uint8List image) {
    return Image(
      MemoryImage(image),
      width: 200,
      height: 200,
    );
  }

  Widget _designStatistics({required String title, required String number}) {
    return Container(
      width: 250,
      height: 150,
      decoration: BoxDecoration(
        color: const PdfColor.fromInt(0xffffffff),
        borderRadius: BorderRadius.all(Radius.circular(SizeApp.cardRadius)),
        border: Border.all(
            color: const PdfColor.fromInt(0xff7C7C7C),
            width: SizeApp.width * 0.002),
      ),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        _buildTitle(
          text: title,
          fontSize: 18,
        ),
        SizedBox(
          height: SizeApp.height * 0.008,
        ),
        _buildTitle(
          text: number,
          fontSize: 28,
        ),
      ]),
    );
  }
}

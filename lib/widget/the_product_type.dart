import 'package:car/widget/text.dart';
import 'package:car/widget/text_field.dart';
import 'package:flutter/material.dart';

import '../model/color_app.dart';
import '../model/size_app.dart';

// ignore: must_be_immutable
class TheProductType extends StatefulWidget {
  String page;
  List<String> listType = [];
  TheProductType({super.key, this.page = '', required this.listType});

  @override
  State<TheProductType> createState() => _TheProductTypeState();
}

class _TheProductTypeState extends State<TheProductType> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.fromLTRB(SizeApp.padding * 2, 0, SizeApp.padding * 2, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              TextApp(
                  text: widget.page == 'تعديل'
                      ? 'تعديل نوع المنتج'
                      : 'ادخل نوع المنتج',
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
          SizedBox(
            width: SizeApp.width,
            height: SizeApp.height * 0.14,
            child: GridView.builder(
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                mainAxisExtent: SizeApp.height * 0.06,
                maxCrossAxisExtent: SizeApp.width * 0.28,
                mainAxisSpacing: 5,
                crossAxisSpacing: 10,
              ),
              itemCount: 5,
              itemBuilder: (BuildContext context, int index) {
                return _buildWidget(index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWidget(
    int index,
  ) {
    return TextFieldApp(
        hintText: 'ادخل نص',
        style: TextStyle(fontSize: SizeApp.textSize * 1),
        hintStyle: TextStyle(
          fontSize: SizeApp.textSize * 1,
        ),
        maxLines: 1,
        keyboardType: TextInputType.name,
        onChanged: (value) {
          if (value.isNotEmpty) {
            setState(() {
              widget.listType[index] = value;
            });
          }
        });
  }
}

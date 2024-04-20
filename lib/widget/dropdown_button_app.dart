import 'package:flutter/material.dart';
import '../model/color_app.dart';
import '../model/size_app.dart';

// ignore: must_be_immutable
class DropdownButtonApp extends StatefulWidget {
  void Function(String?)? onChanged;
  DropdownButtonApp({
    super.key,
    required this.onChanged,
  });

  @override
  State<DropdownButtonApp> createState() => _DropdownButtonAppState();
}

class _DropdownButtonAppState extends State<DropdownButtonApp> {
  List<String> listDropdownButton = [
    'الحرف اليدوية',
    'الأكل الشعبي',
    'حلويات',
    'الأكل الصحي',
    'الأطباق المنوعة',
  ];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeApp.width * 0.8,
      child: DropdownButtonFormField(
        icon: Icon(Icons.arrow_drop_down, color: primaryColor),
        iconSize: SizeApp.iconSize,
        style: TextStyle(fontSize: SizeApp.textSize, color: bigTextColor),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          border: OutlineInputBorder(
            borderSide:
                BorderSide(color: bordarColor, width: SizeApp.width * 0.002),
            borderRadius: BorderRadius.circular(SizeApp.buttonRadius),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: bordarColor, width: SizeApp.width * 0.002),
            borderRadius: BorderRadius.circular(SizeApp.buttonRadius),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: bordarColor, width: SizeApp.width * 0.002),
            borderRadius: BorderRadius.circular(SizeApp.buttonRadius),
          ),
        ),
        value: listDropdownButton[1],
        onChanged: widget.onChanged,
        items: listDropdownButton.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            alignment: Alignment.centerRight,
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}

// ignore: must_be_immutable
class DropdownButtonApp2 extends StatefulWidget {
  void Function(String?)? onChanged;

  DropdownButtonApp2({
    super.key,
    required this.onChanged,
  });

  @override
  State<DropdownButtonApp2> createState() => _DropdownButtonApp2State();
}

class _DropdownButtonApp2State extends State<DropdownButtonApp2> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeApp.width * 0.65,
      child: DropdownButtonFormField(
        icon: Icon(Icons.arrow_drop_down, color: primaryColor),
        iconSize: SizeApp.iconSize,
        style: TextStyle(fontSize: SizeApp.textSize, color: bigTextColor),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          border: OutlineInputBorder(
            borderSide:
                BorderSide(color: bordarColor, width: SizeApp.width * 0.002),
            borderRadius: BorderRadius.circular(SizeApp.buttonRadius),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: bordarColor, width: SizeApp.width * 0.002),
            borderRadius: BorderRadius.circular(SizeApp.buttonRadius),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: bordarColor, width: SizeApp.width * 0.002),
            borderRadius: BorderRadius.circular(SizeApp.buttonRadius),
          ),
        ),
        value: 'لا',
        onChanged: widget.onChanged,
        items: [
          'نعم',
          'لا',
        ].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            alignment: Alignment.centerRight,
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}

// ignore: must_be_immutable
class DropdownButtonApp3 extends StatefulWidget {
  String selectedValue;
  DropdownButtonApp3({
    super.key,
    required this.selectedValue,
  });

  @override
  State<DropdownButtonApp3> createState() => _DropdownButtonApp3State();
}

class _DropdownButtonApp3State extends State<DropdownButtonApp3> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeApp.width * 0.65,
      child: DropdownButtonFormField(
        icon: Icon(Icons.arrow_drop_down, color: primaryColor),
        iconSize: SizeApp.iconSize,
        style: TextStyle(fontSize: SizeApp.textSize, color: bigTextColor),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          border: OutlineInputBorder(
            borderSide:
                BorderSide(color: bordarColor, width: SizeApp.width * 0.002),
            borderRadius: BorderRadius.circular(SizeApp.buttonRadius),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: bordarColor, width: SizeApp.width * 0.002),
            borderRadius: BorderRadius.circular(SizeApp.buttonRadius),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: bordarColor, width: SizeApp.width * 0.002),
            borderRadius: BorderRadius.circular(SizeApp.buttonRadius),
          ),
        ),
        value: widget.selectedValue,
        onChanged: (String? newValue) {
          setState(() {
            widget.selectedValue = newValue!;
          });
        },
        items: [
          'رئيسي',
          'فرعي',
        ].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            alignment: Alignment.centerRight,
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}

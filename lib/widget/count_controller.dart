import 'package:flutter/material.dart';
import '../model/color_app.dart';
import '../model/size_app.dart';

class CountController extends StatefulWidget {
  final Widget Function(bool enabled) removeNumber;
  final Widget Function(bool enabled) addNumber;
  final Widget Function(int count) countBuilder;
  final int count;
  final Function(int) updateCount;
  final int stepSize;
  final int? minimum;
  final int? maximum;

  const CountController({
    Key? key,
    required this.removeNumber,
    required this.addNumber,
    required this.countBuilder,
    required this.count,
    required this.updateCount,
    this.stepSize = 1,
    this.minimum,
    this.maximum,
  }) : super(key: key);
  @override
  State<CountController> createState() => _CountControllerState();
}

class _CountControllerState extends State<CountController> {
  int get count => widget.count;
  int? get minimum => widget.minimum;
  int? get maximum => widget.maximum;
  int get stepSize => widget.stepSize;

  bool get canRemove => minimum == null || count - stepSize >= minimum!;
  bool get canAdd => maximum == null || count + stepSize <= maximum!;

  void _removeCounter() {
    if (canRemove) {
      setState(() => widget.updateCount(count - stepSize));
    }
  }

  void _addCounter() {
    if (canAdd) {
      setState(() => widget.updateCount(count + stepSize));
    }
  }

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: _addCounter,
            child: widget.addNumber(canAdd),
          ),
          Container(
            margin:
                EdgeInsets.only(left: SizeApp.padding, right: SizeApp.padding),
            padding: EdgeInsets.only(
              right: SizeApp.width * 0.05,
              left: SizeApp.width * 0.05,
              bottom: SizeApp.width * 0.035,
              top: SizeApp.width * 0.035,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(SizeApp.dilogRadius),
              border:
                  Border.all(color: bordarColor, width: SizeApp.width * 0.002),
              color: whiteColor,
            ),
            child: widget.countBuilder(count),
          ),
          GestureDetector(
            onTap: _removeCounter,
            child: widget.removeNumber(canRemove),
          ),
        ],
      );
}

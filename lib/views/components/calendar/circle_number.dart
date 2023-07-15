import 'package:flutter/material.dart';

class CircleNumber extends StatelessWidget {
  final String text;
  final EdgeInsets? padding;
  final TextStyle? textStyle;
  final Border? border;
  final Color? backColor;
  final double? size;

  const CircleNumber({
    Key? key,
    required this.text,
    this.textStyle,
    this.padding = const EdgeInsets.all(7.0),
    this.backColor = Colors.transparent,
    this.size,
    this.border,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mBorder = border?? Border.all(color: Colors.black, width: 0.7, style: BorderStyle.solid);

    return SizedBox(
      width: size,
      height: size,
      child: DecoratedBox(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: mBorder,
            color: backColor
          ),

        child: Center(
          widthFactor: 1,
          child: Padding(
            padding: padding!,
            child: Text(text, style: textStyle),
          ),
        ),
      ),
    );
  }
}

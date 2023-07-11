import 'package:flutter/material.dart';

class CustomRich extends StatelessWidget {
  final List children;
  final PlaceholderAlignment alignment;

  const CustomRich({
    Key? key,
    required this.children,
    this.alignment = PlaceholderAlignment.bottom,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: children.map<InlineSpan>(map).toList()
      )
    );
  }

  InlineSpan map(dynamic w){
    if(w is InlineSpan){
      return w;
    }

    if(w is Text){
      return TextSpan(text: w.data, style: w.style, locale: w.locale);
    }

    return WidgetSpan(child: w, alignment: alignment);
  }
}

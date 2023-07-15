import 'package:flutter/cupertino.dart';
import 'package:iris_tools/api/generator.dart';


typedef OnDayClick = void Function(CalendarDayModel day);
///=========================================================================================
class CalendarDayModel {
  String id = '';
  String text;
  TextStyle? textStyle;
  Border? border;
  Color color;
  OnDayClick? onClick;

  CalendarDayModel({required this.text, required this.color}) : id = Generator.generateName(10);

}

import 'package:flutter/material.dart';

import 'package:app/tools/app/appDecoration.dart';
import 'package:app/views/components/calendar/calendarDayModel.dart';
import 'package:app/views/components/calendar/circle_number.dart';

class CalendarBuilder extends StatefulWidget {
  final List<CalendarDayModel> dayList;

  const CalendarBuilder({
    Key? key,
    required this.dayList,
  }) : super(key: key);

  @override
  State createState() => _CalendarBuilderState();
}
///===============================================================================================
class _CalendarBuilderState extends State<CalendarBuilder> {

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 5,
      spacing: 3,
      children: widget.dayList.map(mapDay).toList(),
    );
  }

  Widget mapDay(CalendarDayModel day){
    return GestureDetector(
      onTap: (){
        day.onClick?.call(day);
      },
      child: CircleNumber(
        text: day.text,
        backColor: day.color,
        size: day.size?? 37,
        textStyle: day.textStyle?? TextStyle(fontSize: AppDecoration.fontSizeRelative(-2)),
        border: day.border?? Border.all(style: BorderStyle.none),
      ),
    );
  }
}

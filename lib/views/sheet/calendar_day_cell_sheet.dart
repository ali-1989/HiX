import 'package:app/structures/models/calendarDayModel.dart';
import 'package:app/system/extensions.dart';
import 'package:app/tools/app/appDecoration.dart';
import 'package:app/tools/app/appImages.dart';
import 'package:flutter/material.dart';

class CalendarDayCellSheet extends StatefulWidget {
  final CalendarDayModel day;

  const CalendarDayCellSheet({
    super.key,
    required this.day,
  });

  @override
  State<CalendarDayCellSheet> createState() => _CalendarDayCellSheetState();
}
///=============================================================================
class _CalendarDayCellSheetState extends State<CalendarDayCellSheet> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //final theme = Theme.of(context);
    const rr = Radius.circular(15);

    return ClipRRect(
      borderRadius: const BorderRadius.only(topLeft: rr, topRight: rr),
      child: ColoredBox(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 14),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(AppImages.navIco$calendar),
                      const SizedBox(width: 10),

                      Text('26 خرداد 1402'.localeNum()).font(AppDecoration.morabbaFont).fsR(3),
                    ],
                  ),

                  Row(
                    children: [
                      Image.asset(AppImages.textIco),
                      Image.asset(AppImages.sexRelationIco),
                      Image.asset(AppImages.supportIco),
                      Image.asset(AppImages.consultationIco),
                    ],
                  )
                ],
              ),

              SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}

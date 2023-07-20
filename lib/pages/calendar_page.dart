import 'package:app/structures/abstract/stateBase.dart';
import 'package:app/structures/models/calendarDayModel.dart';
import 'package:app/system/extensions.dart';
import 'package:app/tools/app/appDecoration.dart';
import 'package:app/tools/app/appIcons.dart';
import 'package:app/tools/app/appImages.dart';
import 'package:flutter/material.dart';
import 'package:iris_tools/api/generator.dart';
import 'package:iris_tools/modules/stateManagers/assist.dart';
import 'package:iris_tools/widgets/customCard.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  State createState() => CalendarPageState();
}
///====================================================================================
class CalendarPageState extends StateBase<CalendarPage> {
  Color pmsColor = const Color(0xffFFEC94);
  Color periodColor = const Color(0xffEDC6FF);
  Color ovulationColor = const Color(0xffABFFEF);
  List<CalendarDayModel> dayList = [];

  @override
  void initState(){
    super.initState();

    genDays();
  }

  @override
  void dispose(){
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Assist(
        controller: assistCtr,
        builder: (_, ctr, data){
          return buildBody();
        }
    );
  }

  Widget buildBody() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18 * pw),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildHeaderSection(),

          buildCalendarCells(),
        ]
      ),
    );
  }

  Widget buildHeaderSection(){
    return Column(
      children: [
        const SizedBox(height: 20),
        CustomCard(
          padding: const EdgeInsets.all(5),
          color: AppDecoration.gray,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomCard(
                color: Colors.white,
                padding: const EdgeInsets.all(8),
                child: const Icon(AppIcons.arrowLeft, size: 15,).alpha(alpha: 100),
              ),

              Text('خرداد    1402'.localeNum()).font(AppDecoration.morabbaFont),

              CustomCard(
                color: Colors.white,
                padding: const EdgeInsets.all(8),
                child: RotatedBox(
                    quarterTurns: 2,
                    child: const Icon(AppIcons.arrowLeft, size: 15,).alpha(alpha: 100)
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),
        Row(
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(3),
                  child: SizedBox(
                    width: 9,
                    child: Divider(
                      height: 8,
                      thickness: 8,
                      color: AppDecoration.gray,
                    ),
                  ),
                ),

                const SizedBox(width: 5),
                const Text('خنثی').font(AppDecoration.morabbaFont).fsR(-4)
              ],
            ),

            const SizedBox(width: 10),
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(3),
                  child: SizedBox(
                    width: 9,
                    child: Divider(
                      height: 8,
                      thickness: 8,
                      color: ovulationColor,
                    ),
                  ),
                ),

                const SizedBox(width: 5),
                const Text('تخمک گذاری').font(AppDecoration.morabbaFont).fsR(-4)
              ],
            ),

            const SizedBox(width: 10),
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(3),
                  child: SizedBox(
                    width: 9,
                    child: Divider(
                      height: 8,
                      thickness: 8,
                      color: pmsColor,
                    ),
                  ),
                ),

                const SizedBox(width: 5),
                const Text('PMS').font(AppDecoration.morabbaFont).fsR(-4)
              ],
            ),

            const SizedBox(width: 10),
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(3),
                  child: SizedBox(
                    width: 9,
                    child: Divider(
                      height: 8,
                      thickness: 8,
                      color: periodColor,
                    ),
                  ),
                ),

                const SizedBox(width: 5),
                const Text('قاعدگی').font(AppDecoration.morabbaFont).fsR(-4)
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget buildCalendarCells(){
    return Wrap(
      children: dayList.map(map).toList(),
    );
  }

  Widget map(CalendarDayModel day){
    return SizedBox(
      width: 30,
      height: 30,
      child: CustomCard(
        color: Colors.white,
          padding: EdgeInsets.all(2),
          child: Column(
            children: [
              Text(day.number),

              Row(
                children: [
                  Image.asset(AppImages.supportIco),
                  Image.asset(AppImages.consultationIco),
                ],
              )
           ],
          )
      ),
    );
  }

  void genDays() {
    List.generate(31, (index) {
      final d = CalendarDayModel();
      d.number = '$index';
      d.hasSupportTime = Generator.getRandomFrom([true, false]);

      dayList.add(d);
    });
  }
}

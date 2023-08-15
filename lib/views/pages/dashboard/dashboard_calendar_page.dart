import 'package:flutter/material.dart';

import 'package:iris_tools/modules/stateManagers/assist.dart';
import 'package:iris_tools/widgets/customCard.dart';
import 'package:iris_tools/widgets/text/customRich.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';

import 'package:app/structures/abstract/stateBase.dart';
import 'package:app/system/extensions.dart';
import 'package:app/tools/app/appDecoration.dart';
import 'package:app/tools/app/appIcons.dart';
import 'package:app/tools/app/appImages.dart';
import 'package:app/tools/app/appSheet.dart';
import 'package:app/tools/app/appThemes.dart';
import 'package:app/views/components/calendar/calendarDayModel.dart';
import 'package:app/views/components/calendar/calendar_builder.dart';
import 'package:app/views/sheets/period_change_state_sheet.dart';
import 'package:app/views/sheets/pregnant_change_state_sheet.dart';

class DashboardCalendarPage extends StatefulWidget {
  const DashboardCalendarPage({Key? key}) : super(key: key);

  @override
  State createState() => _DashboardCalendarPageState();
}
///============================================================================================
class _DashboardCalendarPageState extends StateBase<DashboardCalendarPage> {
  Color pmsColor = const Color(0xffFFEC94);
  Color periodColor = const Color(0xffEDC6FF);
  Color ovulationColor = const Color(0xffABFFEF);
  bool isPregnant = true;

  @override
  void initState(){
    super.initState();
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
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: Column(
          children: [
            buildTopSection(),

            const SizedBox(height: 15),
            Builder(
                builder: (_){
                  if(isPregnant){
                    return buildWeekProgressSection();
                  }

                  return buildCalendarSection();
                }
            ),

            const SizedBox(height: 15),
            buildAdviceSection(),

            const SizedBox(height: 15),
            buildInfoSection(),

            const SizedBox(height: 5),
          ],
        ),
      ),
    );
  }

  Widget buildTopSection() {
    return CustomCard(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const TabPageSelectorIndicator(
                      size: 8,
                      backgroundColor: Colors.red,
                      borderColor: Colors.red,
                    ),

                    const SizedBox(width: 3),

                    Text(isPregnant ? 'تقویم بارداری' : 'تقویم قاعدگی').font(AppDecoration.morabbaFont),
                  ],
                ),

                Row(
                  children: [
                    CustomCard(
                        padding: const EdgeInsets.all(5),
                        color: AppDecoration.gray,
                        child: Image.asset(AppImages.questionMarkFaIco, width: 18, height: 18,)
                    ),
                    const SizedBox(width: 5),

                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: onChangeStateClick,
                      child: Row(
                        children: [
                          CustomCard(
                              padding: const EdgeInsets.all(5),
                              color: AppDecoration.gray,
                              child: Image.asset(AppImages.changeValueIco, width: 18)
                          ),
                          const SizedBox(width: 5),

                          const Text('تغییر\nوضعیت').font(AppDecoration.morabbaFont).fsR(-4),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),

            Builder(
                builder: (_){
                  if(isPregnant){
                    return const SizedBox();
                  }

                  return buildPeriodHelp();
                }
            ),
          ],
        )
    );
  }

  Widget buildPeriodHelp(){
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

  Widget buildCalendarSection() {
    final list = <CalendarDayModel>[];

    for(int i =1; i < 31; i++){
      list.add(CalendarDayModel(text: '$i', color: Colors.grey,)..size = 37*pw);
    }

    for(int i =0; i < 9; i++){
      list[i].color = pmsColor;
    }

    for(int i =9; i < 18; i++){
      list[i].color = periodColor;
    }

    for(int i =18; i < 24; i++){
      list[i].color = ovulationColor;
    }

    for(int i =24; i < 30; i++){
      list[i].color = Colors.white;
    }


    list[24].border = Border.all(style: BorderStyle.solid, width: 0.5, color: Colors.blueAccent);
    list[24].color = Colors.white;

    return CalendarBuilder(
      dayList: list,
    );
  }

  Widget buildInfoSection() {
    return ConstrainedBox(//IntrinsicHeight
      constraints: const BoxConstraints(
        minHeight: 150,
        //maxHeight: 220,
      ),
      child: CustomCard(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
          child: Column(
            children: [
              CustomCard(
                color: AppDecoration.gray,
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('موارد قابل توجه').font(AppDecoration.morabbaFont).color(Colors.red).fsR(-1),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              ListView.separated(
                itemCount: 10,
                shrinkWrap: true,
                itemBuilder: infoItemBuilder,
                separatorBuilder: (_, idx) {
                  if(idx == 0 || idx == 8){
                    return const SizedBox();
                  }

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2.0),
                    child: Divider(color: AppDecoration.gray,),
                  );
                },
              ),
            ],
          )
      ),
    );
  }

  Widget buildWeekProgressSection() {
    return Column(
      children: [
        const Text('هفته 2').fsR(-2).bold(),

        const SizedBox(height: 12),

        Stack(
          children: [
            Positioned(
                top: 5,
                right: 5,
                child: Image.asset(AppImages.baby, width: 87, height: 87, fit: BoxFit.fill,)
            ),

            SimpleCircularProgressBar(
              animationDuration: 2,
              progressStrokeWidth: 12,
              backStrokeWidth: 12,
              backColor: Colors.white,
              fullProgressColor: Colors.white,
              maxValue: 360,
              mergeMode: false,
              size: 92,
              progressColors: [AppDecoration.mainColor.withAlpha(30),
                AppDecoration.mainColor.withAlpha(120),
                AppDecoration.mainColor.withAlpha(170),
                AppDecoration.mainColor
              ],
              valueNotifier: ValueNotifier(270),
            ),
          ],
        ),

        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('هفته های سپری شده:').fsR(-2),

            CustomCard(
              color: AppDecoration.mainColor,
              radius: 15,
              padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
              child: Row(
                children: [
                  const Text('40 /').color(Colors.white).fsR(-2),
                  Text(' 26'.localeNum()).color(Colors.white).bold().fsR(-2).font(AppDecoration.morabbaFont),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget infoItemBuilder(_, int idx){
    if(idx == 0 || idx == 9) {
      return Divider(color: AppDecoration.gray,);
    }

    if(idx == 3) {
      return buildInfoLine('به زندگی امیدوار باش و به پیش برو.به زندگی امیدوار باش و به پیش برو');
    }

    return buildInfoLine('دنیا بدون تو هم ادامه دارد. پس فرد مفیدی باش');
  }

  Widget buildInfoLine(String txt){
    final st = AppThemes.instance.currentTheme.baseTextStyle.copyWith(height: 2.0 *pw, fontSize: 12 *pw);

    /*var tp = TextPainter(
      textAlign: AppThemes.getTextAlign(),
      textDirection: AppThemes.instance.textDirection,
      textWidthBasis: TextWidthBasis.parent,
      text: TextSpan(text: 'به متن ', style: st),
    );

    tp.layout(maxWidth: double.infinity);*/

    return CustomRich(
        alignment: PlaceholderAlignment.middle,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 2),
            child: TabPageSelectorIndicator(
              backgroundColor: Colors.red,
              borderColor: Colors.red,
              size: 4,
            ),
          ),

          Text(txt, style: st),
        ]
    );
  }

  Widget buildAdviceSection(){
    return CustomCard(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      color: AppDecoration.boxGreenColor.withAlpha(40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset(AppImages.infoIco, color: Colors.black, width: 24),
              const SizedBox(width: 6),
              const Text('توصیه').boldFont().fsR(1)
            ],
          ),

          const SizedBox(height: 6),
          const Text('فردا زودتر از خواب بیدار شو'),

          const SizedBox(height: 12),
          CustomCard(
              padding: const EdgeInsets.fromLTRB(5, 1, 5, 3),
              color: AppDecoration.boxGreenColor,
              radius: 17,
              child: const Text('مشاهده لینک').fsR(-3)
          )
        ],
      ),
    ).wrapBoxBorder(
      color: AppDecoration.boxGreenColor,
      padding: EdgeInsets.zero,
    );
  }

  void onChangeStateClick(){
    Widget b(_){
      if(isPregnant) {
        return const PregnantChangeStateSheet();
      }
      else {
        return const PeriodChangeStateSheet();
      }
    }

    AppSheet.showSheetCustom(
      context,
      builder: b,
      contentColor: Colors.transparent,
      routeName: 'change',
    );
  }
}
///=====================================================================
class MakeBookLine extends CustomPainter {
  final Color color;
  final bool drawTopLine;
  final double lineSpace;
  final double leftPad;
  final double rightPad;

  MakeBookLine({
    required this.color,
    required this.lineSpace,
    this.drawTopLine = false,
    this.leftPad = 0,
    this.rightPad = 0,
  }): super();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    paint.color = color;
    paint.isAntiAlias = false;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 1;
    paint.blendMode = BlendMode.src;
    paint.strokeCap = StrokeCap.square;

    double posY = 0;
    double x2 = size.width - rightPad;

    if(!drawTopLine){
      posY += lineSpace;
    }

    while(posY < size.height){
      canvas.drawLine(Offset(leftPad, posY), Offset(x2, posY), paint);

      posY += lineSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

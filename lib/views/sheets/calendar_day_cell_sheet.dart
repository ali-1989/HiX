import 'package:app/structures/abstract/stateBase.dart';
import 'package:flutter/material.dart';

import 'package:iris_tools/widgets/customCard.dart';

import 'package:app/structures/models/calendarDayModel.dart';
import 'package:app/system/extensions.dart';
import 'package:app/tools/app/appDecoration.dart';
import 'package:app/tools/app/appIcons.dart';
import 'package:app/tools/app/appImages.dart';
import 'package:iris_tools/widgets/icon/circularIcon.dart';

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
class _CalendarDayCellSheetState extends StateBase<CalendarDayCellSheet> {
  ScrollController scrollCtr = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //final theme = Theme.of(context);
    const rr = Radius.circular(15);

    return SizedBox(
      height: sh * 3/4,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(topLeft: rr, topRight: rr),
        child: ColoredBox(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 14),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [

                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset(AppImages.navIco$calendar),
                          const SizedBox(width: 10),

                          Text('26 خرداد 1402'.localeNum()).font(AppDecoration.morabbaFont).fsR(3),
                        ],
                      ),

                      CircularIcon(
                        icon: AppIcons.add,
                        itemColor: AppDecoration.mainColor,
                        backColor: AppDecoration.mainColor.withAlpha(50)
                      )
                      /*Row(
                        children: [
                          Image.asset(AppImages.infoIco, width: 20),
                          const SizedBox(width: 8),
                          Image.asset(AppImages.textIco),
                          const SizedBox(width: 8),
                          Image.asset(AppImages.sexRelationIco),
                          const SizedBox(width: 8),
                          Image.asset(AppImages.supportIco),
                          const SizedBox(width: 8),
                          Image.asset(AppImages.consultationIco),
                        ],
                      )*/
                    ],
                  ),
                ),

                const SizedBox(height: 25),
                Expanded(
                  child: ListView.builder(
                    controller: scrollCtr,
                    //itemExtent: ,
                    scrollDirection: Axis.vertical,
                    itemBuilder: itmBuilder,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget? itmBuilder(BuildContext context, int index) {
    if(index == 0){
      return buildAdviceView();
    }

    if(index == 1){
      return buildSupportView();
    }

    return null;
  }

  Widget buildAdviceView() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      child: CustomCard(
        color: AppDecoration.gray,
        padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.asset(AppImages.infoIco, width: 20, color: Colors.black),
                  const SizedBox(width: 8),
                  const Text('توصیه').font(AppDecoration.morabbaFont).color(Colors.red),
                ],
              ),

              const SizedBox(height: 8),
              const Divider(color: Colors.grey),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: const Text('روز ششم قاعدگی').bold().fsR(-2),
              ),
              const Divider(color: Colors.grey),
              const SizedBox(height: 8),

              const Text('در این روز شما باید تا می‌توانید آب بنوشید زیرا برای سلامتی بدن شما نیاز است').fsR(-1),
            ],
          )
      ),
    );
  }

  Widget buildSupportView() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      child: CustomCard(
        color: AppDecoration.gray,
        padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(AppImages.supportIco, width: 20, color: Colors.black),
                      const SizedBox(width: 8),
                      const Text('مشاوره').font(AppDecoration.morabbaFont).color(AppDecoration.mainColor),
                    ],
                  ),

                  const Icon(AppIcons.dotsVer, size: 16,),
                ],
              ),

              const SizedBox(height: 8),
              Row(
                children: [
                  DecoratedBox(
                    decoration: ShapeDecoration(
                      shape: CircleBorder(side: BorderSide(color: AppDecoration.mainColor, width: 1.5)),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(5.0),
                      child: CircleAvatar(
                        foregroundImage: AssetImage(AppImages.avatar),
                        radius: 22,
                      ),
                    ),
                  ),

                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('مریم صدرزاده').fsR(-1).bold(),
                      const Text('فوق تخصص مامایی').fsR(-1),
                    ],
                  )
                ],
              ),

              const SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('تاریخ و زمان').fsR(-3.0),
                  const Text('1402/05/12  18:30', textDirection: TextDirection.ltr).fsR(-3.0),
                ],
              ),

              const SizedBox(height: 5),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('وضعیت').fsR(-3),
                  const Text('----', textDirection: TextDirection.ltr).fsR(-3),
                ],
              ),

              const SizedBox(height: 5),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('موضوع').fsR(-3),
                  const Text('----', textDirection: TextDirection.ltr,).fsR(-3),
                ],
              ),
            ],
          )
      ),
    );
  }
}

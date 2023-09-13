import 'package:flutter/material.dart';

import 'package:iris_notifier/iris_notifier.dart';
import 'package:iris_tools/modules/stateManagers/assist.dart';
import 'package:iris_tools/widgets/customCard.dart';

import 'package:app/managers/dashboard_manager.dart';
import 'package:app/structures/abstract/state_super.dart';
import 'package:app/structures/enums/app_events.dart';
import 'package:app/structures/models/dashboardNavigateModel.dart';
import 'package:app/system/extensions.dart';
import 'package:app/tools/app/app_decoration.dart';
import 'package:app/views/pages/dashboard/chart_page.dart';
import 'package:app/views/pages/dashboard/dashboard_calendar_page.dart';
import 'package:app/views/pages/dashboard/repetitive_symptoms_page.dart';
import 'package:app/views/pages/dashboard/sex_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State createState() => DashboardPageState();
}
///====================================================================================
class DashboardPageState extends StateSuper<DashboardPage> {
  Color selectColor = const Color(0xff001949);

  @override
  void initState(){
    super.initState();

    EventNotifierService.addListener(AppEvents.dashboardNavigateChange, onNavigateChangeListener);
  }

  @override
  void dispose(){
    EventNotifierService.removeListener(AppEvents.dashboardNavigateChange, onNavigateChangeListener);

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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// vertical rail
          SizedBox(
            width: 65 * pw,
            child: CustomCard(
              color: Colors.white,
              padding: const EdgeInsets.all(8),
              child: Column(
                children: DashboardManager.navigateList.map((e) => buildNavigationItem(e)).toList(),
              ),
            ),
          ),


          const SizedBox(width: 17),

          Expanded(child: pickView()),
        ]
      ),
    );
  }

  Widget buildNavigationItem(DashboardNavigateModel model){
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: (){
        onNavigateItemClick(model);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomCard(
            padding: const EdgeInsets.all(10),
            radius: 10,
            color: model.isSelected? selectColor : AppDecoration.gray,
            child: Image.asset(model.iconAddress, width: 19, color: model.isSelected? Colors.white: selectColor),
          ),

          const SizedBox(height: 10),

          Text(model.title, textAlign: TextAlign.center,)
              .font(AppDecoration.morabbaFont)
              .color(selectColor).fsR(-2),

          Padding(
              padding: const EdgeInsets.symmetric(vertical: 9),
            child: Visibility(
              visible: model != DashboardManager.chartNavigateModel,
              child: SizedBox(
                height: 0.8,
                width: 30,
                child: ColoredBox(
                  color: AppDecoration.mainColor,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void onNavigateItemClick(DashboardNavigateModel model) {
    DashboardManager.selectNavigateItem(model);
  }

  void onNavigateChangeListener({data}) {
    assistCtr.updateHead();
  }

  Widget pickView(){
    if(DashboardManager.chartNavigateModel.isSelected){
      return ChartPage();
    }

    if(DashboardManager.calendarNavigateModel.isSelected){
      return DashboardCalendarPage();
    }

    if(DashboardManager.repetitiveSymptomsNavigateModel.isSelected){
      return RepetitiveSymptomsPage();
    }

    return SexPage();
  }
}

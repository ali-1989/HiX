import 'package:app/views/baseComponents/bottom_navbar_builder.dart';

import 'package:app/views/baseComponents/appbar_builder.dart';
import 'package:flutter/material.dart';

import 'package:iris_notifier/iris_notifier.dart';
import 'package:iris_tools/modules/stateManagers/assist.dart';
import 'package:iris_tools/widgets/page_switcher.dart';

import 'package:app/managers/dashboard_manager.dart';
import 'package:app/managers/layout_manager.dart';
import 'package:app/services/session_service.dart';
import 'package:app/structures/abstract/state_super.dart';
import 'package:app/structures/enums/app_events.dart';
import 'package:app/system/keys.dart';
import 'package:app/tools/app/app_images.dart';
import 'package:app/views/baseComponents/drawer_builder.dart';
import 'package:app/views/baseComponents/layout_scaffold.dart';
import 'package:app/views/pages/calendar_page.dart';
import 'package:app/views/pages/consultant_page/consultation_page.dart';
import 'package:app/views/pages/dashboard_page.dart';
import 'package:app/views/pages/webinar_page.dart';

class LayoutPage extends StatefulWidget {

  LayoutPage({
    Key? key,
  }) : super(key: key);

  @override
  State<LayoutPage> createState() => LayoutPageState();
}
///==================================================================================
class LayoutPageState extends StateSuper<LayoutPage> {
  //Requester requester = Requester();
  PageSwitcherController pageCtr = PageSwitcherController();

  @override
  void initState(){
    super.initState();

    LayoutManager.init();
    DashboardManager.init();
    EventNotifierService.addListener(AppEvents.layoutNavigateChange, onNavigateChangeListener);
  }

  @override
  void dispose(){
    //requester.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Assist(
        controller: assistCtr,
        builder: (context, ctr, data) {
          return Material(
            child: LayoutScaffold(
              key: LayoutManager.layoutScaffoldKey,
              drawer: DrawerMenuBuilder.buildDrawerView(),
              body: SafeArea(child: buildBody()),
            ),
          );
        }
    );
  }

  Widget buildBody(){
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xffE7E1FF), Colors.white],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        image: DecorationImage(image: AssetImage(AppImages.backgroundPlusColored), fit: BoxFit.fill),
      ),
      child: Column(
          mainAxisSize: MainAxisSize.min,
        children: [
          AppbarBuilder(),

          SizedBox(height: 10 * hr),

          Expanded(
            child: SingleChildScrollView(
              child: PageSwitcher(
                controller: pageCtr,
                pages: [
                  DashboardPage(),
                  CalendarPage(),
                  WebinarPage(),
                  ConsultationPage(),
                ]
              ),
            ),
          ),

          BottomNavbarBuilder(),
        ],
      ),
    );
  }

  void requestData() async {
    final js = <String, dynamic>{};
    js[Keys.requesterId] = SessionService.getLastLoginUser()?.userId;

    //requester.httpRequestEvents.onFailState = (req, r) async {

   // };

    //requester.httpRequestEvents.onStatusOk = (req, data) async {



      //assistCtr.addStateAndUpdateHead('');
   // };

    //requester.bodyJson = js;

    //requester.request(context);
  }

  void onNavigateChangeListener({data}) {
    if(LayoutManager.currentPage().index != pageCtr.index){
      pageCtr.changePageTo(LayoutManager.currentPage().index);
    }

    assistCtr.updateHead();
  }
}

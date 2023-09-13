import 'package:flutter/material.dart';

import 'package:iris_notifier/iris_notifier.dart';
import 'package:iris_tools/modules/stateManagers/assist.dart';
import 'package:iris_tools/widgets/customCard.dart';
import 'package:iris_tools/widgets/page_switcher.dart';

import 'package:app/managers/dashboard_manager.dart';
import 'package:app/managers/layout_manager.dart';
import 'package:app/services/session_service.dart';
import 'package:app/structures/abstract/state_super.dart';
import 'package:app/structures/enums/app_events.dart';
import 'package:app/structures/models/layoutNavigateModel.dart';
import 'package:app/system/extensions.dart';
import 'package:app/system/keys.dart';
import 'package:app/tools/app/app_decoration.dart';
import 'package:app/tools/app/app_icons.dart';
import 'package:app/tools/app/app_images.dart';
import 'package:app/tools/route_tools.dart';
import 'package:app/views/baseComponents/drawerMenuBuilder.dart';
import 'package:app/views/baseComponents/layoutScaffold.dart';
import 'package:app/views/pages/calendar_page.dart';
import 'package:app/views/pages/consultant_page/consultation_page.dart';
import 'package:app/views/pages/dashboard_page.dart';
import 'package:app/views/pages/notification_page.dart';
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
              drawer: DrawerMenuBuilder.buildDrawer(),
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
          SizedBox(height: 15 * pw),
          buildMenuKeySection(),

          //SizedBox(height: 30 * pw),
          //buildNavigationSection(),

          SizedBox(height: 10 * pw),

          Expanded(
            child: SingleChildScrollView(
              child: PageSwitcher(
                controller: pageCtr,
                pages: [
                  const DashboardPage(),
                  const CalendarPage(),
                  const WebinarPage(),
                  const ConsultationPage(),
                ]
              ),
            ),
          ),

          buildNavigationSection(),
        ],
      ),
    );
  }

  Widget buildMenuKeySection(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(right: 20 * pw),
              child: GestureDetector(
                onTap: (){
                  LayoutManager.toggleDrawer();
                },
                child: CustomCard(
                  padding: const EdgeInsets.all(4),
                    color: Colors.white,
                    child: Icon(AppIcons.menu3Line, color: AppDecoration.mainColor,).alpha()
                ),
              ),
            ),

            const SizedBox(width: 10),

            Image.asset(AppImages.hiX, width: 30)
          ],
        ),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 13.0 * pw),
          child: Row(
            children: [
              GestureDetector(
                onTap: gotoNotificationPage,
                child: CustomCard(
                  radius: 8,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Image.asset(AppImages.notificationIco, color: Colors.black, width: 20, height: 20),
                    )
                ),
              ),

              const SizedBox(width: 5),

              const Padding(
                padding: EdgeInsets.all(5.0),
                child: CircleAvatar(
                  foregroundImage: AssetImage(AppImages.avatar),
                  radius: 17,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildNavigationSection(){
    return DecoratedBox(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(color: Colors.black38, offset: Offset(0, 3), blurStyle: BlurStyle.outer, spreadRadius: 0, blurRadius: 4)
        ]
      ),
      child: ColoredBox(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 35.0 * pw),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: LayoutManager.navigateList.map((e) => buildNavigationItem(e)).toList(),
          ),
        ),
      ),
    );
  }

  Widget buildNavigationItem(LayoutNavigateModel model){
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: (){
        onNavigateItemClick(model);
      },
      child:Column(
        children: [
          const SizedBox(height: 6),
          
          Image.asset(model.iconAddress, width: 20, color: model.isSelected? AppDecoration.mainColor: Colors.black),

          const SizedBox(height: 6),

          Text(model.title)
              .font(AppDecoration.morabbaFont).fsR(-2)
              .color(model.isSelected? AppDecoration.mainColor : Colors.black),

          const SizedBox(height: 10),
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

  void onNavigateItemClick(LayoutNavigateModel model) {
    LayoutManager.selectNavigateItem(model);
  }

  void onNavigateChangeListener({data}) {
    if(LayoutManager.currentPage().index != pageCtr.index){
      pageCtr.changePageTo(LayoutManager.currentPage().index);
    }

    assistCtr.updateHead();
  }

  void gotoNotificationPage() {
    RouteTools.pushPage(context, NotificationPage());
  }
}

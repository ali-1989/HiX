import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:iris_notifier/iris_notifier.dart';
import 'package:iris_tools/modules/stateManagers/assist.dart';
import 'package:iris_tools/widgets/customCard.dart';
import 'package:iris_tools/widgets/icon/circularIcon.dart';
import 'package:iris_tools/widgets/page_switcher.dart';

import 'package:app/managers/dashboard_manager.dart';
import 'package:app/managers/layout_manager.dart';
import 'package:app/pages/calendar_page.dart';
import 'package:app/pages/consultation_page.dart';
import 'package:app/pages/dashboard_page.dart';
import 'package:app/pages/notification_page.dart';
import 'package:app/pages/webinar_page.dart';
import 'package:app/services/session_service.dart';
import 'package:app/structures/abstract/stateBase.dart';
import 'package:app/structures/enums/appEvents.dart';
import 'package:app/structures/models/layoutNavigateModel.dart';
import 'package:app/system/extensions.dart';
import 'package:app/system/keys.dart';
import 'package:app/tools/app/appDecoration.dart';
import 'package:app/tools/app/appIcons.dart';
import 'package:app/tools/app/appImages.dart';
import 'package:app/tools/dateTools.dart';
import 'package:app/views/baseComponents/drawerMenuBuilder.dart';
import 'package:app/views/baseComponents/layoutScaffold.dart';
import 'package:app/views/widgets/my_divider.dart';

class LayoutPage extends StatefulWidget {

  LayoutPage({
    Key? key,
  }) : super(key: key);

  @override
  State<LayoutPage> createState() => LayoutPageState();
}
///==================================================================================
class LayoutPageState extends StateBase<LayoutPage> {
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
                  NotificationPage(),
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
              CustomCard(
                radius: 8,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Image.asset(AppImages.notificationIco, color: Colors.black, width: 20, height: 20),
                  )
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
    return ColoredBox(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 35.0 * pw),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: LayoutManager.navigateList.map((e) => buildNavigationItem(e)).toList(),
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
}

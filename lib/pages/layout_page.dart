import 'package:app/managers/layout_manager.dart';
import 'package:app/structures/enums/appEvents.dart';
import 'package:app/structures/models/layoutNavigateModel.dart';
import 'package:app/system/extensions.dart';
import 'package:app/tools/app/appDecoration.dart';
import 'package:app/tools/app/appIcons.dart';
import 'package:app/tools/app/appImages.dart';
import 'package:app/views/baseComponents/drawerMenuBuilder.dart';
import 'package:app/views/baseComponents/layoutScaffold.dart';
import 'package:app/views/widgets/my_divider.dart';
import 'package:flutter/material.dart';
import 'package:iris_notifier/iris_notifier.dart';

import 'package:iris_tools/modules/stateManagers/assist.dart';

import 'package:app/services/session_service.dart';
import 'package:app/structures/abstract/stateBase.dart';
import 'package:app/system/keys.dart';
import 'package:iris_tools/widgets/customCard.dart';
import 'package:iris_tools/widgets/icon/circularIcon.dart';

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
  PageController pageController = PageController(initialPage: 0);

  @override
  void initState(){
    super.initState();

    LayoutManager.init();
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
          return LayoutScaffold(
            drawer: DrawerMenuBuilder.buildDrawer(),
            body: Material(
              child: SafeArea(child: buildBody()),
            ),
          );
        }
    );
  }

  Widget buildBody(){
    return SizedBox.expand(
      child: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xffE7E1FF), Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          image: DecorationImage(image: AssetImage(AppImages.backgroundPlusColored), ),
        ),
        child: Column(
          children: [
            SizedBox(height: 15 * pw),
            buildMenuKeySection(),

            SizedBox(height: 15 * pw),
            buildAvatarSection(),

            SizedBox(height: 30 * pw),
            buildNavigationSection(),

            SizedBox(height: 30 * pw),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.0 * pw),
              child: const MyDivider(),
            ),
            SizedBox(height: 10 * pw),

            Expanded(
                child: PageView(
                  controller: pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [

                  ],
                )
            )
          ],
        ),
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
                  LayoutScaffoldState.toggleDrawer();
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
          padding: EdgeInsets.symmetric(horizontal: 17.0 * pw),
          child: CustomCard(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
              color: Colors.white,
              child: Row(
                children: [
                  Image.asset(AppImages.calendarIcon, width: 14),
                  const SizedBox(width: 6),
                  Text('امروز:  1 خرداد 1402'.localeNum()).fsR(-1),
                ],
              )
          ),
        ),
      ],
    );
  }

  Widget buildAvatarSection(){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 17.0 * pw),
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /// avatar
          DecoratedBox(
            decoration: ShapeDecoration(
              shape: CircleBorder(side: BorderSide(color: AppDecoration.mainColor, width: 1.5)),
            ),
            child: const Padding(
              padding: EdgeInsets.all(5.0),
              child: CircleAvatar(
                foregroundImage: AssetImage(AppImages.avatar),
                radius: 30,
              ),
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// name
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(AppImages.userIco,),
                        const SizedBox(width: 3),
                        const Text('سمیرا حسن پور').bold(),
                      ],
                    ),

                    const SizedBox(height: 14),
                    const Text('تاریخ تولد:').fsR(-2),
                  ],
                ),

                Column(
                  children: [
                    Row(
                      children: [
                        RotatedBox(
                          quarterTurns: 2,
                          child: CircularIcon(
                            backColor: AppDecoration.mainColor,
                            icon: AppIcons.arrowDown,
                            size: 20,
                          ),
                        ),

                        const SizedBox(width: 5),

                        CustomCard(
                          radius: 14,
                          padding: const EdgeInsets.fromLTRB(7, 2, 7, 3),
                          child: const Text('کاربر عادی').color(AppDecoration.mainColor).font(AppDecoration.morabbaFont).fsR(-3),
                        ).wrapBoxBorder(
                          padding: const EdgeInsets.all(1),
                          radius: 14
                        ),
                      ],
                    ),

                    const SizedBox(height: 14),
                    Text('1300/12/12'.localeNum()).bold().fsR(-2),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildNavigationSection(){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0 * pw),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: LayoutManager.navigateList.map((e) => buildNavigationItem(e)).toList(),
      ),
    );
  }

  Widget buildNavigationItem(LayoutNavigateModel model){
    return Column(
      children: [
        GestureDetector(
          onTap: (){
            onNavigateItemClick(model);
          },
          child: CustomCard(
            padding: const EdgeInsets.all(1.2),
              radius: 17,
              color: Colors.white,
              child: CustomCard(
                padding: const EdgeInsets.all(12),
                radius: 17,
                color: model.isSelected? AppDecoration.mainColor : Colors.white,
                child: Image.asset(model.iconAddress, width: 24, color: model.isSelected? Colors.white: Colors.black),
              )
          ),
        ),

        const SizedBox(height: 15),

        Text(model.title)
            .font(AppDecoration.morabbaFont)
            .color(model.isSelected? AppDecoration.mainColor : Colors.black),

        const SizedBox(height: 10),

        ClipRRect(
          borderRadius: BorderRadius.circular(2),
          child: SizedBox(
            height: 4,
            width: 20,
            child: ColoredBox(
              color: model.isSelected? AppDecoration.mainColor : AppDecoration.mainColor.withAlpha(30),
            ),
          ),
        )
      ],
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
    assistCtr.updateHead();
  }
}

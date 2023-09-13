import 'package:flutter/material.dart';

import 'package:iris_tools/api/generator.dart';
import 'package:iris_tools/api/system.dart';
import 'package:iris_tools/modules/stateManagers/assist.dart';
import 'package:iris_tools/widgets/circle.dart';
import 'package:iris_tools/widgets/customCard.dart';

import 'package:app/services/session_service.dart';
import 'package:app/structures/abstract/state_super.dart';
import 'package:app/structures/middleWares/requester.dart';
import 'package:app/structures/models/notificationModel.dart';
import 'package:app/system/extensions.dart';
import 'package:app/system/keys.dart';
import 'package:app/tools/app/app_decoration.dart';
import 'package:app/tools/app/app_images.dart';
import 'package:app/tools/app/app_sheet.dart';
import 'package:app/tools/date_tools.dart';
import 'package:app/views/components/backBtn.dart';
import 'package:app/views/components/my_sheet_layout.dart';

class NotificationPage extends StatefulWidget {

  NotificationPage({
    Key? key,
  }) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}
///==================================================================================
class _NotificationPageState extends StateSuper<NotificationPage> {
  Requester requester = Requester();
  List<NotificationModel> list = [];

  @override
  void initState(){
    super.initState();

    //requestData();

    addItem();
  }

  @override
  void dispose(){
    requester.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Assist(
        controller: assistCtr,
        builder: (context, ctr, data) {
          return Scaffold(
            body: buildBody(),
          );
        }
    );
  }

  Widget buildBody(){
    return Builder(
      builder: (context) {
        /*if(isInFetchData) {
          return WaitToLoad();
        }*/

        return Column(
          children: [
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: buildTopSection(),
            ),

            Expanded(
                child: buildNotificationList()
            )
          ],
        );
      }
    );
  }

  Widget buildTopSection() {
    return const Row(
      children: [

      ],
    );
  }

  Widget buildNotificationList() {
    if(list.isEmpty){
      return Center(
        child: CustomCard(
          padding: const EdgeInsets.all(7),
          color: AppDecoration.mainColor,
          child: const Text('اعلانی وجود ندارد').fsR(-3).color(Colors.white).boldFont(),
        ),
      );
    }

    return Column(
      children: [
        const SizedBox(height: 15),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Row(
                children: [
                  //Image.asset(AppImages.notificationIco),
                  const Circle(color: Colors.red, size: 9),
                  const SizedBox(width: 5),

                  const Text('اعلانات').font(AppDecoration.morabbaFont).fsR(2.5),
                ],
              ),
            ),

            const BackBtn(),
          ],
        ),

        const SizedBox(height: 10),

        Expanded(
          child: ListView.builder(
              itemCount: list.length +1,
              shrinkWrap: true,
              padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
              itemBuilder: itemBuilder
          ),
        ),
      ],
    );
  }

  Widget? itemBuilder(BuildContext context, int index) {
    if(index == list.length){
      return GestureDetector(
        onTap: onMoreItemClick,
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
          child: Center(child: const Text('موارد بیشتر').color(Colors.blue).boldFont()),
        ),
      );
    }

    final itm = list[index];

    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Column(
        children: [
          GestureDetector(
            onTap: (){
              onTitleClick(itm);
            },
            child: CustomCard(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              radius: 12,
              color: AppDecoration.gray,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(itm.title).boldFont().fsR(-1),
                ],
              ),
            ),
          ),

          const SizedBox(height: 7),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(DateTools.hmAndDateRelative(itm.date)).fsR(-2),

              const SizedBox(width: 6),
              TickCheck(
                  isSelected: itm.isSeen,
                  //onChanged: (v){}
              ),
            ],
          )
        ],
      ),
    );
  }

  void requestData() async {
    final js = <String, dynamic>{};
    js[Keys.requesterId] = SessionService.getLastLoginUser()?.userId;

    requester.httpRequestEvents.onFailState = (req, r) async {

    };

    requester.httpRequestEvents.onStatusOk = (req, data) async {



      assistCtr.addStateAndUpdateHead('');
    };

    requester.bodyJson = js;

    requester.request(context);
  }

  void addItem() {
    List.generate(10, (index) {
      final t = NotificationModel();
      t.title = Generator.getRandomFrom(['حواست باشه فردا دوره قاعدگیت شروع میشه', 'پولت برگشت داده شد']);
      t.description = Generator.getRandomFrom(['حواست باشه فردا دوره قاعدگیت شروع میشه', 'پولت برگشت داده شد']);
      t.isSeen = Generator.getRandomFrom([true, false]);
      t.date = DateTime.now();

      list.add(t);
    });
  }

  void onMoreItemClick() async {
    showLoading();
    await System.wait(const Duration(milliseconds: 1500));

    addItem();
    await hideLoading();
    assistCtr.updateHead();
  }

  void onTitleClick(NotificationModel itm) {
    Widget b(_){
      return MySheetLayout(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: Text(itm.title, maxLines: 1).bold().fsR(-2).fitWidthOverflow(minOfFontSize: 12)),
                  const SizedBox(width: 15),
                  Text(DateTools.hmAndDateRelative(itm.date)).fsR(-3.5),
                ],
              ),

              const SizedBox(height: 20),
              Text(itm.description).fsR(-3),
            ],
          ),
        ),
      );
    }

    AppSheet.showSheetCustom(
      context,
      builder: b,
      contentColor: Colors.transparent,
      routeName: 'onNotificationTitleClick',
      isScrollControlled: true,
    );
  }
}
///==============================================================================
class TickCheck extends StatelessWidget {
  final bool isSelected;

  const TickCheck({Key? key, required this.isSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color activeColor = AppDecoration.mainColor;
    Color deActiveColor = Colors.grey.shade300;

    return CustomCard(
      padding: const EdgeInsets.all(7),
        radius: 5,
        color: isSelected? activeColor : deActiveColor,
        child: Image.asset(AppImages.tickIco,
            width: 8,
            height: 8,
            color: isSelected? Colors.white : Colors.black,
        ),
    );
  }
}



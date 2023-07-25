import 'package:flutter/material.dart';

import 'package:iris_tools/api/generator.dart';
import 'package:iris_tools/api/system.dart';
import 'package:iris_tools/modules/stateManagers/assist.dart';
import 'package:iris_tools/widgets/circle.dart';
import 'package:iris_tools/widgets/customCard.dart';

import 'package:app/services/session_service.dart';
import 'package:app/structures/abstract/stateBase.dart';
import 'package:app/structures/middleWares/requester.dart';
import 'package:app/structures/models/notificationModel.dart';
import 'package:app/system/extensions.dart';
import 'package:app/system/keys.dart';
import 'package:app/tools/app/appDecoration.dart';
import 'package:app/tools/app/appImages.dart';
import 'package:app/tools/dateTools.dart';

class NotificationPage extends StatefulWidget {

  NotificationPage({
    Key? key,
  }) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}
///==================================================================================
class _NotificationPageState extends StateBase<NotificationPage> {
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
          return buildBody();
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

            buildNotificationList()
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

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: CustomCard(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        radius: 14,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    //Image.asset(AppImages.notificationIco),
                    const Circle(color: Colors.red, size: 9),
                    const SizedBox(width: 5),

                    const Text('اعلانات شما').font(AppDecoration.morabbaFont).fsR(2.5),
                  ],
                ),
              ],
            ),

            ListView.builder(
                itemCount: list.length +1,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.only(top: 10),
                itemBuilder: itemBuilder
            ),
          ],
        ),
      ),
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
          CustomCard(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            radius: 12,
            color: AppDecoration.gray,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(itm.description).boldFont().fsR(-1),
              ],
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



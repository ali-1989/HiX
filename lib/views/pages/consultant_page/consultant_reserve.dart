import 'package:flutter/material.dart';

import 'package:iris_tools/api/generator.dart';
import 'package:iris_tools/widgets/custom_card.dart';

import 'package:app/structures/abstract/state_super.dart';
import 'package:app/structures/models/consultant_model.dart';
import 'package:app/system/extensions.dart';
import 'package:app/tools/app/app_decoration.dart';
import 'package:app/tools/app/app_icons.dart';
import 'package:app/tools/app/app_images.dart';
import 'package:app/tools/route_tools.dart';
import 'package:app/views/pages/consultant_page/consultant_more_info.dart';
import 'package:app/views/pages/consultant_page/consultant_reserving_page.dart';

class ConsultantReserve extends StatefulWidget {

  const ConsultantReserve({
    Key? key,
  }) : super(key: key);

  @override
  State createState() => _ConsultantReserveState();
}
///=========================================================================================
class _ConsultantReserveState extends StateSuper<ConsultantReserve> {
  List<ConsultantModel> consultantList = [];

  @override
  void initState(){
    super.initState();

    for(int i=0; i < 20; i++){
      ConsultantModel mm = ConsultantModel();
      mm.id = Generator.generateKey(5);
      mm.name = Generator.getRandomFrom(['علی باقری', 'حسینعلی عدیلی']);
      mm.positionTitle = Generator.getRandomFrom(['روان پزشک', 'روانشناس']);
      mm.doctorNumber = Generator.getRandomInt(2221111, 9999999).toString();
      mm.countOfConsultation = Generator.getRandomInt(0, 50);
      mm.isBookmark = Generator.randomBool();

      consultantList.add(mm);
    }
  }

  @override
  Widget build(BuildContext context) {
    return buildBody();
  }

  Widget buildBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('لیست مشاوران').font(AppDecoration.morabbaFont).fsR(2),

        searchBarBuilder(),

        ListView.builder(
            itemCount: consultantList.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: itemBuilder
        )
      ],
    );
  }

  Widget? itemBuilder(BuildContext context, int index) {
    final itm = consultantList[index];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: CustomCard(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal:14, vertical: 14),
            child: Column(
              children: [

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 20,
                          foregroundImage: AssetImage(AppImages.avatar),
                          //child: Image.network(itm.consultant.avatar?.fileLocation?? ''),
                        ),

                        const SizedBox(width: 10),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(itm.name).bold(),
                            Text(itm.positionTitle),
                          ],
                        ),
                      ],
                    ),

                    Icon(itm.isBookmark ? AppIcons.bookmarkSolid : AppIcons.bookmark,
                      color: itm.isBookmark? AppDecoration.mainColor: Colors.black,
                    ),
                  ],
                ),

                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('شماره نظام پزشکی'),

                    Text(itm.doctorNumber).bold(),
                  ],
                ),

                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('تعداد مشاوره'),

                    Text('${itm.countOfConsultation}')
                  ],
                ),

                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('نظرات و رتبه'),

                    Row(
                      textDirection: TextDirection.ltr,
                      children: [
                        Image.asset(AppImages.starIco, height: 17),
                        const Text('3.5 ').bold().fsR(-1),

                        const SizedBox(width: 10),
                        Image.asset(AppImages.commentIco),
                        const Text('25 '),
                      ],
                    )
                  ],
                ),

                /// buttons
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppDecoration.mainColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(color: AppDecoration.mainColor, style: BorderStyle.solid),
                          ),
                          side: BorderSide(color: AppDecoration.mainColor, style: BorderStyle.solid),
                        ),
                          onPressed: (){
                            onMoreInfoClick(itm);
                          },
                          child: const Text('اطلاعات بیشتر').fsR(-1)
                      ),
                    ),

                    const SizedBox(width: 10),

                    Expanded(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.zero
                          ),
                          onPressed: (){
                            onReserveInfoClick(itm);
                          },
                          child: const Text('رزرو نوبت').fsR(-1)
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
      ),
    );
  }

  Widget searchBarBuilder() {
    return Row(
      children: [
        Image.asset(AppImages.searchIco),

        const SizedBox(width: 10),
        Expanded(
            child: TextField(
              decoration: AppDecoration.noneBordersInputDecoration.copyWith(
                  hintText: 'جستجو در بین  مشاوران...',
                  hintStyle: TextStyle(color: Colors.grey.shade600, fontSize: AppDecoration.fontSizeRelative(-2.2))
              ),
            )
        ),

        Image.asset(AppImages.filteringIco, width: 20)
            .wrapBoxBorder(
            padding: const EdgeInsets.all(7),
            color: Colors.black,
            radius: 9,
            alpha: 80
        ),
      ],
    );
  }

  void onReserveClick(ConsultantModel itm) {}

  void onMoreInfoClick(ConsultantModel itm) {
    RouteTools.pushPage(context, const ConsultantMoreInfo());
  }

  void onReserveInfoClick(ConsultantModel itm) {
    RouteTools.pushPage(context, const ConsultantReservingPage());
  }
}

import 'package:app/structures/abstract/stateBase.dart';
import 'package:app/structures/models/consultant_model.dart';
import 'package:app/system/extensions.dart';
import 'package:app/tools/app/appDecoration.dart';
import 'package:app/tools/app/appIcons.dart';
import 'package:app/tools/app/appImages.dart';
import 'package:flutter/material.dart';
import 'package:iris_tools/api/generator.dart';
import 'package:iris_tools/widgets/circle.dart';
import 'package:iris_tools/widgets/customCard.dart';

class ConsultantReserve extends StatefulWidget {

  const ConsultantReserve({
    Key? key,
  }) : super(key: key);

  @override
  State createState() => _ConsultantReserveState();
}
///=========================================================================================
class _ConsultantReserveState extends StateBase<ConsultantReserve> {
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
      children: [
        const SizedBox(height: 20),
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
                    const Text('تعداد مشاوره'),

                    Text('${itm.countOfConsultation}')
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
                            onReserveClick(itm);
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
                            onReserveClick(itm);
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
}

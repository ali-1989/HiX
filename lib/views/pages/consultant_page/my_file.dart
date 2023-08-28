import 'package:app/structures/abstract/stateBase.dart';
import 'package:app/structures/enums/consultant_meeting_status.dart';
import 'package:app/structures/models/consultant_for_meeting_model.dart';
import 'package:app/structures/models/meeting_model.dart';
import 'package:app/system/extensions.dart';
import 'package:app/tools/app/appDecoration.dart';
import 'package:app/tools/app/appIcons.dart';
import 'package:app/tools/app/appImages.dart';
import 'package:app/tools/dateTools.dart';
import 'package:flutter/material.dart';
import 'package:iris_tools/api/generator.dart';
import 'package:iris_tools/widgets/circle.dart';
import 'package:iris_tools/widgets/customCard.dart';

class MyFile extends StatefulWidget {

  const MyFile({
    Key? key,
  }) : super(key: key);

  @override
  State createState() => _MyFileState();
}
///=========================================================================================
class _MyFileState extends StateBase<MyFile> {
  List<MeetingModel> meetingList = [];

  @override
  void initState(){
    super.initState();

    final c1 = ConsultantForMeetingModel();
    c1.id = Generator.generateKey(5);
    c1.name = Generator.getRandomFrom(['علی باقری', 'حسینعلی عدیلی']);
    c1.positionTitle = Generator.getRandomFrom(['روان پزشک', 'روانشناس']);

    final c2 = ConsultantForMeetingModel();
    c2.id = Generator.generateKey(5);
    c2.name = Generator.getRandomFrom(['مهناز باقری', 'حسینعلی هاشمی']);
    c2.positionTitle = Generator.getRandomFrom(['روان پزشک', 'الاف بی کار']);

    for(int i=0; i < 20; i++){
      MeetingModel mm = MeetingModel();
      mm.date = DateTime.now();
      mm.title = Generator.getRandomFrom(['چگونه همسرم را بکشم', 'چرا دوستم ندارد']);
      mm.id = Generator.generateKey(5);
      mm.status = ConsultantMeetingStatus.from(Generator.getRandomInt(1, 3));
      mm.consultant = Generator.getRandomFrom([c1, c2]);

      meetingList.add(mm);
    }
  }

  @override
  Widget build(BuildContext context) {
    return buildBody();
  }

  Widget buildBody() {
    return Column(
      children: [
        buildHeader(),

        const SizedBox(height: 20),
        const Text('جلسات').font(AppDecoration.morabbaFont).fsR(2),

        searchBarBuilder(),

        ListView.builder(
            itemCount: meetingList.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: itemBuilder
        )
      ],
    );
  }

  Widget buildHeader(){
    return CustomCard(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('قرارهای ملاقات').font(AppDecoration.morabbaFont),
              ],
            ),

            const SizedBox(height: 20),

            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      SizedBox(
                        width: 85,
                        child: CustomCard(
                          color: AppDecoration.gray,
                          child: Center(
                            child: Column(
                              children: [
                                const SizedBox(height: 12),
                                const Text('مانده').fsR(-4.5).bold(),
                                const SizedBox(height: 5),
                                const Text('2').bold().fsR(2),
                                const SizedBox(height: 12),
                              ],
                            ),
                          ),
                        ),
                      ),

                      const Positioned(
                          bottom: 5,
                          right: 5,
                          child: Circle(
                            color: Colors.orange,
                            size: 7,
                          )
                      ),
                    ],
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: SizedBox(
                        height: double.infinity,
                        child: VerticalDivider(
                            color: AppDecoration.gray,
                            width: 2,
                            thickness: 2,
                            indent: 14, endIndent: 14
                        )
                    ),
                  ),

                  Stack(
                    children: [
                      SizedBox(
                        width: 85,
                        child: CustomCard(
                          color: AppDecoration.gray,
                          child: Center(
                            child: Column(
                              children: [
                                const SizedBox(height: 12),
                                const Text('اتمام یافته').fsR(-4.5).bold(),
                                const SizedBox(height: 5),
                                const Text('2').bold().fsR(2),
                                const SizedBox(height: 12),
                              ],
                            ),
                          ),
                        ),
                      ),

                      const Positioned(
                          bottom: 5,
                          right: 5,
                          child: Circle(
                            color: Colors.red,
                            size: 7,
                          )
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
            /* CustomCard(
              color: AppDecoration.gray,
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 14,
                        child: Image.asset(AppImages.avatar),
                      ),

                      const SizedBox(width: 10),
                      Column(
                        children: [
                          const Text('قرارهای ملاقات'),
                          const Text('قرارهای ملاقات'),
                        ],
                      ),
                    ],
                  ),

                  Icon(AppIcons.lastSeenClock, size: 15,),
                ],
              ),
            ),*/
          ],
        )
    );
  }

  Widget? itemBuilder(BuildContext context, int index) {
    final itm = meetingList[index];

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
                        Image.asset(AppImages.pointIco),
                        const SizedBox(width: 8),
                        Text(itm.title)
                      ],
                    ),

                    Row(
                      children: [
                        Image.asset(AppImages.noteIco, scale: 1.2),
                        const SizedBox(width: 12),
                        Image.asset(AppImages.starIco, scale: 1.2),
                        const SizedBox(width: 12),
                        const Icon(AppIcons.dotsVer, size: 18, color: Colors.black87)
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 8),
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
                        Text(itm.consultant.name).bold(),
                        Text(itm.consultant.positionTitle),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('وضعیت'),

                    Row(
                      children: [
                        Circle(
                          size: 6 * pw,
                          color: Colors.green,
                        ),

                        Text(itm.status.getHumanMessage())
                      ],
                    )
                  ],
                ),

                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('تاریخ جلسه'),

                    Row(
                      children: [
                        Text('  ${DateTools.hmOnlyRelative(itm.date)}  ').bold(),
                        Text(DateTools.dateOnlyRelative(itm.date)),
                      ],
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
                  hintText: 'جستجو در بین  جلسات ملاقات...',
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
}

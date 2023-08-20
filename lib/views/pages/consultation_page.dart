import 'package:app/structures/models/meetingModel.dart';
import 'package:app/system/extensions.dart';
import 'package:app/tools/app/appDecoration.dart';
import 'package:app/tools/app/appIcons.dart';
import 'package:app/tools/app/appImages.dart';
import 'package:flutter/material.dart';
import 'package:iris_tools/api/generator.dart';

import 'package:iris_tools/modules/stateManagers/assist.dart';

import 'package:app/structures/abstract/stateBase.dart';
import 'package:iris_tools/widgets/circle.dart';
import 'package:iris_tools/widgets/customCard.dart';

class ConsultationPage extends StatefulWidget {
  const ConsultationPage({Key? key}) : super(key: key);

  @override
  State createState() => ConsultationPageState();
}
///====================================================================================
class ConsultationPageState extends StateBase<ConsultationPage> {
  int currentTabIndex = 0;
  List<MeetingModel> meetingList = [];

  @override
  void initState(){
    super.initState();

    final c = ConsultantMeetingModel();
    c.id = Generator.generateKey(5);
    c.name = Generator.generateName(5);
    c.positionTitle = Generator.generateName(5);

    for(int i=0; i < 20; i++){
      MeetingModel mm = MeetingModel();
      mm.date = DateTime.now();
      mm.title = Generator.generateName(14);
      mm.id = Generator.generateKey(5);
      mm.state = 1;
      mm.consultant = c;

      meetingList.add(mm);
    }
  }

  @override
  void dispose(){
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
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(0),
                        backgroundColor: currentTabIndex == 0? null : Colors.white,
                        foregroundColor: currentTabIndex == 0? null : Colors.black,
                      ),
                      onPressed: (){
                        onTabClick(0);
                      },
                      child: const Text('پرونده من')
                  ),
                ),

                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(0),
                        backgroundColor: currentTabIndex == 1? null : Colors.white,
                        foregroundColor: currentTabIndex == 1? null : Colors.black,
                      ),
                      onPressed: (){
                        onTabClick(1);
                      },
                      child: const Text('رزرو مشاوره')
                  ),
                ),

                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(0),
                        backgroundColor: currentTabIndex == 2? null : Colors.white,
                        foregroundColor: currentTabIndex == 2? null : Colors.black,
                      ),
                      onPressed: (){
                        onTabClick(2);
                      },
                      child: const Text('مدارک پزشکی')
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),
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
          ]
        ),
      ),
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

  void onTabClick(int index) {
    currentTabIndex = index;
    assistCtr.updateHead();
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
                        Icon(AppIcons.dotsVer, size: 20,)
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

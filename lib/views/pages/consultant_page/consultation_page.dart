import 'package:flutter/material.dart';

import 'package:iris_tools/modules/stateManagers/assist.dart';
import 'package:iris_tools/widgets/page_switcher.dart';

import 'package:app/structures/abstract/state_super.dart';
import 'package:app/views/pages/consultant_page/consultant_reserve.dart';
import 'package:app/views/pages/consultant_page/medicine_docs.dart';
import 'package:app/views/pages/consultant_page/my_file.dart';

class ConsultationPage extends StatefulWidget {
  const ConsultationPage({Key? key}) : super(key: key);

  @override
  State createState() => ConsultationPageState();
}
///====================================================================================
class ConsultationPageState extends StateSuper<ConsultationPage> {
  int currentTabIndex = 0;
  PageSwitcherController pageSwitcherCtr = PageSwitcherController();

  @override
  void initState(){
    super.initState();
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

            PageSwitcher(
                controller: pageSwitcherCtr,
                // ignore: prefer_const_literals_to_create_immutables
                pages: [
                  // ignore: prefer_const_constructors
                  MyFile(),
                  ConsultantReserve(),
                  MedicineDocuments()
                ]
            ),
          ]
        ),
      ),
    );
  }

  void onTabClick(int index) {
    currentTabIndex = index;
    pageSwitcherCtr.changePageTo(index);

    assistCtr.updateHead();
  }
}

import 'package:flutter/material.dart';

import 'package:file_sizes/file_sizes.dart';
import 'package:iris_tools/modules/stateManagers/assist.dart';
import 'package:iris_tools/widgets/custom_card.dart';
import 'package:iris_tools/widgets/optionsRow/checkRow.dart';

import 'package:app/structures/abstract/state_super.dart';
import 'package:app/system/extensions.dart';
import 'package:app/tools/app/app_decoration.dart';
import 'package:app/tools/app/app_icons.dart';
import 'package:app/tools/app/app_images.dart';

class ConsultantReservingPage extends StatefulWidget {
  const ConsultantReservingPage({Key? key}) : super(key: key);

  @override
  State<ConsultantReservingPage> createState() => _ConsultantReservingPageState();
}
///====================================================================================
class _ConsultantReservingPageState extends StateSuper<ConsultantReservingPage> {

  @override
  void initState(){
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Assist(
      isHead: true,
      controller: assistCtr,
      builder: (_, ctr, data) {
        return Scaffold(
          body: Column(
            children: [
              const SizedBox(height: 30),
              buildAvatarSection(),

              buildNameSection(),

              buildDegreeOfEducationSection(),

              const SizedBox(height: 8),

              Expanded(
                  child: CustomScrollView(
                    slivers: [
                      buildSliver1(),
                      buildSliver2(),
                    ],
                  ),
              ),

              const SizedBox(height: 20),
              SizedBox(
                width: ws -40,
                child: ElevatedButton.icon(
                    onPressed: null,//onRegisterClick,
                    icon: Image.asset(AppImages.registerReserveIco),
                    label: Text('ثبت نوبت')
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      }
    );
  }

  Widget buildAvatarSection() {
    return const CircleAvatar(
      backgroundImage: AssetImage(AppImages.avatar),
      radius: 30,
    );
  }

  Widget buildNameSection() {
    return const Text('مهناز حسینی').bold();
  }

  Widget buildDegreeOfEducationSection() {
    return const Text('متخصص زنان و زایمان').thinFont();
  }

  Widget buildAccessSection() {
    return Chip(
      label: const Text('دردسترس',).thinFont(),
      backgroundColor: Colors.green,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      labelPadding: EdgeInsets.zero,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
    );
  }

  Widget buildTitleSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('موضوع').bold().font(AppDecoration.morabbaFont),

          const SizedBox(height: 6),
          CustomCard(
            color: AppDecoration.gray,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            child: TextField(
              maxLines: 1,
              decoration: AppDecoration.noneBordersInputDecoration.copyWith(
                isDense: true,
                hintText: 'موضوع خود را بنویسید',
                hintStyle: TextStyle(fontSize: AppDecoration.fontSizeRelative(-3)),
              ),
              onChanged: (t){

              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDoctorDocsSection(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('مدارک پزشکی').bold().font(AppDecoration.morabbaFont),

              Image.asset(AppImages.addIco),
            ],
          ),

          const SizedBox(height: 8),
          buildDoctorDocItem(),
          buildDoctorDocItem(),
        ],
      ),
    );
  }

  Widget buildDoctorDocItem(){
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: CustomCard(
        color: AppDecoration.gray,
          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Row(
                  children: [
                    Flexible(
                        child: const Text('آزمایش ', maxLines: 1,).fsR(-2)
                    ),
                  ],
                ),
              ),

              Row(
                children: [
                  Text(FileSize.getSize(4554)).englishFont().fsR(-2).alpha(),
                  const SizedBox(width: 10),
                  const Icon(AppIcons.remove, size: 18).toColor(Colors.red)
                ],
              ),
            ],
          )
      ),
    );
  }

  Widget buildPermissionsSection(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('مجوز‌های دسترسی در تقویم').bold().font(AppDecoration.morabbaFont),

          const SizedBox(height: 8),
          Row(
            children: [
              CheckBoxRow(
                description: const Text('قائدگی').bold().fsR(-1),
                value: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                mainAxisSize: MainAxisSize.min,
                onChanged: (v){},
              ),

              CheckBoxRow(
                description: const Text('روابط جنسی').bold().fsR(-1),
                value: true,
                padding: EdgeInsets.zero,
                mainAxisSize: MainAxisSize.min,
                onChanged: (v){},
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget buildDateTitleSection(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('انتخاب تاریخ و زمان').bold().font(AppDecoration.morabbaFont),

          const SizedBox(height: 8),
          CustomCard(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            color: AppDecoration.darkColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('خرداد').thinFont().color(Colors.white),

                    const SizedBox(width: 10),
                    Text('1402'.localeNum()).boldFont().color(Colors.white),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(
                      width: 28,
                      height: 28,
                      child: CustomCard(
                          child: Center(
                            child: Icon(AppIcons.arrowLeft, size: 14),
                          )
                      ),
                    ),

                    const SizedBox(width: 8),
                    const SizedBox(
                      width: 28,
                      height: 28,
                      child: CustomCard(
                          child: Center(
                            child: Text('26'),
                          )
                      ),
                    ),

                    const SizedBox(width: 4),
                    SizedBox(
                      width: 28,
                      height: 28,
                      child: CustomCard(
                        color: Colors.blue,
                          border: Border.all(style: BorderStyle.solid, color: Colors.white),
                          child: Center(
                            child: const Text('25').color(Colors.white).bold(),
                          )
                      ),
                    ),

                    const SizedBox(width: 4),
                    const SizedBox(
                      width: 28,
                      height: 28,
                      child: CustomCard(
                          child: Center(
                            child: Text('26'),
                          )
                      ),
                    ),

                    const SizedBox(width: 8),
                    const SizedBox(
                      width: 28,
                      height: 28,
                      child: CustomCard(
                          child: Center(
                            child: Icon(AppIcons.arrowRight, size: 14),
                          )
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }



  void onRegisterClick() {
  }

  buildSliver1() {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          buildAccessSection(),

          const SizedBox(height: 14),
          buildTitleSection(),

          const SizedBox(height: 30),
          buildDoctorDocsSection(),

          const SizedBox(height: 30),
          buildPermissionsSection(),

          const SizedBox(height: 30),
          buildDateTitleSection(),
        ],
      ),
    );
  }

  buildSliver2() {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          ...List.generate(50, (index) => Row(
            children: [
              Text('aaaaaaaaaaaaaaaaaaa'),
            ],
          ),
          )
        ],
      ),
    );
  }
}

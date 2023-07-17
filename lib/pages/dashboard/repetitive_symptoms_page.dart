import 'package:app/structures/abstract/stateBase.dart';
import 'package:app/system/extensions.dart';
import 'package:app/tools/app/appDecoration.dart';
import 'package:app/tools/app/appDialogIris.dart';
import 'package:app/tools/app/appIcons.dart';
import 'package:app/tools/app/appImages.dart';
import 'package:app/tools/app/appThemes.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:iris_tools/modules/stateManagers/assist.dart';
import 'package:iris_tools/widgets/customCard.dart';

class RepetitiveSymptomsPage extends StatefulWidget {
  const RepetitiveSymptomsPage({Key? key}) : super(key: key);

  @override
  State createState() => _RepetitiveSymptomsPageState();
}
///============================================================================================
class _RepetitiveSymptomsPageState extends StateBase<RepetitiveSymptomsPage> {
  late Border border;

  @override
  void initState(){
    super.initState();
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
      padding: const EdgeInsets.only(bottom: 20.0),
      child: CustomCard(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
       child: Column(
         children: [
           Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
               Row(
                 children: [
                   TabPageSelectorIndicator(
                       backgroundColor: AppDecoration.mainColor,
                       borderColor: AppDecoration.mainColor,
                       size: 8,
                   ),

                   const Text('علائم پرتکرار').font(AppDecoration.morabbaFont),
                 ],
               ),

               CustomCard(
                 padding: const EdgeInsets.all(4),
                   radius: 6,
                   color: AppDecoration.mainColor,
                   child: const Icon(AppIcons.add, color: Colors.white, size: 15,)
               ),
             ],
           ),

           const SizedBox(height: 20),

           const Text('لورم ایپسوم متن ساختگی با تولید سادگی نامفهوم از صنعت چاپ، و با استفاده از طراحان گرافیک است، چاپگرها'
               ' و متون بلکه روزنامه و مجله در ستون و سطرآنچنان که لازم است،', textAlign: TextAlign.justify,),

           const SizedBox(height: 20),
           Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
               Row(
                 children: [
                   Image.asset(AppImages.calendarIcon),
                   const SizedBox(width: 5),
                   const Text('تاریخ نمودار').boldFont(),
                 ],
               ),

               Text('1 خرداد 1402'.localeNum()).boldFont()
             ],
           ),

           const SizedBox(height: 25),
           Directionality(
             textDirection: TextDirection.ltr,
             child: SingleChildScrollView(
               scrollDirection: Axis.horizontal,
               child: SizedBox(
                 width: 250,
                 height: 150 * pw,
                 child: buildChartSection(),
               ),
             ),
           ),

           const SizedBox(height: 25),
           buildAdviceSection(),
         ],
       ),
      ),
    );
  }

  Widget buildChartSection(){
    return BarChart(
      BarChartData(
          maxY: 50,
        minY: 0,
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          show: true,
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              interval: 10,
              reservedSize: 20,
              showTitles: true,
              getTitlesWidget: (val,TitleMeta meta){
                return Text('${val.toInt()}');
              }
            )
          ),

            rightTitles: const AxisTitles(
                sideTitles: SideTitles(
                    interval: 10,
                    showTitles: false,
                )
            ),
          bottomTitles: const AxisTitles(
              sideTitles: SideTitles(
                interval: 10,
                showTitles: false,
              )
          ),
          topTitles: const AxisTitles(
              sideTitles: SideTitles(
                interval: 10,
                showTitles: false,
              )
          ),

        ),

        barGroups: [
          BarChartGroupData(
            x: 10,
          ),
        ]
      ),
      swapAnimationDuration: const Duration(milliseconds: 150), // Optional
      swapAnimationCurve: Curves.linear, // Optional
    );
  }


  Widget buildAdviceSection(){
    return CustomCard(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      color: AppDecoration.boxGreenColor.withAlpha(40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset(AppImages.infoIco, color: Colors.black, width: 24),
              const SizedBox(width: 6),
              const Text('توصیه').boldFont().fsR(1)
            ],
          ),

          const SizedBox(height: 6),
          const Text('فردا زودتر از خواب بیدار شو'),

          const SizedBox(height: 12),
          CustomCard(
            padding: const EdgeInsets.fromLTRB(5, 1, 5, 3),
              color: AppDecoration.boxGreenColor,
              radius: 17,
              child: const Text('مشاهده لینک').fsR(-3)
          )
        ],
      ),
    ).wrapBoxBorder(
      color: AppDecoration.boxGreenColor,
      padding: EdgeInsets.zero,
    );
  }

  void onHelpClick() {
    AppDialogIris.instance.showIrisDialog(
        context,
        descView: const Text('lorm'),
        canDismissible:  true
    );
  }
}

import 'package:flutter/material.dart';

import 'package:fl_chart/fl_chart.dart';
import 'package:iris_tools/modules/stateManagers/assist.dart';
import 'package:iris_tools/widgets/custom_card.dart';

import 'package:app/structures/abstract/state_super.dart';
import 'package:app/system/extensions.dart';
import 'package:app/tools/app/app_decoration.dart';
import 'package:app/tools/app/app_icons.dart';

class SexPage extends StatefulWidget {
  const SexPage({Key? key}) : super(key: key);

  @override
  State createState() => _SexPageState();
}
///============================================================================================
class _SexPageState extends StateSuper<SexPage> {

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

                    const Text('رابطه جنسی').font(AppDecoration.morabbaFont),
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
            buildArrowMonth(),

            const SizedBox(height: 25),
            Directionality(
              textDirection: TextDirection.ltr,
              child: SizedBox(
                width: 250,
                height: 150 * hr,
                child: buildChartSection(),
              ),
            ),

            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }

  Widget buildArrowMonth(){
    return CustomCard(
      padding: const EdgeInsets.all(5),
      color: AppDecoration.gray,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomCard(
            color: Colors.white,
            padding: const EdgeInsets.all(8),
            child: const Icon(AppIcons.arrowLeft, size: 15,).alpha(alpha: 100),
          ),

          Text('خرداد    1402'.localeNum()).font(AppDecoration.morabbaFont),

          CustomCard(
            color: Colors.white,
            padding: const EdgeInsets.all(8),
            child: RotatedBox(
                quarterTurns: 2,
                child: const Icon(AppIcons.arrowLeft, size: 15,).alpha(alpha: 100)
            ),
          ),
        ],
      ),
    );
  }

  Widget buildChartSection(){
    const maxY = 50.0;
    const horizontalInterval = 10.0;
    const noTitle = AxisTitles(
        sideTitles: SideTitles(
          showTitles: false,
        )
    );

    return BarChart(
      swapAnimationDuration: const Duration(milliseconds: 150),
      swapAnimationCurve: Curves.linear,
      BarChartData(
          maxY: maxY,
          minY: 0,
          borderData: FlBorderData(
              show: true,
              border: Border(
                  bottom: BorderSide(width: 1, style: BorderStyle.solid, color: Colors.grey.shade300)
              )
          ),
          titlesData: FlTitlesData(
            show: true,
            rightTitles: noTitle,
            topTitles: noTitle,
            leftTitles: AxisTitles(
                drawBelowEverything: true,
                sideTitles: SideTitles(
                    interval: 20,
                    reservedSize: 25,
                    showTitles: true,
                    getTitlesWidget: (step, TitleMeta meta){
                      if(step > 45){
                        return const SizedBox();
                      }

                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: CustomCard(
                            color: AppDecoration.gray,
                            radius: 0,
                            padding: const EdgeInsets.all(0.5),
                            child: Text('${step.toInt()}').fsR(-5)
                        ),
                      );
                    }
                )
            ),
            bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 60,
                    getTitlesWidget: (step, meta){
                      return SideTitleWidget(
                        axisSide: meta.axisSide,
                        space: 1,
                        angle: 0,
                        child: RotatedBox(quarterTurns: 3,
                            child: Text(getChartTitle(step)).fsR(-2).boldFont()),
                      );
                    }
                )
            ),
          ),
          gridData: FlGridData(
              show: true,
              checkToShowVerticalLine: (v) => true,
              drawVerticalLine: false,
              drawHorizontalLine: true,
              horizontalInterval: horizontalInterval,
              verticalInterval: 1,
              checkToShowHorizontalLine: (v){
                if(v == 0 || v == 20 || v == 40) {
                  return true;
                }

                return false;
              },
              getDrawingHorizontalLine: (step){
                return FlLine(color: Colors.grey.shade300, strokeWidth: 1);
              }
          ),
          barGroups: buildBars()
      ),
    );
  }

  List<BarChartGroupData> buildBars(){
    const radius = BorderRadius.vertical(top: Radius.circular(10));
    final bar = BarChartRodData(toY: 22, width: 10, borderRadius: radius, color: AppDecoration.mainColor);

    return [
      BarChartGroupData(
          x: 0,
          barsSpace: 10,
          barRods: [
            bar.copyWith(toY: 20),
          ]
      ),

      BarChartGroupData(
          x: 1,
          barsSpace: 10,
          barRods: [
            bar.copyWith(toY: 12),
          ]
      ),

      BarChartGroupData(
          x: 2,
          barsSpace: 10,
          barRods: [
            bar.copyWith(toY: 30),
          ]
      ),

      BarChartGroupData(
          x: 3,
          barsSpace: 10,
          barRods: [
            bar.copyWith(toY: 19),
          ]
      ),

      BarChartGroupData(
          x: 4,
          barsSpace: 10,
          barRods: [
            bar.copyWith(toY: 8),
          ]
      ),

      BarChartGroupData(
          x: 5,
          barsSpace: 10,
          barRods: [
            bar.copyWith(toY: 42),
          ]
      ),
    ];
  }

  String getChartTitle(double step) {
    switch(step){
      case 0:
        return 'سردرد';
      case 1:
        return 'کمر درد';
      case 2:
        return 'حالت تهوع';
      case 3:
        return 'دل درد';
      case 4:
        return 'سرگیجه';
    }

    return 'بیماری';
  }
}

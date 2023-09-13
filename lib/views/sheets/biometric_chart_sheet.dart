import 'package:flutter/material.dart';

import 'package:fl_chart/fl_chart.dart';
import 'package:iris_tools/widgets/circle.dart';
import 'package:iris_tools/widgets/customCard.dart';

import 'package:app/system/extensions.dart';
import 'package:app/tools/app/app_decoration.dart';
import 'package:app/tools/app/app_images.dart';
import 'package:app/tools/currency_tools.dart';
import 'package:app/views/components/my_sheet_layout.dart';

class BiometricChartSheet extends StatefulWidget {
  const BiometricChartSheet({
    Key? key
  }) : super(key: key);

  @override
  State createState() => _BiometricChartSheetState();
}
///============================================================================================
class _BiometricChartSheetState extends State<BiometricChartSheet> {
  Color briColor = const Color(0xffBFFFF4);
  Color senColor = const Color(0xffFFE8CC);
  Color bodyColor = const Color(0xffFED4FF);

  @override
  Widget build(BuildContext context) {
    return MySheetLayout (
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        //physics: const ClampingScrollPhysics(),
        //primary: false,
        child: Column(
          children: [
            Row(
              children: [
                const Circle(color: Colors.black, size: 10),
                const SizedBox(width: 5),
                const Text(' نمودار زیست آهنگ').font(AppDecoration.morabbaFont).fsR(1),
              ],
            ),

            const SizedBox(height: 30),
            Row(
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(3),
                      child: SizedBox(
                        width: 9,
                        child: Divider(
                          height: 8,
                          thickness: 8,
                          color: senColor,
                        ),
                      ),
                    ),

                    const SizedBox(width: 5),
                    const Text('عاطفی').font(AppDecoration.morabbaFont).fsR(-4)
                  ],
                ),

                const SizedBox(width: 10),
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(3),
                      child: SizedBox(
                        width: 9,
                        child: Divider(
                          height: 8,
                          thickness: 8,
                          color: bodyColor,
                        ),
                      ),
                    ),

                    const SizedBox(width: 5),
                    const Text('جسمی').font(AppDecoration.morabbaFont).fsR(-4)
                  ],
                ),

                const SizedBox(width: 10),
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(3),
                      child: SizedBox(
                        width: 9,
                        child: Divider(
                          height: 8,
                          thickness: 8,
                          color: briColor,
                        ),
                      ),
                    ),

                    const SizedBox(width: 5),
                    const Text('ذهنی').font(AppDecoration.morabbaFont).fsR(-4)
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: SizedBox(
                height: 200,
                  child: Directionality(
                      textDirection: TextDirection.ltr,
                      child: buildChart()
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildChart(){
    return LineChart(
      duration: const Duration(milliseconds: 150),
      curve: Curves.linear,
      LineChartData(
        maxY: 1,
        minY: -1,
        minX: 1,
        maxX: 30,
        baselineY: 0,
        borderData: FlBorderData(
            show: true,
          border: Border(
              top: BorderSide(color: AppDecoration.gray, width: 1, style: BorderStyle.solid),
              left: const BorderSide(color: Colors.grey, width: 0.6, style: BorderStyle.solid),
              bottom: BorderSide(color: AppDecoration.gray, width: 1, style: BorderStyle.solid),
          )
        ),
        gridData: FlGridData(
            show: true,
          checkToShowHorizontalLine: (v){
              return true;
          },
          drawHorizontalLine: true,
          drawVerticalLine: false,
          horizontalInterval: .5,
          getDrawingHorizontalLine: (v){
              return FlLine(color: AppDecoration.gray, strokeWidth: 1);
          }
        ),
        titlesData: FlTitlesData(
            show: true,
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: AxisTitles(
              sideTitles: SideTitles(
                  showTitles: true,
                reservedSize: 40,
                getTitlesWidget: (v, titleData){
                    String val = v.toString();

                    if(v == v.toInt()){
                      val = v.toInt().toString();
                    }

                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: CustomCard(
                          color: AppDecoration.gray,
                          radius: 0,
                          padding: const EdgeInsets.all(0.5),
                          child: Text(val, textAlign: TextAlign.center).fsR(-4)
                      ),
                    );
                }
              )
          ),
          bottomTitles: AxisTitles(
            axisNameWidget: const Text('روز های ماه').fsR(-2),
              axisNameSize: 30,
              sideTitles: SideTitles(
                  showTitles: true,
                  interval: 3,
                  reservedSize: 20,
                  getTitlesWidget: (v, titleData){
                    return Text('${v.toInt()}', textAlign: TextAlign.center).fsR(-4).alpha();
                  }
              )
          ),
        ),
        lineBarsData: [
          LineChartBarData(
            isCurved: true,
              color: bodyColor,
              dotData: const FlDotData(show: false),
              spots: [
            const FlSpot(5, 0.5),
            const FlSpot(10, 0.7),
            const FlSpot(12, -.2),
            const FlSpot(18, -.9),
            const FlSpot(25, .9),
          ]),

          LineChartBarData(
              isCurved: true,
              color: briColor,
              dotData: const FlDotData(show: false),
              spots: [
                const FlSpot(1, 0.5),
                const FlSpot(8, -0.7),
                const FlSpot(12, -.2),
                const FlSpot(25, -.9),
                const FlSpot(29, .9),
              ]),

          LineChartBarData(
              isCurved: true,
              color: senColor,
              dotData: const FlDotData(show: false),
              spots: [
                const FlSpot(2, -0.5),
                const FlSpot(7, 0.7),
                const FlSpot(16, .2),
                const FlSpot(20, 1),
                const FlSpot(30, .1),
              ]),
        ]
      ),
    );
  }

  void onRegisterClick() {
  }

  void onCalendarClick() async {

  }
}
///========================================================================================
class WrapItem extends StatelessWidget {
  final String txt;

  const WrapItem({Key? key, required this.txt}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      color: AppDecoration.mainColor,
        radius: 8,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(CurrencyTools.formatCurrencyString(txt)).color(Colors.white),
            const SizedBox(width: 8),
            Image.asset(AppImages.tomanSign, color: Colors.white),
          ],
        )
    );
  }
}

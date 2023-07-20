import 'package:app/structures/abstract/stateBase.dart';
import 'package:app/system/extensions.dart';
import 'package:app/tools/app/appDecoration.dart';
import 'package:app/tools/app/appDialogIris.dart';
import 'package:app/tools/app/appImages.dart';
import 'package:app/tools/app/appSheet.dart';
import 'package:app/views/sheet/biometric_chart_sheet.dart';
import 'package:flutter/material.dart';
import 'package:iris_tools/modules/stateManagers/assist.dart';
import 'package:iris_tools/widgets/customCard.dart';

class ChartPage extends StatefulWidget {
  const ChartPage({Key? key}) : super(key: key);

  @override
  State createState() => _ChartPageState();
}
///============================================================================================
class _ChartPageState extends StateBase<ChartPage> {
  late Border border;

  @override
  void initState(){
    super.initState();

    border = const Border(
      top: BorderSide(color: Colors.white, width: 1.0, style: BorderStyle.solid),
      right: BorderSide(color: Colors.white, width: 0, style: BorderStyle.solid),
      left: BorderSide(color: Colors.white, width: 1.0, style: BorderStyle.solid),
      bottom: BorderSide(color: Colors.white, width: 0, style: BorderStyle.solid),
    );
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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppDecoration.mainColor, AppDecoration.mainColor.withAlpha(0)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),

          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              children: [
                Row(
                  children: [
                    const TabPageSelectorIndicator(
                        backgroundColor: Colors.white,
                        borderColor: Colors.white,
                        size: 10
                    ),
                    const SizedBox(width: 5),
                    const Text('زیست آهنگ امروز').color(Colors.white).font(AppDecoration.morabbaFont),
                  ],
                ),

                const SizedBox(height: 20),

                DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    gradient: LinearGradient(
                      colors: [const Color(0xffFFE8CC), const Color(0xffFFE8CC).withAlpha(0)],
                      begin: Alignment.centerRight,
                      end: Alignment.centerLeft,
                    ),
                    border: border,
                  ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 2, 10, 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('عاطفی').bold().fsR(-1),
                          const Text('8').color(Colors.white),
                        ],
                      ),
                    )
                ),

               const SizedBox(height: 10),

                DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    gradient: LinearGradient(
                      colors: [const Color(0xffFED4FF), const Color(0xffFED4FF).withAlpha(0)],
                      begin: Alignment.centerRight,
                      end: Alignment.centerLeft,
                    ),
                    border: border,
                  ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 2, 10, 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('جسمی').bold().fsR(-1),
                          const Text('8').color(Colors.white),
                        ],
                      ),
                    )
                ),

                const SizedBox(height: 10),

                DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    gradient: LinearGradient(
                      colors: [const Color(0xffBFFFF4), const Color(0xffBFFFF4).withAlpha(0)],
                      begin: Alignment.centerRight,
                      end: Alignment.centerLeft,
                    ),
                    border: border,
                  ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 2, 10, 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('ذهنی').bold().fsR(-1),
                          const Text('12').color(Colors.white),
                        ],
                      ),
                    )
                ),

                /// info
                const SizedBox(height: 20),

                Stack(
                  children: [

                    Positioned.fill(
                      child: Transform.translate(
                        offset: const Offset(-3, -1),
                        child: Transform.rotate(
                          angle: -0.04,
                          child: CustomCard(
                            color: Colors.white.withAlpha(100),
                            child: const Text(''),
                          ),
                        ),
                      ),
                    ),

                    Opacity(
                      opacity: 1,
                      child: CustomCard(
                        color: Colors.white,
                          padding: const EdgeInsets.all(10),
                          child: SizedBox(
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(AppImages.infoIco),
                                    const SizedBox(width: 7),
                                    const Text('توصیـه').bold().fsR(-1)
                                  ],
                                ),

                                const SizedBox(height: 2),
                                const Text('فردا زودتر از خواب نازت بیدارشو و یکم به فکر باشی.\nتا کی بی فکری\nتا کی غفلت').fsR(-1),

                                const SizedBox(height: 5),
                                CustomCard(
                                  color: AppDecoration.mainColor,
                                    radius: 28,
                                    padding: const EdgeInsets.fromLTRB(7, 2, 7, 4),
                                    child: const Text('مشاهده لینک').color(Colors.white).fsR(-3)
                                )
                              ],
                            ),
                          )
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 22),

                const Divider(),

                const SizedBox(height: 22),

                /// buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: onHelpClick,
                      child: Column(
                        children: [
                          CustomCard(
                            color: Colors.white,
                            padding: const EdgeInsets.all(1),
                            radius: 10,
                            child: Image.asset(AppImages.questionMarkIco, width: 28, height: 28,),
                          ),

                          const Text('راهنما').fsR(-2.5)
                        ],
                      ),
                    ),

                    const SizedBox(width: 12),

                    GestureDetector(
                      onTap: onChartClick,
                      child: Column(
                        children: [
                          CustomCard(
                            color: Colors.white,
                            padding: const EdgeInsets.all(1),
                            radius: 10,
                            child: Image.asset(AppImages.chartIco, width: 28),
                          ),

                          const Text('نمودار').fsR(-2.5)
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onHelpClick() {
    AppDialogIris.instance.showIrisDialog(
        context,
        descView: Text('lorm'),//todo.
        canDismissible:  true
    );
  }

  void onChartClick() {
    Widget b(_){
      return const BiometricChartSheet();
    }

    AppSheet.showSheetCustom(
      context,
      builder: b,
      contentColor: Colors.transparent,
      routeName: 'chart',
      isScrollControlled: true,
    );
  }
}

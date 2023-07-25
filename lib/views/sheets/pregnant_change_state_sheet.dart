import 'package:app/tools/app/appToast.dart';
import 'package:flutter/material.dart';

import 'package:iris_tools/widgets/customCard.dart';
import 'package:iris_tools/widgets/text/customRich.dart';

import 'package:app/system/extensions.dart';
import 'package:app/tools/app/appDecoration.dart';
import 'package:app/tools/app/appDialogIris.dart';
import 'package:app/tools/app/appImages.dart';
import 'package:app/tools/dateTools.dart';
import 'package:app/views/components/dateComponents/selectDateCalendarView.dart';
import 'package:app/views/components/my_sheet_layout.dart';

class PregnantChangeStateSheet extends StatefulWidget {
  const PregnantChangeStateSheet({
    Key? key
  }) : super(key: key);

  @override
  State createState() => _PregnantChangeStateSheetState();
}
///============================================================================================
class _PregnantChangeStateSheetState extends State<PregnantChangeStateSheet> {
  String selectedDateText = '-- / -- / --';
  DateTime? selectedDate;
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MySheetLayout(
      body: Column(
        children: [
          Row(
            children: [
              Image.asset(AppImages.changeValueIco),
              const SizedBox(width: 10,),
              const Text('تغیر وضعیت').font(AppDecoration.morabbaFont).fsR(1),
            ],
          ),

          const SizedBox(height: 8),

          GestureDetector(
            onTap: (){
              selectedIndex = 0;
              setState(() {});
            },
            child: Row(
              children: [
                TabPageSelectorIndicator(
                    backgroundColor: selectedIndex == 0? AppDecoration.danger : Colors.transparent,
                    borderColor: AppDecoration.danger,
                    size: 16
                ),

                CustomRich(
                    children: [
                      const Text('اعلام زمان ').fsR(-3).bold(),
                      const Text('تولد').color(AppDecoration.danger).bold().fsR(-3),
                      const Text(' زودتر از موعد').bold().fsR(-3),
                    ]
                ),
              ],
            ),
          ),

          GestureDetector(
            onTap: (){
              selectedIndex = 1;
              setState(() {});
            },
            child: Row(
              children: [
                TabPageSelectorIndicator(
                    backgroundColor: selectedIndex == 1? AppDecoration.danger : Colors.transparent,
                    borderColor: AppDecoration.danger,
                    size: 16
                ),

                CustomRich(
                    children: [
                      const Text('اعلام زمان ').fsR(-3).bold(),
                      const Text('سقط جنین').color(AppDecoration.danger).bold().fsR(-3),
                    ]
                ),
              ],
            ),
          ),

          const SizedBox(height: 25),

          CustomCard(
            color: AppDecoration.gray,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: onCalendarClick,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(''),
                    Text(selectedDateText),
                    Image.asset(AppImages.calendarIcon)
                  ],
                ),
              )
          ),

          const SizedBox(height: 30),

          SizedBox(
            width: 170,
            child: ElevatedButton(
                onPressed: onRegisterClick,
                child: const Text('ثبت اطلاعات')
            ),
          )
        ],
      ),
    );
  }

  void onRegisterClick() {
    if(selectedDate == null){
      AppToast.showToast(context, 'لطفا تاریخ را مشخص کنید');
    }
  }

  void onCalendarClick() async {
    final res = await AppDialogIris.instance.showIrisDialog(context,
        descView: SelectDateCalendarView(
          currentDate: selectedDate,
        )
    );

    if(res is DateTime){
      selectedDate = res;
      selectedDateText = DateTools.dateOnlyRelative(res);
      setState(() {});
    }
  }
}

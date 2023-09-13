import 'package:flutter/material.dart';

import 'package:iris_tools/widgets/customCard.dart';
import 'package:iris_tools/widgets/text/custom_rich.dart';

import 'package:app/system/extensions.dart';
import 'package:app/tools/app/app_decoration.dart';
import 'package:app/tools/app/app_dialog_iris.dart';
import 'package:app/tools/app/app_images.dart';
import 'package:app/tools/app/app_toast.dart';
import 'package:app/tools/date_tools.dart';
import 'package:app/views/components/dateComponents/selectDateCalendarView.dart';
import 'package:app/views/components/my_sheet_layout.dart';

class PeriodChangeStateSheet extends StatefulWidget {
  const PeriodChangeStateSheet({
    Key? key
  }) : super(key: key);

  @override
  State createState() => _PeriodChangeStateSheetState();
}
///============================================================================================
class _PeriodChangeStateSheetState extends State<PeriodChangeStateSheet> {
  String selectedDateText = '-- / -- / --';
  DateTime? selectedDate;

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

          Row(
            children: [
              TabPageSelectorIndicator(
                  backgroundColor: AppDecoration.danger,
                  borderColor: AppDecoration.danger,
                  size: 8
              ),

              CustomRich(
                  children: [
                    const Text('اعلام زمان ').fsR(-3).bold(),
                    const Text('قاعدگی').color(AppDecoration.danger).bold().fsR(-3),
                    const Text(' غیر منتظره').bold().fsR(-3),
                  ]
              ),
            ],
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

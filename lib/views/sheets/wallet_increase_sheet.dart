import 'package:flutter/material.dart';

import 'package:iris_tools/api/helpers/textFieldHelper.dart';
import 'package:iris_tools/widgets/customCard.dart';
import 'package:iris_tools/widgets/text/custom_rich.dart';

import 'package:app/system/extensions.dart';
import 'package:app/tools/app/app_decoration.dart';
import 'package:app/tools/app/app_images.dart';
import 'package:app/tools/currency_tools.dart';
import 'package:app/views/components/my_sheet_layout.dart';

class WalletIncreaseSheet extends StatefulWidget {
  const WalletIncreaseSheet({
    Key? key
  }) : super(key: key);

  @override
  State createState() => _WalletIncreaseSheetState();
}
///============================================================================================
class _WalletIncreaseSheetState extends State<WalletIncreaseSheet> {
  TextEditingController amountCtr = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MySheetLayout (
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Row(
              children: [
                Image.asset(AppImages.walletPlus, width: 25),
                const SizedBox(width: 10),
                const Text('افزایش اعتبار').font(AppDecoration.morabbaFont).fsR(1),
              ],
            ),

            const SizedBox(height: 20),

            CustomCard(
                color: AppDecoration.warning.withAlpha(30),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                child: Row(
                  children: [
                    Image.asset(AppImages.infoIco2, width: 20, color: AppDecoration.warning),

                    const SizedBox(width: 5),

                    Expanded(
                      child: CustomRich(
                          children: [
                            const Text('9 درصد').fsR(-3).bold(),
                            const Text(' مالیات بر ارزش افزوده پس از پرداخت از مبلغ کسر خواهد شد').fsR(-3),
                          ]
                      ),
                    ),
                  ],
                ),
            ),

            const SizedBox(height: 10),

            CustomCard(
              color: AppDecoration.mainColor.withAlpha(30),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
              child: Row(
                children: [
                  Image.asset(AppImages.infoIco2, width: 20, color: AppDecoration.mainColor),

                  const SizedBox(width: 5),

                  Expanded(
                    child: CustomRich(
                        children: [
                          const Text('از بین ').fsR(-3),
                          const Text('مبالغ').fsR(-3).bold(),
                          const Text(' زیر یکی را انتخاب نمایید یا مبلغ مورد نظر خود را وارد نمایید').fsR(-3),
                        ]
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
            const Wrap(
              runSpacing: 4,
              spacing: 5,
              alignment: WrapAlignment.center,
              children: [
                WrapItem(txt: '35000'),
                WrapItem(txt: '78000'),
                WrapItem(txt: '350000'),
                WrapItem(txt: '145000'),
                WrapItem(txt: '92000'),
              ],
            ),
            const SizedBox(height: 15),

            Row(
              children: [
                TabPageSelectorIndicator(
                    backgroundColor: AppDecoration.mainColor,
                    borderColor: AppDecoration.mainColor,
                    size: 6,
                ),

                const Text('مبلغ').fsR(-2)
              ],
            ),
            const SizedBox(height: 5),

            CustomCard(
              color: AppDecoration.gray,
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: onCalendarClick,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: amountCtr,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          decoration: AppDecoration.noneBordersInputDecoration.copyWith(
                            isDense: true,
                          ),
                          onChanged: (v){
                            amountCtr.text = CurrencyTools.formatCurrencyString(v);
                            TextFieldHelper.cursorToEnd(amountCtr);
                          },
                        ),
                      ),

                      Image.asset(AppImages.tomanSign)
                    ],
                  ),
                )
            ),

            const SizedBox(height: 30),

            /// button
            SizedBox(
              width: 170,
              child: ElevatedButton(
                  onPressed: onRegisterClick,
                  child: const Text('ثبت اطلاعات')
              ),
            )
          ],
        ),
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

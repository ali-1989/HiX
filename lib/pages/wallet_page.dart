import 'package:app/structures/models/transactionModel.dart';
import 'package:app/system/extensions.dart';
import 'package:app/tools/app/appDecoration.dart';
import 'package:app/tools/app/appIcons.dart';
import 'package:app/tools/app/appImages.dart';
import 'package:app/tools/app/appSheet.dart';
import 'package:app/tools/currencyTools.dart';
import 'package:app/tools/dateTools.dart';
import 'package:app/views/components/backBtn.dart';
import 'package:app/views/sheet/wallet_increase_sheet.dart';
import 'package:flutter/material.dart';
import 'package:iris_tools/api/generator.dart';

import 'package:iris_tools/modules/stateManagers/assist.dart';

import 'package:app/services/session_service.dart';
import 'package:app/structures/abstract/stateBase.dart';
import 'package:app/structures/middleWares/requester.dart';
import 'package:app/system/keys.dart';
import 'package:iris_tools/widgets/customCard.dart';
import 'package:iris_tools/widgets/icon/circularIcon.dart';

class WalletPage extends StatefulWidget {

  WalletPage({
    Key? key,
  }) : super(key: key);

  @override
  State<WalletPage> createState() => _WalletPageState();
}
///==================================================================================
class _WalletPageState extends StateBase<WalletPage> {
  Requester requester = Requester();
  List<TransactionModel> list = [];

  @override
  void initState(){
    super.initState();

    //requestData();

    List.generate(20, (index) {
      final t = TransactionModel();
      t.title = Generator.getRandomFrom(['فاکتور وبینار', 'فاکتور خرید', 'صورت حساب مشاوره', 'واریز وجه']);
      t.amount = Generator.getRandomFrom([123000, -70000, 25000, -65000]);
      t.factorNumber = Generator.generateIntId(10).toString();
      t.date = DateTime.now();

      list.add(t);
    });
  }

  @override
  void dispose(){
    requester.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Assist(
        controller: assistCtr,
        builder: (context, ctr, data) {
          return Scaffold(
            body: buildBody(),
          );
        }
    );
  }

  Widget buildBody(){
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xffE7E1FF), Colors.white],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        image: DecorationImage(image: AssetImage(AppImages.backgroundPlusColored), fit: BoxFit.fill),
      ),
      child: Builder(
        builder: (context) {
          /*if(isInFetchData) {
            return WaitToLoad();
          }*/

          return Column(
            children: [
              const SizedBox(height: 20),

              const BackBtn(),

              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: buildAmountSection(),
              ),

              Expanded(
                  child: buildTransactionList()
              )
            ],
          );
        }
      ),
    );
  }

  Widget buildAmountSection() {
    return CustomCard(
      color: Colors.white,
        radius: 12,
        padding: const EdgeInsets.symmetric(
          horizontal: 10, vertical: 15
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const TabPageSelectorIndicator(
                        backgroundColor: Colors.black,
                        borderColor: Colors.black,
                        size: 8,
                    ),

                    const SizedBox(width: 2),

                    const Text('اعتبار حساب').font(AppDecoration.morabbaFont)
                  ],
                ),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('340,000'.localeNum()).font(AppDecoration.morabbaFont).color(AppDecoration.mainColor),
                    const SizedBox(width: 3),
                    Image.asset(AppImages.tomanSign, width: 15)
                  ],
                ),
              ],
            ),

            const SizedBox(height: 20),

            GestureDetector(
              onTap: onIncreaseWalletClick,
              child: CustomCard(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  radius: 20,
                  color: AppDecoration.mainColor,
                  child: Row(
                    children: [
                      CircularIcon(
                        backColor: Colors.white,
                        itemColor: AppDecoration.mainColor,
                        icon: AppIcons.add,
                      ),

                      const SizedBox(width: 8),
                      const Text('افـزایش اعــــتبار').color(Colors.white).fsR(-3).boldFont()
                    ],
                  )
              ),
            )
          ],
        )
    );
  }

  Widget buildTransactionList() {
    if(list.isEmpty){
      return Center(
        child: CustomCard(
          padding: const EdgeInsets.all(7),
          color: AppDecoration.mainColor,
          child: const Text('تراکنشی برای شما ثبت نشده است').fsR(-3).color(Colors.white).boldFont(),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [

          SizedBox(height: 30 * pw),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const TabPageSelectorIndicator(
                    backgroundColor: Colors.black,
                    borderColor: Colors.black,
                    size: 8,
                  ),

                  const Text('تاریخچه تراکنش‌ها').font(AppDecoration.morabbaFont).fsR(-1),
                ],
              ),

              Row(
                children: [
                  const TabPageSelectorIndicator(
                    backgroundColor: Color(0xff00FFD1),
                    borderColor: Color(0xff00FFD1),
                    size: 6,
                  ),

                  const Text('واریز به حساب').boldFont().fsR(-3),

                  const SizedBox(width: 5),
                  const TabPageSelectorIndicator(
                    backgroundColor: Color(0xffF0134D),
                    borderColor: Color(0xffF0134D),
                    size: 6,
                  ),

                  const Text('برداشت از حساب').boldFont().fsR(-3),
                ],
              ),
            ],
          ),

          Expanded(
            child: ListView.builder(
              itemCount: list.length,
                padding: const EdgeInsets.only(top: 10),
                itemBuilder: itemBuilder
            ),
          ),
        ],
      ),
    );
  }

  Widget? itemBuilder(BuildContext context, int index) {
    final itm = list[index];

    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: CustomCard(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        radius: 12,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(itm.title).boldFont(),

                 CustomCard(
                  padding: const EdgeInsets.all(4),
                    radius: 4,
                    color: itm.isPlus() ? const Color(0xff00FFD1) : const Color(0xffF0134D),
                    child: RotatedBox(
                      quarterTurns: itm.isPlus() ? 2 : 0,
                        child: const Icon(AppIcons.arrowDown, size: 12)
                    )
                )
              ],
            ),

            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('شماره فاکتور').fsR(-3),
                Text(itm.factorNumber).font(AppDecoration.righteousFont).fsR(-3),
              ],
            ),

            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('مبلغ').fsR(-3),
                Row(
                  children: [
                    Text(CurrencyTools.formatCurrency(itm.amount).localeNum()).boldFont(),
                    const SizedBox(width: 5),
                    Image.asset(AppImages.tomanSign, width: 12)
                  ],
                ),
              ],
            ),

            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('تاریخ').fsR(-3),

                Text(DateTools.hmAndDateRelative(itm.date)).fsR(-3),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void requestData() async {
    final js = <String, dynamic>{};
    js[Keys.requesterId] = SessionService.getLastLoginUser()?.userId;

    requester.httpRequestEvents.onFailState = (req, r) async {

    };

    requester.httpRequestEvents.onStatusOk = (req, data) async {



      assistCtr.addStateAndUpdateHead('');
    };

    requester.bodyJson = js;

    requester.request(context);
  }

  void onIncreaseWalletClick() {
    Widget b(_){
      return const WalletIncreaseSheet();
    }

    AppSheet.showSheetCustom(
      context,
      builder: b,
      contentColor: Colors.transparent,
      routeName: 'WalletIncreaseSheet',
      isScrollControlled: true,
    );
  }
}



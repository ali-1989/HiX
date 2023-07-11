import 'package:app/constants.dart';
import 'package:app/customRich.dart';
import 'package:app/system/extensions.dart';
import 'package:app/tools/app/appDecoration.dart';
import 'package:app/tools/app/appImages.dart';
import 'package:app/tools/app/appLocale.dart';
import 'package:app/tools/app/appThemes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:iris_tools/modules/stateManagers/assist.dart';

import 'package:app/services/session_service.dart';
import 'package:app/structures/abstract/stateBase.dart';
import 'package:app/structures/middleWares/requester.dart';
import 'package:app/system/keys.dart';

class WelcomePage extends StatefulWidget {

  WelcomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}
///==================================================================================
class _WelcomePageState extends StateBase<WelcomePage> {
  Requester requester = Requester();

  @override
  void initState(){
    super.initState();
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
    /*if(isInFetchData) {
      return WaitToLoad();
    }*/


    return SizedBox.expand(
      child: DecoratedBox(
          decoration: BoxDecoration(
            color: AppDecoration.secondColor,
          ),

        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(height: 50),
            Image.asset(AppImages.welcome, width: 95),

            const SizedBox(height: 8),
            CustomRich(
                children: [
                  const Text('به ').font(AppDecoration.shabnamFont),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 3.0),
                    child: Image.asset(AppImages.hiX, width: 36, height: 17, fit: BoxFit.fill),
                  ),
                  const Text(' خوش آمدید').font(AppDecoration.shabnamFont,),
                ]
            ),

            const SizedBox(height: 50),
            Image.asset(AppImages.vector$welcomePage),

            const SizedBox(height: 40),
            Expanded(
              child: DecoratedBox(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                  ),
                child: Column(
                  children: [

                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40.0),
                        child: Column(
                          children: [
                            const SizedBox(height: 20),
                            const Text('ورود به حساب کاربری').font(AppDecoration.morabbaFont)
                                .bold().fsR(7),

                            const SizedBox(height: 20),
                            const Text('شما وارد حساب خود نشده اید. ابتدا وارد شوید یا ثبت نام کنید').fsR(-.5),

                            const SizedBox(height: 30),
                            ElevatedButton(
                                onPressed: onGotoWebViewClick,
                                child: const Text('ورود / ثبت نام')
                            )
                          ],
                        ),
                      ),
                    ),

                    Visibility(
                      visible: true,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          children: [
                            Image.asset(AppImages.newVersionIco),

                            const SizedBox(width: 7),
                             Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('بروز رسانی جدید')
                                    .color(AppThemes.instance.currentTheme.buttonBackColor)
                                    .bold().fsR(1),

                                const SizedBox(height: 5),
                                CustomRich(
                                    children: [
                                      const Text('برای مشاهده آخرین ویژگی های افزوده شده ').alpha().fsR(-1),

                                      GestureDetector(
                                        onTap: onShowNewVersionOptionsClick,
                                          child: const Text('کلیک ')
                                              .color(AppThemes.instance.currentTheme.buttonBackColor)
                                              .fsR(-.5)
                                      ),

                                      const Text('فرمایید ').alpha().fsR(-1),
                                    ]
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 2),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 60.0),
                      child: Align(
                        alignment: Alignment.centerRight,
                          child: Text('نسخه ${AppLocale.numberRelative(Constants.appVersionName)}')
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            )
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

  void onShowNewVersionOptionsClick() {
    print('ggg');
  }

  void onGotoWebViewClick() {
  }
}

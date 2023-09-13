import 'package:flutter/material.dart';

import 'package:iris_notifier/iris_notifier.dart';
import 'package:iris_tools/api/helpers/colorHelper.dart';
import 'package:iris_tools/api/helpers/mathHelper.dart';
import 'package:iris_tools/widgets/customCard.dart';
import 'package:iris_tools/widgets/icon/circular_icon.dart';
import 'package:iris_tools/widgets/iris_image_view.dart';

import 'package:app/managers/layout_manager.dart';
import 'package:app/services/login_service.dart';
import 'package:app/services/session_service.dart';
import 'package:app/structures/enums/app_events.dart';
import 'package:app/system/extensions.dart';
import 'package:app/tools/app/app_decoration.dart';
import 'package:app/tools/app/app_dialog_iris.dart';
import 'package:app/tools/app/app_icons.dart';
import 'package:app/tools/app/app_images.dart';
import 'package:app/tools/app/app_messages.dart';
import 'package:app/tools/app/app_sizes.dart';
import 'package:app/tools/app/app_themes.dart';
import 'package:app/tools/route_tools.dart';
import 'package:app/views/components/my_divider.dart';
import 'package:app/views/pages/profile/profile_page.dart';
import 'package:app/views/pages/wallet_page.dart';

class DrawerMenuBuilder {
  DrawerMenuBuilder._();

  static Widget buildDrawer(){
    return SizedBox(
      width: MathHelper.minDouble(400, MathHelper.percent(AppSizes.instance.appWidth, 75)),
      child: DecoratedBox(
        decoration: const BoxDecoration(
            color: Colors.white,
            //borderRadius: BorderRadius.only(topLeft: Radius.circular(15), bottomLeft: Radius.circular(15))
        ),

        child: Builder(
            builder: (context) {
              return Column(
                children: [
                  Expanded(
                    child: ListTileTheme(
                      data: ListTileTheme.of(context).copyWith(
                        style: ListTileStyle.drawer,
                        titleTextStyle: AppThemes.baseTextStyle(),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 3),
                      ),
                      child: ListView(
                        children: [
                          Align(
                              alignment: Alignment.topRight,
                              child: Padding(
                                padding: const EdgeInsets.only(right:8.0, top: 10),
                                child: GestureDetector(
                                  onTap: (){
                                    LayoutManager.toggleDrawer();
                                  },
                                  child: CustomCard(
                                    color: AppDecoration.gray,
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                                      child: const Icon(AppIcons.arrowLeft, size: 17)
                                  ),
                                ),
                              )
                          ),

                          /// logo
                          Image.asset(AppImages.hiX, width: 25, height: 25),

                          /// avatar
                          const SizedBox(height: 15),
                          _buildAvatarSection(),

                          /// name
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(AppImages.userIco,),
                                    const SizedBox(width: 3),
                                    const Text('سمیرا حسن پور').bold(),
                                  ],
                                ),

                                Row(
                                  children: [
                                    RotatedBox(
                                      quarterTurns: 2,
                                      child: CircularIcon(
                                        backColor: AppDecoration.mainColor,
                                        icon: AppIcons.arrowDown,
                                        size: 17,
                                      ),
                                    ),

                                    const SizedBox(width: 5),

                                    CustomCard(
                                      radius: 14,
                                      padding: const EdgeInsets.fromLTRB(7, 2, 7, 3),
                                      child: const Text('کاربر عادی').color(AppDecoration.mainColor).font(AppDecoration.morabbaFont).fsR(-4),
                                    ).wrapBoxBorder(
                                        padding: const EdgeInsets.all(1),
                                        radius: 14
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 15),

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 14.0),
                            child: Column(
                              children: [
                                const Opacity(
                                  opacity: 0.3,
                                    child: MyDivider()
                                ),

                                ListTile(
                                  title: const Text('کیف پول').boldFont(),
                                  //leading: Image.asset(AppImages.newVersionIco, width: 20, height: 20),
                                  onTap: gotoWalletPage,
                                  dense: true,
                                  horizontalTitleGap: 0,
                                  visualDensity: const VisualDensity(horizontal: 0, vertical: -4.0),
                                ),

                                ListTile(
                                  title: const Text('رزرو مشاور').boldFont(),
                                  //leading: Image.asset(AppImages.newVersionIco, width: 20, height: 20),
                                  onTap: gotoAboutPage,
                                  dense: true,
                                  horizontalTitleGap: 0,
                                  visualDensity: const VisualDensity(horizontal: 0, vertical: -4.0),
                                ),

                                /*const Opacity(
                                    opacity: 0.3,
                                    child: MyDivider()
                                ),*/

                                ListTile(
                                  title: const Text('درباره ما').boldFont(),
                                  onTap: gotoAboutPage,
                                  dense: true,
                                  horizontalTitleGap: 0,
                                  visualDensity: const VisualDensity(horizontal: 0, vertical: -4.0),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  /// logoff
                  Builder(
                    builder: (context) {
                      if(SessionService.hasAnyLogin()){
                        return const SizedBox();
                      }

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 25.0),
                        child: ListTile(
                          title: Text(AppMessages.logout),
                          leading: Image.asset(AppImages.logoffIco, width: 17, height: 17),
                          onTap: _onLogoffClick,
                          dense: true,
                          horizontalTitleGap: -15,
                          visualDensity: const VisualDensity(horizontal: 0, vertical: -3.0),
                        ),
                      );
                    }
                  ),
                ],
              );
            }
        ),
      ),
    );
  }

  static Widget _buildAvatarSection(){
    return StreamBuilder(
      stream: EventNotifierService.getStream(AppEvents.userProfileChange),
      builder: (_, data){
        if(SessionService.hasAnyLogin()){
          final user = SessionService.getLastLoginUser()!;
          return GestureDetector(
            onTap: (){
              gotoProfilePage();
            },
            child: Column(
              children: [
                Builder(
                  builder: (ctx) {
                    return Builder(
                      builder: (ctx){
                        if(user.hasAvatar()){
                          //final path = AppDirectories.getSavePathUri(user.avatarModel!.fileLocation?? '', SavePathType.userProfile, user.avatarFileName);
                          //final img = FileHelper.getFile(path);
                          //if(img.existsSync() && img.lengthSync() == (user.avatarModel!.volume?? 0)){

                          return CircleAvatar(
                            backgroundColor: ColorHelper.textToColor(user.nameFamily),
                            radius: 35,
                            child: IrisImageView(
                              height: 70,
                              width: 70,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                              beforeLoadWidget: const CircularProgressIndicator(),
                              //bytes: user.avatarModel?.bytes,
                              //url: user.avatarModel?.fileLocation,
                              onDownloadFn: (bytes, path){
                                //user.avatarModel?.bytes = bytes;
                              },
                            ),
                          );
                        }

                        //checkAvatar(user);
                        return DecoratedBox(
                          decoration: ShapeDecoration(
                            shape: CircleBorder(side: BorderSide(color: AppDecoration.mainColor, width: 1.5)),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(5.0),
                            child: CircleAvatar(
                              foregroundImage: AssetImage(AppImages.avatar),
                              radius: 30,
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),

                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                          child: Text(user.nameFamily,
                            maxLines: 1, overflow: TextOverflow.clip,
                          ).bold()
                      ),

                      /*IconButton(
                        onPressed: gotoProfilePage,
                        icon: Icon(AppIcons.report2, size: 18,).alpha()
                    ),*/
                    ],
                  ),
                ),
              ],
            ),
          );
        }

        return DecoratedBox(
          decoration: ShapeDecoration(
            shape: CircleBorder(side: BorderSide(color: AppDecoration.mainColor, width: 1.1)),
          ),
          child: const Icon(AppIcons.accountCircle, size: 65, color: Colors.grey,),
        );
      },
    );
  }

  /*static void shareAppCall() {
    AppBroadcast.homeScreenKey.currentState?.scaffoldState.currentState?.closeDrawer();
    ShareExtend.share('https://cafebazaar.ir/app/ir.vosatezehn.com', 'text');
  }*/

  static void gotoProfilePage() async {
    await LayoutManager.toggleDrawer();
    RouteTools.pushPage(RouteTools.getTopContext()!, ProfilePage());
  }

  static void gotoWalletPage() async {
    await LayoutManager.toggleDrawer();
    RouteTools.pushPage(RouteTools.getTopContext()!, WalletPage());
  }

  static void gotoAboutPage() async {
    await LayoutManager.toggleDrawer();
    RouteTools.pushPage(RouteTools.getTopContext()!, ProfilePage());
  }


  static void _onLogoffClick() async {
    await LayoutManager.hideDrawer(millSec: 100);

    bool yesFn(){
      LoginService.forceLogoff(SessionService.getLastLoginUser()!.userId);
      return false;
    }

    final decor = AppDialogIris.instance.dialogDecoration.copy();
    decor.negativeButtonBackColor = Colors.transparent;
    decor.positiveButtonBackColor = Colors.green;

    AppDialogIris.instance.showIrisDialog(
      RouteTools.getBaseContext()!,
      canDismissible: true,
      dismissOnButtons: true,
      descView: Column(
        children: [

          Text(AppMessages.doYouWantLogoutYourAccount),

          const SizedBox(height: 40),

          Row(
            textDirection: TextDirection.ltr,
            children: [
              SizedBox(
                width: 90,
                height: 38,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(0),
                  ),
                    onPressed: yesFn,
                    child: Text(AppMessages.yes)
                ),
              ),

              const SizedBox(width: 10),

              TextButton(
                  onPressed: (){
                    Navigator.of(RouteTools.getBaseContext()!).pop();
                  },
                  child: Text(AppMessages.no)
              )
            ],
          )
        ],
      ),
    );
  }
}

// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:app/managers/layout_manager.dart';
import 'package:app/structures/enums/assist_groups.dart';
import 'package:app/system/extensions.dart';
import 'package:app/tools/app/app_badge.dart';
import 'package:app/tools/app/app_decoration.dart';
import 'package:app/tools/app/app_icons.dart';
import 'package:app/tools/app/app_images.dart';
import 'package:app/tools/app/app_sizes.dart';
import 'package:app/tools/route_tools.dart';
import 'package:app/views/pages/notification_page.dart';
import 'package:flutter/material.dart';
import 'package:iris_tools/api/helpers/mathHelper.dart';
import 'package:iris_tools/modules/stateManagers/updater_state.dart';
import 'package:iris_tools/widgets/circle_container.dart';
import 'package:iris_tools/widgets/custom_card.dart';
import 'package:badges/badges.dart' as badge;


class AppbarBuilder extends StatelessWidget {
  AppbarBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(top: 9.0, bottom: 18),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 12 * AppSizes.instance.heightRatio),
                  child: GestureDetector(
                    onTap: (){
                      LayoutManager.toggleDrawer();
                    },
                    child: Icon(AppIcons.menu3Line, color: AppDecoration.mainColor, weight: 20).alpha(),
                  ),
                ),

                const SizedBox(width: 8),

                Image.asset(AppImages.hiX, width: 30),

                const SizedBox(width: 8),

                // ignore: prefer_const_constructors
                CircleBorder(
                  borderColor: AppDecoration.mainColor.withAlpha(85),
                  width: 1,
                  child: const CircleAvatar(
                    foregroundImage: AssetImage(AppImages.avatar),
                    radius: 17,
                  ),
                ),

                const SizedBox(width: 8),

                /// name
                Column(
                  children: [
                    const Text('سمیرا حسن پور').bold().fsR(-3),

                    const SizedBox(height: 3),

                    Row(
                      children: [
                        CustomCard(
                          radius: 25,
                          border: Border.all(color: AppDecoration.mainColor),
                            padding: const EdgeInsets.fromLTRB(8, 1.5, 8, 2),
                            child: const Text('کاربر عادی').font(AppDecoration.morabbaFont).fsR(-4).color(AppDecoration.mainColor),
                        ),

                        const SizedBox(width: 4),

                        CircleContainer(
                            size: 15,
                            backColor: AppDecoration.mainColor,
                            child: const RotatedBox(
                              quarterTurns: 2,
                                child: Icon(AppIcons.arrowDown, size: 12, color: Colors.white)
                            ),
                        )
                      ],
                    )
                  ],
                ),
              ],
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0 * AppSizes.instance.heightRatio),
              child: GestureDetector(
                onTap: (){
                  gotoNotificationPage(context);
                },
                child: UpdaterBuilder(
                  groupIds: const [BadgesGroup.notification],
                  builder: (_, ctr, data) {
                    final num = AppBadge.getBadge(BadgesGroup.notification).toString();

                    return badge.Badge(
                      badgeContent: Text(num.localeNum()).font(AppDecoration.morabbaFont).bold().color(Colors.white).fsR(-5),
                      badgeStyle: const badge.BadgeStyle(shape: badge.BadgeShape.square,padding: EdgeInsets.all(2)),
                      position: badge.BadgePosition.bottomStart(bottom: -7, start: -(MathHelper.between(18, 3, 5, 1, num.length.toDouble()))),
                      child: CustomCard(
                          radius: 10,
                          border: Border.all(color: Colors.grey, width: 1),
                          padding: const EdgeInsets.all(4),
                          child: Image.asset(AppImages.notificationIco, color: Colors.black, width: 26, height: 26)
                      ),
                    );
                  }
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void gotoNotificationPage(context) {
    RouteTools.pushPage(context, NotificationPage());
  }
}

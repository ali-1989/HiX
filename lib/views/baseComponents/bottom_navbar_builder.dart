// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';

import 'package:iris_tools/modules/stateManagers/updater_state.dart';
import 'package:iris_tools/widgets/colored_space.dart';

import 'package:app/managers/layout_manager.dart';
import 'package:app/structures/models/layoutNavigateModel.dart';
import 'package:app/system/extensions.dart';
import 'package:app/tools/app/app_broadcast.dart';
import 'package:app/tools/app/app_decoration.dart';
import 'package:app/tools/app/app_sizes.dart';

class BottomNavbarBuilder extends StatelessWidget {
  BottomNavbarBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return UpdaterBuilder(
      id: AppBroadcast.bottomNavbarRefresherId,
        builder: (_, ctr, data){
          return DecoratedBox(
            decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(color: Colors.black38, offset: Offset(0, 3), blurStyle: BlurStyle.outer, spreadRadius: 0, blurRadius: 4)
                ]
            ),
            child: ColoredBox(
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0 * AppSizes.instance.heightRatio),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: LayoutManager.layoutPageList.map((e) => buildNavigationItem(e)).toList(),
                ),
              ),
            ),
          );
        }
    );
  }

  Widget buildNavigationItem(LayoutNavigateModel model){
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: (){
        LayoutManager.selectNavigateItem(model);
      },
      child:Column(
        children: [
          const SizedBox(height: 10),

          ColoredSpace(color: model.isSelected? AppDecoration.mainColor : AppDecoration.grayForBottomBar, height: 2.2, width: 10),

          const SizedBox(height: 10),

          Image.asset(model.iconAddress, width: 20, color: model.isSelected? Colors.black: AppDecoration.grayForBottomBar),

          const SizedBox(height: 6),

          Text(model.title)
              .fsR(-5).bold()
              .color(model.isSelected? AppDecoration.mainColor : AppDecoration.grayForBottomBar),

          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

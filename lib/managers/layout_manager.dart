import 'dart:async';

import 'package:flutter/cupertino.dart';

import 'package:iris_notifier/iris_notifier.dart';

import 'package:app/structures/enums/app_events.dart';
import 'package:app/structures/models/layoutNavigateModel.dart';
import 'package:app/tools/app/app_images.dart';
import 'package:app/views/baseComponents/layout_scaffold.dart';

class LayoutManager {
  LayoutManager._();

  static final layoutScaffoldKey = GlobalKey<LayoutScaffoldState>();
  static final List<LayoutNavigateModel> layoutPageList = [];
  static final dashboardNavigateModel = LayoutNavigateModel();
  static final calendarNavigateModel = LayoutNavigateModel();
  static final webinarNavigateModel = LayoutNavigateModel();
  static final consultantNavigateModel = LayoutNavigateModel();

  static Future<void> init() async {
    dashboardNavigateModel.title = 'پیشخوان';
    dashboardNavigateModel.index = 0;
    dashboardNavigateModel.iconAddress = AppImages.navIco$dashboard;
    dashboardNavigateModel.isSelected = true;

    calendarNavigateModel.title = 'تقویم';
    calendarNavigateModel.index = 1;
    calendarNavigateModel.iconAddress = AppImages.navIco$calendar;

    webinarNavigateModel.title = 'وبینار';
    webinarNavigateModel.index = 2;
    webinarNavigateModel.iconAddress = AppImages.navIco$webinar;

    consultantNavigateModel.title = 'مشاوره';
    consultantNavigateModel.index = 3;
    consultantNavigateModel.iconAddress = AppImages.navIco$consultant;


    layoutPageList.add(dashboardNavigateModel);
    layoutPageList.add(calendarNavigateModel);
    layoutPageList.add(webinarNavigateModel);
    layoutPageList.add(consultantNavigateModel);
  }

  static void selectNavigateItem(LayoutNavigateModel model) {
    for (final nav in layoutPageList) {
      nav.isSelected = false;
    }

    model.isSelected = true;
    EventNotifierService.notify(AppEvents.layoutNavigateChange);
  }

  static Future toggleDrawer(){
    return layoutScaffoldKey.currentState!.toggleDrawer();
  }

  static Future hideDrawer({int? millSec}){
    return layoutScaffoldKey.currentState!.hideDrawer(millSec: millSec);
  }

  static LayoutNavigateModel currentPage() {
    for (final nav in layoutPageList) {
      if(nav.isSelected){
        return nav;
      }
    }

    return dashboardNavigateModel;
  }
}

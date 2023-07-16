import 'dart:async';

import 'package:app/structures/enums/appEvents.dart';
import 'package:app/structures/models/layoutNavigateModel.dart';

import 'package:app/tools/app/appImages.dart';
import 'package:app/views/baseComponents/layoutScaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:iris_notifier/iris_notifier.dart';

class LayoutManager {
  LayoutManager._();

  static final layoutScaffoldKey = GlobalKey<LayoutScaffoldState>();
  static final List<LayoutNavigateModel> navigateList = [];
  static final dashboardNavigateModel = LayoutNavigateModel();
  static final calendarNavigateModel = LayoutNavigateModel();
  static final webinarNavigateModel = LayoutNavigateModel();
  static final consultantNavigateModel = LayoutNavigateModel();
  static final notificationsNavigateModel = LayoutNavigateModel();

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

    notificationsNavigateModel.title = 'اعلانات';
    notificationsNavigateModel.index = 4;
    notificationsNavigateModel.iconAddress = AppImages.navIco$notification;

    navigateList.add(dashboardNavigateModel);
    navigateList.add(calendarNavigateModel);
    navigateList.add(webinarNavigateModel);
    navigateList.add(consultantNavigateModel);
    navigateList.add(notificationsNavigateModel);
  }

  static void selectNavigateItem(LayoutNavigateModel model) {
    for (final nav in navigateList) {
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
    for (final nav in navigateList) {
      if(nav.isSelected){
        return nav;
      }
    }

    return dashboardNavigateModel;
  }
}

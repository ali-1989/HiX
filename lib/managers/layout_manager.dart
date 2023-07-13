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
    dashboardNavigateModel.enTitle = 'dashboard';
    dashboardNavigateModel.iconAddress = AppImages.navIco$dashboard;
    dashboardNavigateModel.isSelected = true;

    calendarNavigateModel.title = 'تقویم';
    calendarNavigateModel.enTitle = 'calendar';
    calendarNavigateModel.iconAddress = AppImages.navIco$calendar;

    webinarNavigateModel.title = 'وبینار';
    webinarNavigateModel.enTitle = 'webinar';
    webinarNavigateModel.iconAddress = AppImages.navIco$webinar;

    consultantNavigateModel.title = 'مشاوره';
    consultantNavigateModel.enTitle = 'consultant';
    consultantNavigateModel.iconAddress = AppImages.navIco$consultant;

    notificationsNavigateModel.title = 'اعلانات';
    notificationsNavigateModel.enTitle = 'notifications';
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
}

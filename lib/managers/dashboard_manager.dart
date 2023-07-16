import 'dart:async';

import 'package:app/structures/enums/appEvents.dart';
import 'package:app/structures/models/dashboardNavigateModel.dart';

import 'package:app/tools/app/appImages.dart';
import 'package:iris_notifier/iris_notifier.dart';

class DashboardManager {
  DashboardManager._();

  static final List<DashboardNavigateModel> navigateList = [];
  static final chartNavigateModel = DashboardNavigateModel();
  static final calendarNavigateModel = DashboardNavigateModel();
  static final repeatTimeNavigateModel = DashboardNavigateModel();
  static final sexNavigateModel = DashboardNavigateModel();

  static Future<void> init() async {
    chartNavigateModel.title = 'زیست آهنگ';
    chartNavigateModel.iconAddress = AppImages.dashboardIco$chart;
    chartNavigateModel.isSelected = true;

    //calendarNavigateModel.title = 'تقویم قائدگی';
    calendarNavigateModel.title = 'تقویم بارداری';
    calendarNavigateModel.iconAddress = AppImages.dashboardIco$calendar;

    repeatTimeNavigateModel.title = 'لحظات پرتکرار';
    repeatTimeNavigateModel.iconAddress = AppImages.dashboardIco$calendar;

    sexNavigateModel.title = 'رابطه جنسی';
    sexNavigateModel.iconAddress = AppImages.dashboardIco$sex;

    navigateList.add(chartNavigateModel);
    navigateList.add(calendarNavigateModel);
    navigateList.add(repeatTimeNavigateModel);
    navigateList.add(sexNavigateModel);
  }

  static void selectNavigateItem(DashboardNavigateModel model) {
    for (final nav in navigateList) {
      nav.isSelected = false;
    }

    model.isSelected = true;
    EventNotifierService.notify(AppEvents.dashboardNavigateChange);
  }

  static DashboardNavigateModel currentPage() {
    for (final nav in navigateList) {
      if(nav.isSelected){
        return nav;
      }
    }

    return chartNavigateModel;
  }
}

import 'dart:async';

import 'package:iris_notifier/iris_notifier.dart';

import 'package:app/structures/enums/app_events.dart';
import 'package:app/structures/models/dashboardNavigateModel.dart';
import 'package:app/tools/app/app_images.dart';

class DashboardManager {
  DashboardManager._();

  static final List<DashboardNavigateModel> navigateList = [];
  static final calendarNavigateModel = DashboardNavigateModel();
  static final repetitiveSymptomsNavigateModel = DashboardNavigateModel();
  static final sexNavigateModel = DashboardNavigateModel();
  static final chartNavigateModel = DashboardNavigateModel();

  static Future<void> init() async {
    calendarNavigateModel.title = 'تقویم قائدگی';
    //calendarNavigateModel.title = 'تقویم بارداری';
    calendarNavigateModel.iconAddress = AppImages.dashboardIco$calendar;
    calendarNavigateModel.isSelected = true;

    repetitiveSymptomsNavigateModel.title = 'علائم پرتکرار';
    repetitiveSymptomsNavigateModel.iconAddress = AppImages.dashboardIco$calendar;

    sexNavigateModel.title = 'رابطه جنسی';
    sexNavigateModel.iconAddress = AppImages.dashboardIco$sex;

    chartNavigateModel.title = 'بیوریتم';
    chartNavigateModel.iconAddress = AppImages.dashboardIco$chart;

    navigateList.add(calendarNavigateModel);
    navigateList.add(repetitiveSymptomsNavigateModel);
    navigateList.add(sexNavigateModel);
    navigateList.add(chartNavigateModel);
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

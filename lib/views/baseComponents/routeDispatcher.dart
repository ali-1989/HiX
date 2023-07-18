import 'package:app/pages/layout_page.dart';
import 'package:app/pages/welcome_page.dart';
import 'package:app/tools/app/appBroadcast.dart';
import 'package:flutter/material.dart';


class RouteDispatcher {
  RouteDispatcher._();

  static Widget dispatch(){

    if(false/*!SessionService.hasAnyLogin()*/){
      return WelcomePage();
    }

    return LayoutPage(key: AppBroadcast.layoutPageKey);
  }
}

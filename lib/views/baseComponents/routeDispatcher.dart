import 'package:app/views/pages/login_page.dart';
import 'package:flutter/material.dart';

import 'package:app/tools/app/appBroadcast.dart';
import 'package:app/views/pages/layout_page.dart';
import 'package:app/views/pages/welcome_page.dart';

class RouteDispatcher {
  RouteDispatcher._();

  static Widget dispatch(){

    if(false/*!SessionService.hasAnyLogin()*/){
      return WelcomePage();
    }

    return LayoutPage(key: AppBroadcast.layoutPageKey);
  }
}

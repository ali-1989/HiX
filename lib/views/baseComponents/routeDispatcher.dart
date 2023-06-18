import 'package:app/pages/home_page.dart';
import 'package:flutter/material.dart';


class RouteDispatcher {
  RouteDispatcher._();

  static Widget dispatch(){

    /*if(!SessionService.hasAnyLogin()){
      return LoginPage();
    }*/

    return HomePage();
  }
}

import 'package:app/pages/home_page.dart';
import 'package:app/pages/login_page.dart';
import 'package:app/pages/welcome_page.dart';
import 'package:app/services/session_service.dart';
import 'package:flutter/material.dart';


class RouteDispatcher {
  RouteDispatcher._();

  static Widget dispatch(){

    if(!SessionService.hasAnyLogin()){
      return WelcomePage();
    }

    return HomePage();
  }
}

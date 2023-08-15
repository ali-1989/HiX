import 'package:flutter/material.dart';

import 'package:iris_tools/modules/stateManagers/assist.dart';

import 'package:app/services/session_service.dart';
import 'package:app/structures/abstract/stateBase.dart';
import 'package:app/structures/middleWares/requester.dart';
import 'package:app/system/keys.dart';

class LoginPage extends StatefulWidget {

  LoginPage({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}
///==================================================================================
class _LoginPageState extends StateBase<LoginPage> {
  Requester requester = Requester();

  @override
  void initState(){
    super.initState();

    requestData();
  }

  @override
  void dispose(){
    requester.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Assist(
        controller: assistCtr,
        builder: (context, ctr, data) {
          return Scaffold(
            body: buildBody(),
          );
        }
    );
  }

  Widget buildBody(){
    /*if(isInFetchData) {
      return WaitToLoad();
    }*/


    return SizedBox();
  }


  void requestData() async {
    final js = <String, dynamic>{};
    js[Keys.requesterId] = SessionService.getLastLoginUser()?.userId;

    requester.httpRequestEvents.onFailState = (req, r) async {

    };

    requester.httpRequestEvents.onStatusOk = (req, data) async {



      assistCtr.addStateAndUpdateHead('');
    };

    requester.bodyJson = js;

    requester.request(context);
  }
}

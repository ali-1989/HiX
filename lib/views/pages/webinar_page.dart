// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';

import 'package:iris_tools/modules/stateManagers/assist.dart';

import 'package:app/structures/abstract/state_super.dart';
import 'package:app/tools/app/app_images.dart';

class WebinarPage extends StatefulWidget {
  WebinarPage({Key? key}) : super(key: key);

  @override
  State createState() => WebinarPageState();
}
///====================================================================================
class WebinarPageState extends StateSuper<WebinarPage> {

  @override
  void initState(){
    super.initState();
  }

  @override
  void dispose(){
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Assist(
        controller: assistCtr,
        builder: (_, ctr, data){
          return buildBody();
        }
    );
  }

  Widget buildBody() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18 * hr),
      child: SizedBox(
        height: hs/2,
        child: Center(
          child: Image.asset(AppImages.comingSoonIco),
        ),
      ),
    );
  }
}



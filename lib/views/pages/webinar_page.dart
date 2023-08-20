import 'package:flutter/material.dart';

import 'package:iris_tools/modules/stateManagers/assist.dart';

import 'package:app/structures/abstract/stateBase.dart';

class WebinarPage extends StatefulWidget {
  const WebinarPage({Key? key}) : super(key: key);

  @override
  State createState() => WebinarPageState();
}
///====================================================================================
class WebinarPageState extends StateBase<WebinarPage> {

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
      padding: EdgeInsets.symmetric(horizontal: 18 * pw),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('webinar'),
          SizedBox(height: 200),

          SizedBox(height: 200),


          Text('webinar'),
        ]
      ),
    );
  }
}


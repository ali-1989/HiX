import 'package:app/structures/abstract/stateBase.dart';
import 'package:flutter/material.dart';
import 'package:iris_tools/modules/stateManagers/assist.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  State createState() => CalendarPageState();
}
///====================================================================================
class CalendarPageState extends StateBase<CalendarPage> {

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
          Text('calendar'),
          SizedBox(height: 200),

          Text('calendar'),
          SizedBox(height: 200),


          Text('calendar'),
        ]
      ),
    );
  }
}

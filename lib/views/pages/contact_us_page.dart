import 'package:flutter/material.dart';

import 'package:iris_tools/api/helpers/focusHelper.dart';
import 'package:iris_tools/modules/stateManagers/assist.dart';
import 'package:iris_tools/widgets/maxWidth.dart';

import 'package:app/services/session_service.dart';
import 'package:app/structures/abstract/stateBase.dart';
import 'package:app/structures/middleWares/requester.dart';
import 'package:app/system/extensions.dart';
import 'package:app/system/keys.dart';
import 'package:app/tools/app/appMessages.dart';
import 'package:app/tools/app/appSheet.dart';
import 'package:app/tools/app/appSnack.dart';
import 'package:app/tools/routeTools.dart';
import 'package:app/views/baseComponents/appBarBuilder.dart';

class ContactUsPage extends StatefulWidget{

  const ContactUsPage({Key? key}) : super(key: key);

  @override
  State<ContactUsPage> createState() => _ContactUsPageState();
}
///==================================================================================
class _ContactUsPageState extends StateBase<ContactUsPage> {
  TextEditingController textCtr = TextEditingController();
  Requester requester = Requester();

  @override
  void dispose(){
    textCtr.dispose();
    requester.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Assist(
        controller: assistCtr,
        builder: (context, ctr, data) {
          return Scaffold(
            appBar: AppBarCustom(
              title: Text(AppMessages.contactUs),
            ),
            body: SafeArea(
                child: buildBody()
            ),
          );
        }
    );
  }

  Widget buildBody(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: Text(AppMessages.contactUsDescription).bold().fsR(2),
        ),

        Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
              child: TextField(
                controller: textCtr,
                minLines: 8,
                maxLines: 12,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(),
                ),
              ),
            ),
        ),

        const SizedBox(height: 20,),
        MaxWidth(
            maxWidth: 300,
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onSendCall,
                child: Text(AppMessages.send),
              ),
            )
        )
      ],
    );
  }

  void onSendCall(){
    FocusHelper.hideKeyboardByUnFocusRoot();
    final txt = textCtr.text.trim();

    if(txt.isEmpty){
      AppSnack.showError(context, AppMessages.contactUsEmptyPrompt);
      return;
    }

    requestSendData();
  }

  void requestSendData() async {
    final txt = textCtr.text.trim();

    final js = <String, dynamic>{};
    js[Keys.requesterId] = SessionService.getLastLoginUser()?.userId;
    js[Keys.data] = txt;

    requester.bodyJson = js;

    requester.httpRequestEvents.onFailState = (req, r) async {
      hideLoading();

      AppSheet.showSheet$OperationFailed(context);
    };

    requester.httpRequestEvents.onStatusOk = (req, data) async {
      hideLoading();

      AppSheet.showSheet$SuccessOperation(context, onBtn: (){
        RouteTools.popTopView(context: context);
      });
    };

    showLoading();
    requester.request(context);
  }
}
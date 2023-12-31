import 'dart:async';

import 'package:iris_notifier/iris_notifier.dart';
import 'package:iris_tools/api/helpers/jsonHelper.dart';
import 'package:iris_tools/modules/stateManagers/updater_state.dart';
import 'package:openid_client/openid_client.dart';
import 'package:openid_client/openid_client_io.dart';

import 'package:app/managers/settings_manager.dart';
import 'package:app/services/session_service.dart';
import 'package:app/structures/enums/app_events.dart';
import 'package:app/structures/models/user_model.dart';
import 'package:app/system/keys.dart';
import 'package:app/tools/app/app_broadcast.dart';
import 'package:app/tools/app/app_http_dio.dart';
import 'package:app/tools/route_tools.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginService {
  LoginService._();

  static void init(){
    EventNotifierService.addListener(AppEvents.userLogin, onLoginObservable);
    EventNotifierService.addListener(AppEvents.userLogoff, onLogoffObservable);
  }

  static void onLoginObservable({dynamic data}){
  }

  static void onLogoffObservable({dynamic data}){
    if(data is UserModel){
      sendLogoffState(data);
    }
  }

  static void sendLogoffState(UserModel user){
    if(AppBroadcast.isNetConnected){
      final reqJs = <String, dynamic>{};
      reqJs[Keys.requesterId] = user.userId;
      reqJs[Keys.forUserId] = user.userId;

      final info = HttpItem();
      info.fullUrl = '${SettingsManager.localSettings.httpAddress}/graph-v1';
      info.method = 'POST';
      info.body = JsonHelper.mapToJson(reqJs);
      info.setResponseIsPlain();

      AppHttpDio.send(info);
    }
  }

  static Future forceLogoff(String userId) async {
    final lastUser = SessionService.getLastLoginUser();

    if(lastUser != null) {
      final isCurrent = lastUser.userId == userId;

      await SessionService.logoff(userId);

      UpdaterController.forId(AppBroadcast.drawerRefresherId)!.update();
      //AppBroadcast.layoutPageKey.currentState?.scaffoldState.currentState?.closeDrawer();

      if (isCurrent && RouteTools.materialContext != null) {
        RouteTools.backToRoot(RouteTools.getTopContext()!);

        Future.delayed(const Duration(milliseconds: 400), (){
          AppBroadcast.reBuildMaterial();
        });
      }
    }
  }

  static Future forceLogoffAll() async {
    while(SessionService.hasAnyLogin()){
      final lastUser = SessionService.getLastLoginUser();

      if(lastUser != null) {
        /*if (lastUser.email != null) {
          final google = GoogleService();
          await google.signOut();
        }*/
      }
    }

    await SessionService.logoffAll();

    UpdaterController.forId(AppBroadcast.drawerRefresherId)!.update();
    //AppBroadcast.layoutPageKey.currentState?.scaffoldState.currentState?.closeDrawer();

    if (RouteTools.materialContext != null) {
      RouteTools.backToRoot(RouteTools.getTopContext()!);

      Future.delayed(const Duration(milliseconds: 400), (){
        AppBroadcast.reBuildMaterial();
        //RouteTools.pushReplacePage(RouteTools.getTopContext()!, LoginPage());
      });
    }
  }

  /*static Future<Map?> requestSendOtp({required CountryModel countryModel, required String phoneNumber}) async {
    final http = HttpItem();
    final result = Completer<Map?>();

    final js = {};
    js[Keys.mobileNumber] = phoneNumber;
    js.addAll(countryModel.toMap());

    http.fullUrl = ApiManager.serverApi;
    http.method = 'POST';
    http.setBodyJson(js);

    final request = AppHttpDio.send(http);

    var f = request.response.catchError((e){
      result.complete(null);

      return null;
    });

    f = f.then((Response? response){
      if(response == null || !request.isOk) {
        result.complete(null);
        return;
      }

      result.complete(request.getBodyAsJson());
      return null;
    });

    return result.future;
  }
*/

  static void authenticate(Uri uri2, String clientId, List<String> scopes) async {
    final uri = Uri.parse('https://192.168.70.194:5001/');

    final issuer = await Issuer.discover(uri);
    //final client = Client(issuer, clientId, clientSecret: 'rnUsoPf86K');
    final client = Client(issuer, 'flutter_test');

    urlLauncher(String url) async {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.platformDefault);
      }
      else {
        throw 'Could not launch $url';
      }
    }


    var authenticator = Authenticator(
        client,
        scopes: ['profile', 'openid'],
        urlLancher: urlLauncher,
        //port: 5001,
        //redirectUri: Uri.parse('gclprojects.chunlin.myapp:/oauth2callback')
    );

    final res = await authenticator.authorize();
    print(res.toString());
    print('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@');

    //return await c.getUserInfo();

    /*final result = await FlutterWebAuth.authenticate(
      url: "https://api.worldoftanks.eu/wot/auth/login/?application_id=XXXe272eXXXac833eXXXf093d032c7fe&display=popup",
      callbackUrlScheme: "",
    );*/
  }
}
